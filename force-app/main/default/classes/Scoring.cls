public with sharing class Scoring {
  // Positive Weights

  // example metric: ratings
  // ratingPercentile = service rating / (orgMax - orgMin)

  // example metric: total referrals
  // orgReferralsPercentile: service referrals / (orgMax - orgMin)

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

  // calculate metrics class
  // iterate the metrics

  // calcualte all the scoring
  public static void scoreAllServices() {
    // container for the updates
    Metadata.DeployContainer mdContainer = new Metadata.DeployContainer();

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
    ]) {
      list<AggregateResult> results = database.query(
        metricIterator.Org_SOQL_Query__c
      );
      // default order is ASC, so [0] is min and last is max
      if (!results.isEmpty()) {
        Metadata.CustomMetadata recordToUpdate = new Metadata.CustomMetadata();
        recordToUpdate.fullName =
          'Scoring_Metric.' + metricIterator.DeveloperName;
        recordToUpdate.label = metricIterator.DeveloperName;

        Metadata.CustomMetadataValue orgMin = new Metadata.CustomMetadataValue();
        orgMin.field = 'Org_Minimum__c';
        orgMin.value = (decimal) results[0].get('metric');
        recordToUpdate.values.add(orgMin);

        Metadata.CustomMetadataValue orgMax = new Metadata.CustomMetadataValue();
        orgMax.field = 'Org_Maximum__c';
        orgMax.value = (decimal) results[results.size() - 1].get('metric');
        recordToUpdate.values.add(orgMax);

        mdContainer.addMetadata(recordToUpdate);
      }
    }
    // apply the update
    CustomMetadataCallback callback = new customMetadataCallback();
    Metadata.Operations.enqueueDeployment(mdContainer, callback);
  }
}

// Scoring.scoreAllServices();

