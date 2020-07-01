public with sharing class Scoring {
  // Positive Weights

  // example metric: my referrals
  // myReferralsPercentile: service referrals / (orgMax - orgMin)

  // Negative Weights

  // example metric: service-level-hides
  // hidesPercentile = service hides / (orgMax - orgMin)

  // example metric: contact-level-hides
  // hidesPercentile = service hides / (orgMax - orgMin)

  // Metric__c
  // Description__c
  // Based on Service Field
  // Org_Minimum__c
  // Org_Maximum__c
  // Org-level (boolean) // this record is an org-level stat
  // Calculate User-level (boolean) // there *Should* be one for each user
  // Specific User // if not org level, which user this applies to
  // Weighting (0-10)
  // Org Soql query (string)
  // Service-level SOQL Query

  // Scoring.scoreRecommendations(getRecommendations.getRecommendations([select Id from contact where firstname='Shane'].Id));
  public static list<ServiceRecommendation> scoreRecommendations(
    list<ServiceRecommendation> recs
  ) {
    // get the serviceIDs
    list<id> serviceIds = getRecommendations.IDsFromRecommendations(recs);
    // gets the total of all the weights so we only have to make one pass on the recs list
    decimal weightTotal = 0;

    list<Scoring_Metric__mdt> metrics = [
      SELECT
        Label,
        Org_Minimum__c,
        Org_Maximum__c,
        Org_SOQL_Query__c,
        Service_Level_SOQL_Query__c,
        QualifiedApiName,
        NamespacePrefix,
        DeveloperName,
        Weighting__c
      FROM Scoring_Metric__mdt
      WHERE
        Weighting__c != 0
        AND Org_Level__c = true
        AND Org_Minimum__c != null
        AND Org_Maximum__c != null
    ];

    for (Scoring_Metric__mdt metricIterator : metrics) {
      weightTotal = weightTotal + metricIterator.Weighting__c;
    }

    for (Scoring_Metric__mdt metricIterator : metrics) {
      map<id, AggregateResult> queryResults = new Map<id, AggregateResult>();
      //for each metric, get the stat for relevant services
      if (metricIterator.Service_Level_SOQL_Query__c != null) {
        queryResults = new Map<id, AggregateResult>(
          (list<AggregateResult>) database.query(
            metricIterator.Service_Level_SOQL_Query__c
          )
        );
      }
      decimal serviceValue;
      decimal spread =
        metricIterator.Org_Maximum__c - metricIterator.Org_Minimum__c;
      // we'll not assign any points if there is nothing to base it on
      if (spread != 0) {
        // do a percentile-based conversion for each metric
        for (ServiceRecommendation rec : recs) {
          AggregateResult result = queryResults.get(rec.ServiceId);
          if (result != null) {
            // the result was found from the aggregateQuery
            serviceValue = (decimal) result.get('metric');
          } else if (rec.getValue(metricIterator.Label) != null) {
            // the metric has a matching property on the ServiceRecommendationObject (ex: Distance) that is populated
            serviceValue = (decimal) rec.getValue(metricIterator.Label);
          } else if (rec.Matches.contains(metricIterator.Label)) {
            serviceValue = 1;
          } else {
            continue;
          }

          if (serviceValue != null) {
            // still here?  we must have a service value.  Create and calculate the new indicator
            ServiceRecommendation.Indicator indicator = new ServiceRecommendation.Indicator();
            indicator.IndicatorType = metricIterator.Label;
            // base percentile * this metric's share of the total weight
            indicator.IndicatorValue = string.valueOf(serviceValue);
            indicator.IndicatorPercentile = Math.round(
              ((serviceValue - metricIterator.Org_Minimum__c) / spread) *
              (metricIterator.Weighting__c / weightTotal) *
              100
            );
            Rec.Indicators.add(indicator);
            Rec.Relevance = Rec.Relevance + indicator.IndicatorPercentile;
          }
        }
      }
    }

    // round all the relevance scores now
    for (ServiceRecommendation rec : recs) {
      rec.Relevance = Math.round(rec.Relevance);
    }
    return recs;
  }

  // Scoring.scoreAllServices();
  public static void scoreAllServices() {
    // iterate all metrics
    for (Scoring_Metric__mdt metricIterator : [
      SELECT
        Org_Minimum__c,
        Org_Maximum__c,
        Org_SOQL_Query__c,
        QualifiedApiName,
        NamespacePrefix,
        DeveloperName
      FROM Scoring_Metric__mdt
      WHERE Weighting__c != 0
    ]) {
      if (metricIterator.Org_SOQL_Query__c != null) {
        list<AggregateResult> results = database.query(
          metricIterator.Org_SOQL_Query__c
        );
        // default order is ASC, so [0] is min and last is max
        if (!results.isEmpty()) {
          // container for the updates
          Metadata.DeployContainer mdContainer = new Metadata.DeployContainer();

          Metadata.CustomMetadata recordToUpdate = new Metadata.CustomMetadata();
          recordToUpdate.fullName =
            'Scoring_Metric.' + metricIterator.DeveloperName;
          recordToUpdate.label = metricIterator.DeveloperName;

          Metadata.CustomMetadataValue orgMin = new Metadata.CustomMetadataValue();
          orgMin.field = 'Org_Minimum__c';
          orgMin.value = (decimal) results[0].get('metric');
          if (orgMin.value == null) {
            orgMin.value = 0;
          }
          recordToUpdate.values.add(orgMin);

          Metadata.CustomMetadataValue orgMax = new Metadata.CustomMetadataValue();
          orgMax.field = 'Org_Maximum__c';
          orgMax.value = (decimal) results[results.size() - 1].get('metric');
          if (orgMax.value == null) {
            orgMax.value = 0;
          }
          recordToUpdate.values.add(orgMax);

          mdContainer.addMetadata(recordToUpdate);
          // apply the update, but not during tests
          CustomMetadataCallback callback = new customMetadataCallback();
          if (!Test.isRunningTest()) {
            Metadata.Operations.enqueueDeployment(mdContainer, callback);
          }
        }
      }
    }
  }
}
