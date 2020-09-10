public with sharing class getRecommendations {
  @AuraEnabled
  public static list<ServiceRecommendation> getRecommendations(id contactId) {
    Client_Profile__c CP = getProfile(contactId);
    List<Service__c> services = getRecommendationsServiceQuery.primaryQuery(CP);
    System.debug('services' + services);
    // convert to ServiceRecommendation
    list<ServiceRecommendation> output = servicesToRecommendations(services);

    // do the hours for each service
    output = addHours(output);
    // figure out which services to hide
    output = addHides(output, contactId);
    // do the comments for each service
    output = getComments(output);
    // do the Star Rating for each service
    output = addStars(output);
    output = addReferralCount(output);
    output = addMatches(output, CP);
    // final Relevancy score + factors
    output = Scoring.scoreRecommendations(output);

    return output;
  }

  public static List<ServiceRecommendation> servicesToRecommendations(
    List<Service__c> services
  ) {
    List<ServiceRecommendation> output = new List<ServiceRecommendation>();
    for (Service__c service : services) {
      ServiceRecommendation SR = new ServiceRecommendation();
      SR.Service = service;
      SR.AllTypes = service.All_Types__c == null
        ? null
        : service.All_Types__c.split(';');
      SR.Distance = (decimal) service.get('dist');
      SR.Relevance = 0;
      SR.Matches = new List<String>();
      SR.ServiceId = service.Id;
      SR.ProviderName = service.Account__r.Name;
      SR.AccountId = service.Account__c;
      SR.ProgramName = service.Name;
      SR.ProgramType = service.Type__c;
      SR.ProgramDescription = service.Description__c;
      SR.TodaysHours = null;
      SR.MailingStreet = service.Street__c;
      SR.MailingCity = service.City__c;
      SR.Website = service.Website__c;
      SR.ServicePhone = service.Phone__c;
      SR.ServiceTags = service.Service_Tags__c;
      SR.SituationTags = service.Situation_Tags__c;
      SR.Hidden = false;
      SR.HiddenAll = false;
      SR.totalRatings = 0;
      SR.Indicators = new List<ServiceRecommendation.Indicator>();
      SR.Comments = new List<ServiceRecommendation.Comment>();
      SR.Preferred = service.Preferred__c ? 1 : 0; //translate checkbox to 1,0 value
      output.add(SR);
    }
    return output;
  }

  public static List<ServiceRecommendation> addReferralCount(
    List<ServiceRecommendation> recs
  ) {
    map<id, integer> referralCountsByService = new Map<id, integer>();
    for (AggregateResult result : [
      SELECT Service__c, Count(Id) referralCount
      FROM Referral__c
      WHERE Service__c IN :IDsFromRecommendations(recs)
      GROUP BY Service__c
    ]) {
      referralCountsByService.put(
        (id) result.get(UTIL_Namespace.StrTokenNSPrefix('Service__c')),
        (integer) result.get('referralCount')
      );
    }
    for (ServiceRecommendation rec : recs) {
      rec.ReferralCount = referralCountsByService.get(rec.ServiceId);
    }
    return recs;
  }
  // would rather spend one more query to use aggregates than an unknown number of query rows
  public static List<ServiceRecommendation> addStars(
    List<ServiceRecommendation> recs
  ) {
    map<id, decimal> ratingsAverageByService = new Map<id, decimal>();
    map<id, integer> ratingsCountByService = new Map<id, integer>();
    for (AggregateResult result : [
      SELECT Service__c, AVG(Score__c) averageScore, Count(Id) ratingsCount
      FROM Referral__c
      WHERE Service__c IN :IDsFromRecommendations(recs) AND Score__c != null
      GROUP BY Service__c
    ]) {
      ratingsAverageByService.put(
        (id) result.get(UTIL_Namespace.StrTokenNSPrefix('Service__c')),
        (decimal) result.get('averageScore')
      );
      ratingsCountByService.put(
        (id) result.get(UTIL_Namespace.StrTokenNSPrefix('Service__c')),
        (integer) result.get('ratingsCount')
      );
    }
    for (ServiceRecommendation rec : recs) {
      rec.Rating = ratingsAverageByService.get(rec.ServiceId);
      if (rec.Rating != null) {
        rec.Rating = Math.round(rec.Rating * 10) / 10;
      }
      rec.totalRatings = ratingsCountByService.get(rec.ServiceId);
      if (rec.totalRatings == null) {
        rec.totalRatings = 0;
      }
    }
    return recs;
  }

  public static list<ServiceRecommendation> addMatches(
    List<ServiceRecommendation> recs,
    Client_Profile__c CP
  ) {
    for (ServiceRecommendation rec : recs) {
      // housing fields are all checkboxes on both sides
      if (rec.Service.Homeless__c && CP.Homeless__c) {
        rec.Matches.add('Homeless');
      }
      if (rec.Service.Near_Homeless__c && CP.Near_Homeless__c) {
        rec.Matches.add('NearHomeless');
      }
      if (rec.Service.Runaway__c && CP.Runaway__c) {
        rec.Matches.add('Runaway');
      }
      if (rec.Service.Home_Owner__c && CP.Home_Owner__c) {
        rec.Matches.add('Owner');
      }
      if (rec.Service.Home_Renter__c && CP.Home_Renter__c) {
        rec.Matches.add('Renter');
      }
      // employment field is checkboxes on service and picklist on profile
      if (rec.Service.Unemployed__c && CP.Employment__c == 'Unemployed') {
        rec.Matches.add('Unemployed');
      }
      if (rec.Service.Retired__c && CP.Employment__c == 'Retired') {
        rec.Matches.add('Retired');
      }
      if (
        rec.Service.Employed_full_time__c &&
        CP.Employment__c == 'Employed full-time'
      ) {
        rec.Matches.add('Employed full-time');
      }
      if (
        rec.Service.Employed_part_time__c &&
        CP.Employment__c == 'Employed part-time'
      ) {
        rec.Matches.add('Employed part-time');
      }
    }
    return recs;
  }

  public static list<ServiceRecommendation> addHides(
    List<ServiceRecommendation> recs,
    id contactId
  ) {
    // build a map of exclusions for each service ID that the running user has created at the service or contact+service level
    map<id, list<Service_Exclusion__c>> exclusionsByService = new Map<id, list<Service_Exclusion__c>>();
    for (Service_Exclusion__c exclusion : [
      SELECT id, Service__c, Contact__c
      FROM Service_Exclusion__c
      WHERE
        CreatedById = :UserInfo.getUserId()
        AND Service__c IN :IDsFromRecommendations(recs)
        AND (Contact__c = null
        OR Contact__c = :contactId)
      ORDER BY Service__c
    ]) {
      list<Service_Exclusion__c> existing = exclusionsByService.get(
        exclusion.Service__c
      );
      if (existing == null) {
        existing = new List<Service_Exclusion__c>();
      }
      existing.add(exclusion);
      exclusionsByService.put(exclusion.Service__c, existing);
    }
    // iterate the recommendations
    for (ServiceRecommendation rec : recs) {
      // get the exclusions for this service
      list<Service_Exclusion__c> exclusions = exclusionsByService.get(
        rec.ServiceId
      );
      if (exclusions != null && exclusions.size() > 0) {
        for (Service_Exclusion__c exclusion : exclusions) {
          if (exclusion.Contact__c == null) {
            rec.HiddenAll = true;
          } else {
            rec.Hidden = true;
          }
        }
      }
    }
    return recs;
  }

  public static List<ServiceRecommendation> getComments(
    List<ServiceRecommendation> recs
  ) {
    list<FeedItem> FeedItems = [
      SELECT id, ParentId, Body
      FROM FeedItem
      WHERE ParentId IN :IDsFromRecommendations(recs) AND Type = 'TextPost'
      WITH SECURITY_ENFORCED
      ORDER BY ParentId
    ];
    map<id, list<string>> feedItemsByService = new Map<id, list<string>>();
    for (feedItem fi : FeedItems) {
      list<string> existing = feedItemsByService.get(fi.ParentId);
      if (existing == null) {
        existing = new List<string>();
      }
      existing.add(fi.Body);
      feedItemsByService.put(fi.ParentId, existing);
    }

    for (ServiceRecommendation rec : recs) {
      list<string> comments = feedItemsByService.get(rec.ServiceId);
      if (comments != null && comments.size() > 0) {
        for (string comment : comments) {
          ServiceRecommendation.Comment commentToAdd = new ServiceRecommendation.Comment();
          commentToAdd.CommentText = comment;
          rec.Comments.add(commentToAdd);
        }
      }
    }
    return recs;
  }

  @AuraEnabled
  public static String addNewComment(id serviceId, String newComment) {
    list<FeedItem> feeditems = new List<FeedItem>();
    FeedItem newFeedItem = new FeedItem();
    newFeedItem.ParentId = serviceId;
    newFeedItem.Body = newComment;
    newFeedItem.Type = 'TextPost';
    feeditems.add(newFeedItem);
    SObjectAccessDecision securityDecision = Security.stripInaccessible(
      AccessType.CREATABLE,
      feeditems
    );
    insert securityDecision.getRecords();
    return securityDecision.getRecords()[0].id;
  }

  public static List<ServiceRecommendation> addHours(
    List<ServiceRecommendation> recs
  ) {
    map<id, Open_Hours__c> hours = getHoursByService(
      IDsFromRecommendations(recs)
    );
    for (ServiceRecommendation SR : recs) {
      SR.TodaysHours = hours.get(SR.ServiceId);
      System.debug(hours.get(SR.ServiceId));
      if (hours.get(SR.ServiceId) != null) {
        SR.TodaysEndHours = hours.get(SR.serviceId).End_Time__c;
      }
    }
    return recs;
  }

  public static Client_Profile__c getProfile(id contactId) {
    Client_Profile__c output = [
      SELECT
        id,
        Date_Of_Birth__c,
        Location__Latitude__s,
        Location__Longitude__s,
        Near_Homeless__c,
        Homeless__c,
        Runaway__c,
        Home_Owner__c,
        Home_Renter__c,
        Employment__c
      FROM Client_Profile__c
      WHERE Contact__c = :contactId
      WITH SECURITY_ENFORCED
    ];
    if (output.Location__Latitude__s == null) {
      output.Location__Latitude__s = [
        SELECT Default_Latitude__c
        FROM RefRecSettings__mdt
      ]
      .Default_Latitude__c;
    }
    if (output.Location__Longitude__s == null) {
      output.Location__Longitude__s = [
        SELECT Default_Longitude__c
        FROM RefRecSettings__mdt
      ]
      .Default_Longitude__c;
    }
    return output;
  }

  public static list<id> IDsFromRecommendations(
    List<ServiceRecommendation> recs
  ) {
    list<id> output = new List<id>();

    for (ServiceRecommendation rec : recs) {
      output.add(rec.ServiceId);
    }
    return output;
  }

  public static map<id, Open_Hours__c> getHoursByService(list<id> serviceIds) {
    map<id, Open_Hours__c> output = new Map<id, Open_Hours__c>();
    for (Open_Hours__c hours : [
      SELECT Day__c, End_Time__c, Service__c, Start_Time__c
      FROM Open_Hours__c
      WHERE Service__c IN :serviceIds AND Day__c = :whatDayIsIt()
    ]) {
      output.put(hours.Service__c, hours);
    }
    return output;
  }

  public static string whatDayIsIt() {
    list<string> days = new List<string>{
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    };
    Date monday = Date.newInstance(1900, 1, 1);
    return days[Math.mod(monday.daysBetween(system.today()), 7)];
  }
}
