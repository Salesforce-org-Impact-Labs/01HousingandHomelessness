public with sharing class getRecommendations {
  @AuraEnabled
  public static list<ServiceRecommendation> getRecommendations(id contactId) {
    Client_Profile__c CP = getProfile(contactId);
    List<Service__c> services = primaryQuery(CP);

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
    // final Relevancy score + factors
    output = finalScores(output);

    return output;
  }

  // list of services with any hard filters
  // hard filters are currently Age
  public static list<Service__c> primaryQuery(Client_Profile__c client) {
    decimal age = calculateAge(client.Date_Of_Birth__c);
    decimal defaultMaxDistance = [
      SELECT Default_Max_Distance__c
      FROM RefRecSettings__mdt
    ]
    .Default_Max_Distance__c;
    return [
      SELECT
        id,
        Name,
        Account__c,
        Account__r.Name,
        Description__c,
        City__c,
        Phone__c,
        Street__c,
        Type__c,
        Website__c,
        Zip_Code__c,
        Preferred__c
      FROM Service__c
      WHERE
        (Minimum_Age__c = null
        OR Minimum_Age__c < :age)
        AND (Maximum_Age__c = null
        OR Maximum_Age__c > :age)
        AND DISTANCE(
          Location__c,
          GEOLOCATION(:client.Location__Latitude__s,
            :client.Location__Longitude__s
          ),
          'mi'
        ) < :defaultMaxDistance
    ];
  }

  public static List<ServiceRecommendation> servicesToRecommendations(
    List<Service__c> services
  ) {
    List<ServiceRecommendation> output = new List<ServiceRecommendation>();
    for (Service__c service : services) {
      ServiceRecommendation SR = new ServiceRecommendation();
      SR.Relevance = 0;
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
      SR.Hidden = false;
      SR.Indicators = new List<ServiceRecommendation.Indicator>();
      SR.Comments = new List<ServiceRecommendation.Comment>();

      if (service.Preferred__c) {
        ServiceRecommendation.Indicator indicator = new ServiceRecommendation.Indicator();
        indicator.IndicatorType = 'Preferred Service';
        indicator.IndicatorValue = 'TRUE';
        SR.Indicators.add(indicator);
      }
      output.add(SR);
    }
    return output;
  }

  // would rather spend one more query to use aggregates than an unknown number of query rows
  public static List<ServiceRecommendation> addStars(
    List<ServiceRecommendation> recs
  ) {
    map<id, decimal> ratingsByService = new Map<id, decimal>();
    for (AggregateResult result : [
      SELECT Service__c, AVG(Score__c) averageScore
      FROM Referral__c
      WHERE Service__c IN :IDsFromRecommendations(recs) AND Score__c != null
      GROUP BY Service__c
    ]) {
      ratingsByService.put(
        (id) result.get('Service__c'),
        (decimal) result.get('averageScore')
      );
    }
    for (ServiceRecommendation rec : recs) {
      rec.Rating = ratingsByService.get(rec.ServiceId);
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
        rec.Hidden = true;
      }
    }
    return recs;
  }

  public static list<ServiceRecommendation> finalScores(
    List<ServiceRecommendation> recs
  ) {
    // somehow get the weighting for each category, probably cached
    // somehow get the org's min/max distribution for each numerical category, probably cached
    for (ServiceRecommendation rec : recs) {
      rec.Relevance = Integer.valueof((Math.random() * 100));
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
  public static List<ServiceRecommendation> addNewComment(id serviceId, String newComment){
    FeedItem newFeedItem = new  FeedItem();
    newFeedItem.ParentId = serviceId;
    newFeedItem.Body = newComment;
    newFeedItem.Type = 'TextPost';
  }

  public static List<ServiceRecommendation> addHours(
    List<ServiceRecommendation> recs
  ) {
    map<id, Open_Hours__c> hours = getHoursByService(
      IDsFromRecommendations(recs)
    );
    for (ServiceRecommendation SR : recs) {
      SR.TodaysHours = hours.get(SR.ServiceId);
    }
    return recs;
  }

  public static Client_Profile__c getProfile(id contactId) {
    Client_Profile__c output = [
      SELECT id, Date_Of_Birth__c, Location__Latitude__s, Location__Longitude__s
      FROM Client_Profile__c
      WHERE Contact__c = :contactId
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

  public static decimal calculateAge(Date DOB) {
    return DOB.daysBetween(system.today()) / 365;
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
