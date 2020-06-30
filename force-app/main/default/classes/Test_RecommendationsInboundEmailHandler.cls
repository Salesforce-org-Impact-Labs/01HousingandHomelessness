@IsTest
public class Test_RecommendationsInboundEmailHandler {

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
            Service__c = svc.Id
        );
        insert ref;
    }
    static testMethod void testSaveReferralScore() {
        Referral__c preReferral = getReferral();

        Test.startTest();
        ReferralResponseHelper.saveReferralScore(preReferral.Id, 4);
        Test.stopTest();

        Referral__c postReferral = getReferral();
        System.assertEquals(4, postReferral.Score__c);
    }

    static Referral__c getReferral() {
        List<Referral__c> referrals = [
            SELECT
                Id,
                Score__c
            FROM Referral__c
            WHERE Contact__r.LastName = 'Tester'
        ];    
        return referrals[0];    
    }
}
