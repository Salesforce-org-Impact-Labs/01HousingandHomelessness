@IsTest
public class Test_ReferralResponseHelper {

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

        Open_Hours__c open = new Open_Hours__c (
            Day__c = 'Monday',
            Start_Time__c = Time.newInstance(9, 0, 0, 0),
            End_Time__c = Time.newInstance(17, 0, 0, 0),
            Service__c = svc.Id
        );
        insert open;

        Referral__c ref = new Referral__c (
            Contact__c = cont.Id,
            Preferred_Channel__c = 'SMS',
            Score__c = 5,
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

    static testMethod void testCreateQuestionRecord() {
        Referral__c referral =  getReferral();

        Test.startTest();
        ReferralResponseHelper.createQuestionRecord(referral.Id, 'How are you doing?');
        Test.stopTest();

        List<Referral_Response__c> responses =  getReferralResponsesForReferrals(referral.Id);
        System.assertEquals('How are you doing?',responses[0].Question__c);
    }

    static testMethod void testUpdateRecordWithResponse() {
        Referral__c referral =  getReferral();
        ReferralResponseHelper.createQuestionRecord(referral.Id, 'How are you doing?');
        List<Referral_Response__c> responses =  getReferralResponsesForReferrals(referral.Id);

        Test.startTest();
        ReferralResponseHelper.updateRecordWithResponse(responses[0].Id, 'I am doing fine.');
        Test.stopTest();

        List<Referral_Response__c> responsesCheck =  getReferralResponsesForReferrals(referral.Id);
        System.assertEquals('I am doing fine.',responsesCheck[0].Response__c);
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

    static List<Referral_Response__c> getReferralResponsesForReferrals(Id referralId) {
        List<Referral_Response__c> responses = [
            SELECT 
                Id,
                Referral__c,
                Question__c,
                Response__c
            FROM Referral_Response__c
            WHERE Referral__c = :referralId
        ];
        return responses;
    }
}
