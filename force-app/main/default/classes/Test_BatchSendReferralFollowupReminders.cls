@IsTest
public class Test_BatchSendReferralFollowupReminders {

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

        Service__c svc1 = new Service__c (
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
        insert svc1;

        Referral__c ref1 = new Referral__c (
            Contact__c = cont.Id,
            Preferred_Channel__c = 'SMS',
            Score__c = 5,
            Service__c = svc1.Id
        );
        insert ref1;    
        
        Task task1 = new Task(
            Subject = 'Reminder',
            ActivityDate = System.today(),
            WhatId = ref1.Id
        );
        insert task1;

        Service__c svc2 = new Service__c (
            Name = 'Test Another Service',
            City__c = 'Dallas',
            Description__c = 'Another Test Service for Testing',
            Maximum_Age__c = 100,
            Minimum_Age__c = 12,
            Phone__c = '4155551212',
            Street__c = '555 Main Street',
            Type__c = 'Food',
            Website__c = 'testing@testservice.org',
            Zip_Code__c = '12345'
        );
        insert svc2;

        Referral__c ref2 = new Referral__c (
            Contact__c = cont.Id,
            Preferred_Channel__c = 'Email',
            Score__c = 2,
            Service__c = svc2.Id
        );
        insert ref2; 

        Task task2 = new Task(
            Subject = 'Reminder',
            ActivityDate = System.today(),
            WhatId = ref2.Id
        );
        insert task2;
       
    }

    static testMethod void testSendFollowups(){
        
        Test.startTest();
        Batch_SendReferralFollowupReminders batch = new Batch_SendReferralFollowupReminders();
        Database.executeBatch(batch);
        Test.stopTest();
        
        List<Referral_Response__c> refResponses = getReferralResponses();
        System.assertEquals(2, refResponses.size());
    }

    private static List<Referral_Response__c> getReferralResponses() {
        List<Referral_Response__c> refResponses = [
            SELECT
                Id,
                Referral__c
            FROM Referral_Response__c
         ];
        return refResponses;
    }    
}