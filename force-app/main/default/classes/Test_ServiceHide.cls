@isTest
private with sharing class Test_ServiceHide {
  static testMethod void hideForContact() {
    id contactId = getTestContactId();
    id serviceId = getTestServiceId();

    test.startTest();
    serviceHide.hide(serviceId, contactId);
    test.stopTest();

    list<Service_Exclusion__c> exclusions = getExclusions(serviceId, contactId);
    system.assertEquals(1, exclusions.size());
    system.assertEquals(contactId, exclusions[0].Contact__c);
    system.assertEquals(serviceId, exclusions[0].Service__c);
  }

  static testMethod void unhideForContact() {
    id contactId = getTestContactId();
    id serviceId = getTestServiceId();

    test.startTest();
    serviceHide.hide(serviceId, contactId);
    serviceHide.unHide(serviceId, contactId);
    test.stopTest();

    list<Service_Exclusion__c> exclusions = getExclusions(serviceId, contactId);
    system.assertEquals(0, exclusions.size());
  }

  static testMethod void hideForAll() {
    id serviceId = getTestServiceId();

    test.startTest();
    serviceHide.hide(serviceId, null);
    test.stopTest();

    list<Service_Exclusion__c> exclusions = getExclusions(serviceId, null);
    system.assertEquals(1, exclusions.size());
    system.assertEquals(null, exclusions[0].Contact__c);

    system.assertEquals(serviceId, exclusions[0].Service__c);
  }

  static testMethod void unhideForAll() {
    id serviceId = getTestServiceId();

    test.startTest();
    serviceHide.hide(serviceId, null);
    serviceHide.unHide(serviceId, null);
    test.stopTest();

    list<Service_Exclusion__c> exclusions = getExclusions(serviceId, null);
    system.assertEquals(0, exclusions.size());
  }

  private static list<Service_Exclusion__c> getExclusions(
    Id serviceId,
    Id contactId
  ) {
    return [SELECT id, Service__c, Contact__c FROM Service_Exclusion__c];
  }

  private static Id getTestContactId() {
    return [SELECT id FROM Contact WHERE LastName = 'TestContact'].Id;
  }

  private static Id getTestServiceId() {
    return [SELECT id FROM Service__c WHERE Name = 'Test Service for Hiding']
    .Id;
  }
  @testSetup
  static void makeData() {
    contact c = new Contact();
    c.LastName = 'TestContact';
    insert c;

    Service__c s = new Service__c();
    s.Name = 'Test Service for Hiding';
    insert s;
  }
}
