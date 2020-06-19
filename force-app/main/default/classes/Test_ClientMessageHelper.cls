@IsTest
public class Test_ClientMessageHelper {

    @TestSetup
    static void makeData(){
        Contact cont = new Contact (
            FirstName = 'Test',
            LastName = 'Tester',
            Email = 'testy@tester.org',
            Phone = '8885551212',
            MobilePhone = '8005551212',
            Mobile_Phone_Carrier__c = 'AT&T'
        );
        insert cont;

        Service__c svc = new Service__c (
            Name = 'Test Service',
            City__c = 'Boston',
            Description__c = 'Test Service for Testing',
            Maximum_Age__c = 100,
            Minimum_Age__c = 12,
            Phone__c = '4155551212',
            Street__c = '123 Main Street',
            Type__c = 'Care',
            Website__c = 'testing@testservice.org',
            Zip_Code__c = '12345'
        );
        insert svc;

        Referral__c ref = new Referral__c (
            Contact__c = cont.Id,
            Preferred_Channel__c = 'SMS',
            Score__c = 5,
            Service__c = svc.Id
        );
        insert ref;
        
    }

    static testMethod void testCreateInitialClientReferralEmails() {
        Referral__c ref = [
            SELECT
                Id,
                Contact__c
            FROM Referral__c
        ][0];

        Map<Id,Referral__c> referralMap = new Map<Id,Referral__c>();
        referralMap.put(ref.Id,ref);

        Test.startTest();
        List<Messaging.SingleEmailMessage> messages = ClientMessageHelper.createInitialClientReferralEmails(referralMap);
        Test.stopTest();
        
        System.assertEquals(ref.Id,messages[0].getWhatId());
    }

    static testMethod void testCreateReferralFollowupEmails() {
        Referral__c ref = [
            SELECT
                Id,
                Contact__c
            FROM Referral__c
        ][0];

        Map<Id,Referral__c> referralMap = new Map<Id,Referral__c>();
        referralMap.put(ref.Id,ref);

        Test.startTest();
        List<Messaging.SingleEmailMessage> messages = ClientMessageHelper.createReferralFollowupEmails(referralMap);
        Test.stopTest();
        
        System.assertEquals(ref.Id,messages[0].getWhatId());
    }

    static testMethod void testCreateReferralRateServiceEmails() {
        Referral__c ref = [
            SELECT
                Id,
                Contact__c
            FROM Referral__c
        ][0];

        Map<Id,Referral__c> referralMap = new Map<Id,Referral__c>();
        referralMap.put(ref.Id,ref);

        Test.startTest();
        List<Messaging.SingleEmailMessage> messages = ClientMessageHelper.createReferralRateServiceEmails(referralMap);
        Test.stopTest();
        
        System.assertEquals(ref.Id,messages[0].getWhatId());       
    }

    static testMethod void testCreateClientHelpResponseEmails() {
        Referral__c ref = [
            SELECT
                Id,
                Contact__c
            FROM Referral__c
        ][0];

        Map<Id,Referral__c> referralMap = new Map<Id,Referral__c>();
        referralMap.put(ref.Id,ref);

        Test.startTest();
        List<Messaging.SingleEmailMessage> messages = ClientMessageHelper.createClientHelpResponseEmails(referralMap);
        Test.stopTest();
        
        System.assertEquals(ref.Id,messages[0].getWhatId());       
    }

    static testMethod void testCreateClientCantConnectEmails() {
        Referral__c ref = [
            SELECT
                Id,
                Contact__c
            FROM Referral__c
        ][0];

        Map<Id,Referral__c> referralMap = new Map<Id,Referral__c>();
        referralMap.put(ref.Id,ref);

        Test.startTest();
        List<Messaging.SingleEmailMessage> messages = ClientMessageHelper.createClientCantConnectEmails(referralMap);
        Test.stopTest();
        
        System.assertEquals(ref.Id,messages[0].getWhatId());       
    }

    static testMethod void testGetContactEmailMap() {
        Referral__c ref = [
            SELECT
                Id,
                Contact__c
            FROM Referral__c
        ][0];

        Map<Id,Referral__c> referralMap = new Map<Id,Referral__c>();
        referralMap.put(ref.Id,ref);

        List<Messaging.SingleEmailMessage> messages = ClientMessageHelper.createInitialClientReferralEmails(referralMap);
        
        Test.startTest();
        Map<Id,Messaging.SingleEmailMessage> emailMap = ClientMessageHelper.getContactEmailMap(messages);
        Test.stopTest();
        
        System.assertEquals(ref.Id,emailMap.get(ref.Contact__c).getWhatId());
    }

    static testMethod void testGetReferralRecords() {
        Referral__c ref = [
            SELECT
                Id,
                Contact__c
            FROM Referral__c
        ][0];

        List<Id> referralIds = new List<Id>();
        referralIds.add(ref.Id);

        Test.startTest();
        Map<Id, Referral__c> referralMap = ClientMessageHelper.getReferralRecords(referralIds);
        Test.stopTest();

        System.assertEquals(ref.Contact__c,referralMap.get(ref.Id).Contact__c);
    }

}
