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
  // if
}
