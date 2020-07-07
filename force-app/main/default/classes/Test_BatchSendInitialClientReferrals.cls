@IsTest
public class Test_BatchSendInitialClientReferrals {

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

    static testMethod void testSendMessages() {
        Referral__c ref = getReferral();

        Test.startTest();
        Batch_SendInitialClientReferrals batch = new Batch_SendInitialClientReferrals();
        Database.executeBatch(batch);
        Test.stopTest();

        Referral_Response__c refResp = getReferralResponse(ref.Id);
        System.assertEquals(ref.Id, refResp.Referral__c);
    }

    private static Referral__c getReferral() {
        Referral__c ref = [
            SELECT
                Id,
                Contact__c,
                Preferred_Channel__c
            FROM Referral__c
            WHERE Contact__r.LastName = 'Tester'
        ][0];
        return ref;
    }

    private static Referral_Response__c getReferralResponse(Id referralId) {
        Referral_Response__c refResp = [
            SELECT
                Id,
                Referral__c
            FROM Referral_Response__c
            WHERE Referral__c = :referralId
        ][0];
        return refResp;
    }    
}
