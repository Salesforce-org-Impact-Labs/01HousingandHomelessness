public with sharing class getRecommendations {
  // default version...uses the clientProfileId
  @AuraEnabled
  public static list<ServiceRecommendation> getRecommendations(id contactId) {
    Client_Profile__c CP = getProfile(contactId);
    List<Service__c> services = primaryQuery(CP);

    // convert to ServiceRecommendation
    list<ServiceRecommendation> output = servicesToRecommendations(services);

    // do the hours for each service
    output = addHours(output);
    // do the comments for each service

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
        Zip_Code__c
      FROM Service__c
      WHERE
        (Minimum_Age__c = null
        OR Minimum_Age__c < :age)
        AND (Maximum_Age__c = null
        OR Maximum_Age__c > :age)
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
      output.add(SR);
    }
    return output;
  }

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

  public static list<ServiceRecommendation> finalScores(
    List<ServiceRecommendation> recs
  ) {
    for (ServiceRecommendation rec : recs) {
      // TODO: do real scoring!
      rec.Relevance = Integer.valueof((Math.random() * 100));
    }
    return recs;
  }

  public static List<ServiceRecommendation> addHours(
    List<ServiceRecommendation> recs
  ) {
    map<id, Open_Hours__c> hours = gerHoursByService(
      IDsFromRecommendations(recs)
    );
    for (ServiceRecommendation SR : recs) {
      SR.TodaysHours = hours.get(SR.ServiceId);
    }
    return recs;
  }

  public static Client_Profile__c getProfile(id contactId) {
    return [
      SELECT id, Date_Of_Birth__c
      FROM Client_Profile__c
      WHERE Contact__c = :contactId
    ];
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

  public static map<id, Open_Hours__c> gerHoursByService(list<id> serviceIds) {
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
