@IsTest
public with sharing class Test_getRecommendations {
  static final integer startHour = 9;
  static final integer endHour = 17;

  static testMethod void GoodServiceLooksGood() {
    test.startTest();
    List<ServiceRecommendation> recs = getRecommendations.getRecommendations(
      getTestContact().Id
    );
    test.stopTest();

    system.assertEquals(5, recs[0].Rating);
    system.assertEquals(false, recs[0].Hidden);
    System.assertEquals(startHour, recs[0].TodaysHours.Start_Time__c.hour());
    System.assertEquals(endHour, recs[0].TodaysHours.End_Time__c.hour());
    System.assert(recs[0].Relevance >= 0);
    System.assert(recs[0].Relevance <= 100);
  }

  static testMethod void omitsTeenService() {
    test.startTest();
    List<ServiceRecommendation> recs = getRecommendations.getRecommendations(
      getTestContact().Id
    );
    test.stopTest();
    // you are too old for the teen service
    for (ServiceRecommendation rec : recs) {
      system.assertNotEquals(rec.ProgramName, 'The teen service');
    }
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
    insert Profile;

    // create 2 services
    List<Service__c> Services = new List<Service__c>();

    Service__c GoodService = new Service__c();
    GoodService.Account__c = Provider.Id;
    GoodService.Name = 'The good service';
    Services.add(GoodService);

    Service__c TeenService = new Service__c();
    TeenService.Account__c = Provider.Id;
    TeenService.Name = 'The teen service';
    TeenService.Maximum_Age__c = 18;
    Services.add(TeenService);

    insert Services;

    // service plus hours
    Open_Hours__c hours = new Open_Hours__c();
    hours.Start_Time__c = Time.newInstance(startHour, 0, 0, 0);
    hours.End_Time__c = Time.newInstance(endHour, 0, 0, 0);
    hours.Service__c = GoodService.Id;
    hours.Day__c = getRecommendations.whatDayIsIt();
    insert hours;

    // service plus exclusions
    // referrals with scores
    Referral__c ref = new Referral__c();
    ref.Contact__c = c.Id;
    ref.Service__c = GoodService.Id;
    ref.Score__c = 5;
    ref.Preferred_Channel__c = 'Email';
    insert ref;
  }

  private static contact getTestContact() {
    return [SELECT id FROM contact WHERE FirstName = 'testContact'];
  }
}
