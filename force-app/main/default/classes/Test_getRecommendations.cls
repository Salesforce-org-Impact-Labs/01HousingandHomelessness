@IsTest
public with sharing class Test_getRecommendations {
  static final integer startHour = 9;
  static final integer endHour = 17;
  static final string goodServiceName = 'The good service';
  static final string badServiceName = 'The service nobody likes';
  static final decimal lat = 37.7897;
  static final decimal lon = -122.397;

  static testMethod void testAddComment() {
    test.startTest();
    id newFeedItemId = getRecommendations.addNewComment(
      getbadServiceId(),
      'not that great'
    );
    test.stopTest();

    FeedItem post = [
      SELECT id, type, parentid
      FROM FeedItem
      WHERE id = :newFeedItemId
    ];
    system.assertEquals(getbadServiceId(), post.ParentId);
  }

  static testMethod void GoodServiceLooksGood() {
    test.startTest();
    List<ServiceRecommendation> recs = getRecommendations.getRecommendations(
      getTestContact().Id
    );
    test.stopTest();

    integer goodServiceIndex = getRecommendationIndexByServiceName(
      recs,
      goodServiceName
    );
    system.assertEquals(5, recs[goodServiceIndex].Rating);
    system.assertEquals(false, recs[goodServiceIndex].Hidden);
    System.assertEquals(
      startHour,
      recs[goodServiceIndex].TodaysHours.Start_Time__c.hour()
    );
    System.assertEquals(
      endHour,
      recs[goodServiceIndex].TodaysHours.End_Time__c.hour()
    );
    System.assert(recs[goodServiceIndex].Relevance >= 0);
    System.assert(recs[goodServiceIndex].Relevance <= 100);
    System.assert(recs[goodServiceIndex].Distance >= 0);
    System.assertEquals(1, recs[goodServiceIndex].Preferred);

    System.assert(recs[goodServiceIndex].Matches.contains('Homeless'));
    System.assert(
      recs[goodServiceIndex].Matches.contains('Employed full-time')
    );
    System.assertEquals(1, recs[goodServiceIndex].Comments.size());
    System.assert(recs[goodServiceIndex].ReferralCount > 0);

    System.assertEquals(
      'It is great',
      recs[goodServiceIndex].Comments[0].CommentText
    );

    system.assertEquals(
      true,
      indicatorExists('Distance', recs[goodServiceIndex])
    );
    for (
      ServiceRecommendation.Indicator indicator : recs[goodServiceIndex]
        .Indicators
    ) {
      // check for preferred factor
      if (indicator.IndicatorType == 'Preferred') {
        system.assertEquals('1', indicator.IndicatorValue);
      }
      if (indicator.IndicatorType == 'Homeless') {
        system.assertEquals('1', indicator.IndicatorValue);
      }
      if (indicator.IndicatorType == 'Employed full-time') {
        system.assertEquals('1', indicator.IndicatorValue);
      }
    }
    // system.assert(DistanceMetricExists);
  }

  static testMethod void omitsTeenService() {
    test.startTest();
    List<ServiceRecommendation> recs = getRecommendations.getRecommendations(
      getTestContact().Id
    );
    test.stopTest();
    // you are too old for the teen service
    system.assertEquals(
      -1,
      getRecommendationIndexByServiceName(recs, 'The teen service')
    );
  }

  static testMethod void omitsFarService() {
    test.startTest();
    List<ServiceRecommendation> recs = getRecommendations.getRecommendations(
      getTestContact().Id
    );
    test.stopTest();
    // too far away!
    system.assertEquals(
      -1,
      getRecommendationIndexByServiceName(recs, 'FarService')
    );
  }

  static testMethod void badServiceVisibleWithoutExclusions() {
    test.startTest();
    List<ServiceRecommendation> recs = getRecommendations.getRecommendations(
      getTestContact().Id
    );
    test.stopTest();

    integer badServiceIndex = getRecommendationIndexByServiceName(
      recs,
      badServiceName
    );
    System.assertEquals(false, recs[badServiceIndex].Hidden);
  }

  static testMethod void badServiceHiddenWithContactLevelExclusion() {
    Service_Exclusion__c exclusion = new Service_Exclusion__c();
    exclusion.Service__c = getBadServiceId();
    exclusion.Contact__c = getTestContact().Id;

    insert exclusion;

    test.startTest();
    List<ServiceRecommendation> recs = getRecommendations.getRecommendations(
      getTestContact().Id
    );
    test.stopTest();

    integer badServiceIndex = getRecommendationIndexByServiceName(
      recs,
      badServiceName
    );
    System.assertEquals(true, recs[badServiceIndex].Hidden);
  }

  static testMethod void badServiceHiddenWithServiceLevelExclusion() {
    Service_Exclusion__c exclusion = new Service_Exclusion__c();
    exclusion.Service__c = getBadServiceId();
    insert exclusion;

    test.startTest();
    List<ServiceRecommendation> recs = getRecommendations.getRecommendations(
      getTestContact().Id
    );
    test.stopTest();

    integer badServiceIndex = getRecommendationIndexByServiceName(
      recs,
      badServiceName
    );
    System.assertEquals(true, recs[badServiceIndex].Hidden);
  }

  @testSetup
  static void makeData() {
    //   Create an Account
    Account Provider = new Account();
    Provider.Name = 'GetRecommendations Test Provider';
    insert Provider;

    // create a contact with a profile
    Contact c = new Contact();
    c.FirstName = 'testContact';
    c.LastName = 'Test_getRecommendations';
    c.BirthDate = Date.newInstance(1979, 4, 20);
    insert c;

    Client_Profile__c profile = new Client_Profile__c();
    profile.Contact__c = c.Id;
    profile.Date_of_Birth__c = c.BirthDate;
    profile.First_Name__c = c.Firstname;
    profile.Last_Name__c = c.LastName;
    profile.Location__Latitude__s = lat;
    profile.Location__Longitude__s = lon;
    profile.Homeless__c = true;
    profile.Employment__c = 'Employed full-time';
    insert Profile;

    // create 2 services
    List<Service__c> Services = new List<Service__c>();

    Service__c GoodService = new Service__c();
    GoodService.Account__c = Provider.Id;
    GoodService.Name = goodServiceName;
    GoodService.Preferred__c = true;
    GoodService.Location__Latitude__s = lat;
    GoodService.Location__Longitude__s = lon;
    GoodService.Homeless__c = true;
    GoodService.Employed_full_time__c = true;
    GoodService.Employed_part_time__c = true;
    Services.add(GoodService);

    Service__c TeenService = new Service__c();
    TeenService.Account__c = Provider.Id;
    TeenService.Name = 'The teen service';
    TeenService.Maximum_Age__c = 18;
    TeenService.Location__Latitude__s = lat;
    TeenService.Location__Longitude__s = lon;
    Services.add(TeenService);

    Service__c TheServiceNobodyLikes = new Service__c();
    TheServiceNobodyLikes.Account__c = Provider.Id;
    TheServiceNobodyLikes.Name = badServiceName;
    TheServiceNobodyLikes.Location__Latitude__s = lat;
    TheServiceNobodyLikes.Location__Longitude__s = lon;
    Services.add(TheServiceNobodyLikes);

    Service__c FarService = new Service__c();
    FarService.Account__c = Provider.Id;
    FarService.Name = 'FarService';
    FarService.Location__Latitude__s = 0;
    FarService.Location__Longitude__s = 0;
    Services.add(FarService);

    insert Services;

    // service plus hours
    Open_Hours__c hours = new Open_Hours__c();
    hours.Start_Time__c = Time.newInstance(startHour, 0, 0, 0);
    hours.End_Time__c = Time.newInstance(endHour, 0, 0, 0);
    hours.Service__c = GoodService.Id;
    hours.Day__c = getRecommendations.whatDayIsIt();
    insert hours;

    // service with comment
    FeedItem fi = new FeedItem();
    fi.Body = 'It is great';
    fi.Type = 'TextPost';
    fi.ParentId = GoodService.Id;
    insert fi;

    // referrals with scores
    Referral__c ref = new Referral__c();
    ref.Contact__c = c.Id;
    ref.Service__c = GoodService.Id;
    ref.Score__c = 5;
    ref.Preferred_Channel__c = 'Email';
    insert ref;

    Scoring.scoreAllServices();
  }

  private static contact getTestContact() {
    return [SELECT id FROM contact WHERE FirstName = 'testContact'];
  }

  private static integer getRecommendationIndexByServiceName(
    list<ServiceRecommendation> recs,
    string servicename
  ) {
    integer counter = -1;
    for (ServiceRecommendation rec : recs) {
      counter++;
      if (rec.ProgramName == servicename) {
        return counter;
      }
    }
    return -1; // never found a match
  }

  private static id getBadServiceId() {
    return [SELECT id FROM Service__c WHERE Name = :badServiceName].Id;
  }

  private static Boolean indicatorExists(
    string indicatorToFind,
    ServiceRecommendation SR
  ) {
    for (ServiceRecommendation.Indicator indicator : sr.Indicators) {
      if (indicator.IndicatorType == indicatorToFind) {
        return true;
      }
    }
    return false;
  }
}
