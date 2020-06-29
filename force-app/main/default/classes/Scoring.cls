public with sharing class Scoring {
  // Positive Weights

  // example metric: my referrals
  // myReferralsPercentile: service referrals / (orgMax - orgMin)

  // example metric: Preferred
  // true = 100, false = 0

  // Negative Weights

  // example metric: Distance
  // distancePercential: service distance / (orgMax - orgMin) from CMDT

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
        Weighting__c > 0
        AND Org_Level__c = true
        AND Org_Minimum__c != null
        AND Org_Maximum__c != null
    ];

    for (Scoring_Metric__mdt metricIterator : metrics) {
      weightTotal = weightTotal + metricIterator.Weighting__c;
    }
    // query CMDT for the metrics

    for (Scoring_Metric__mdt metricIterator : metrics) {
      //for each metric, get the stat for relevant services
      map<id, AggregateResult> results = new Map<id, AggregateResult>(
        (list<AggregateResult>) database.query(
          metricIterator.Service_Level_SOQL_Query__c
        )
      );
      decimal spread =
        metricIterator.Org_Maximum__c - metricIterator.Org_Minimum__c;
      // we'll not assign any points if there is nothing to base it on
      if (spread != 0) {
        // do a percentile-based conversion for each metric
        for (ServiceRecommendation rec : recs) {
          AggregateResult result = results.get(rec.ServiceId);
          if (result != null) {
            decimal serviceValue = (decimal) result.get('metric');
            // create and calculate the new indicator
            ServiceRecommendation.Indicator indicator = new ServiceRecommendation.Indicator();
            indicator.IndicatorType = metricIterator.Label;
            // base percentile * this metric's share of the total weight
            indicator.IndicatorValue = string.valueOf(serviceValue);
            indicator.IndicatorPercentile =
              ((serviceValue - metricIterator.Org_Minimum__c) / spread) *
              (metricIterator.Weighting__c / weightTotal);
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
      WHERE Weighting__c > 0
    ]) {
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
        // apply the update
        CustomMetadataCallback callback = new customMetadataCallback();
        Metadata.Operations.enqueueDeployment(mdContainer, callback);
      }
    }
  }
}
