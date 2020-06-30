@isTest
private with sharing class Test_ServicePrint {
    @testSetup
    static void makeData() {
        contact c = new Contact();
        c.LastName = 'TestContact';
        insert c;

        Service__c s = new Service__c();
        s.Name = 'Test Service for Printing';
        insert s;
    }

    static testMethod void printReferral() {
        id contactId = getTestContactId();
        id serviceId = getTestServiceId();

        Test.StartTest();
        ServicePrint.PrintPage(serviceId);
        Test.StopTest();

        list<Attachment> attachs = [Select Id, Name FROM Attachment WHERE ParentId = :serviceId];
        System.assertEquals(1, attachs.size());
        System.assertEquals(attachs[0].ParentId, serviceId);
    }


    private static Id getTestContactId() {
        return [SELECT id FROM Contact WHERE LastName = 'TestContact'].Id;
    }

    private static Id getTestServiceId() {
        return [SELECT id FROM Service__c WHERE Name = 'Test Service for Printing'].Id;
    }
  
}
