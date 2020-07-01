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

        Referral_Response__c refResp = new Referral_Response__c (
            Referral__c = ref.Id,
            Question__c = 'How are you'
        );
        insert refResp;
    }

    static testMethod void testHandleClientResponseYes() {
        String truncatedResponse = RecommendationsInboundEmailHandler.EMAIL_REPLY_YES;
        String firstChar = truncatedResponse.substring(0,1);
        Referral_Response__c refResponse = getReferralResponse();
        String referralId = refResponse.Referral__c;

        Test.startTest();
        RecommendationsInboundEmailHandler.handleClientResponse(truncatedResponse, firstChar, refResponse, referralId);
        Test.stopTest();

        Referral_Response__c refResponseCheck = getReferralResponse();
        System.assertEquals(RecommendationsInboundEmailHandler.EMAIL_REPLY_YES,refResponseCheck.Response__c);
    }

    static testMethod void testHandleClientResponseNo() {
        String truncatedResponse = RecommendationsInboundEmailHandler.EMAIL_REPLY_NO;
        String firstChar = truncatedResponse.substring(0,1);
        Referral_Response__c refResponse = getReferralResponse();
        String referralId = refResponse.Referral__c;

        Test.startTest();
        RecommendationsInboundEmailHandler.handleClientResponse(truncatedResponse, firstChar, refResponse, referralId);
        Test.stopTest();

        Referral_Response__c refResponseCheck = getReferralResponse();
        System.assertEquals(RecommendationsInboundEmailHandler.EMAIL_REPLY_NO,refResponseCheck.Response__c);
    }

    static testMethod void testHandleClientResponseHelp() {
        String truncatedResponse = RecommendationsInboundEmailHandler.EMAIL_REPLY_HELP;
        String firstChar = truncatedResponse.substring(0,1);
        Referral_Response__c refResponse = getReferralResponse();
        String referralId = refResponse.Referral__c;

        Test.startTest();
        RecommendationsInboundEmailHandler.handleClientResponse(truncatedResponse, firstChar, refResponse, referralId);
        Test.stopTest();

        Referral_Response__c refResponseCheck = getReferralResponse();
        System.assertEquals(RecommendationsInboundEmailHandler.EMAIL_REPLY_HELP,refResponseCheck.Response__c);
    }

    static testMethod void testHandleClientResponseScore() {
        String truncatedResponse = '3';
        String firstChar = truncatedResponse.substring(0,1);
        Referral_Response__c refResponse = getReferralResponse();
        String referralId = refResponse.Referral__c;

        Test.startTest();
        RecommendationsInboundEmailHandler.handleClientResponse(truncatedResponse, firstChar, refResponse, referralId);
        Test.stopTest();

        Referral_Response__c refResponseCheck = getReferralResponse();
        System.assertEquals('3',refResponseCheck.Response__c);
    }

    static testMethod void testGetReferralResponse() {
        Referral_Response__c refResp = getReferralResponse();

        Test.startTest();
        Referral_Response__c refRespCheck = RecommendationsInboundEmailHandler.getReferralResponse(refResp.Id);
        Test.stopTest();

        System.assertEquals('How are you',refRespCheck.Question__c);
    }

    static Referral_Response__c getReferralResponse() {
        List<Referral_Response__c> responses = [
            SELECT
                Id,
                Referral__c,
                Question__c,
                Response__c
            FROM Referral_Response__c
            WHERE Referral__r.Contact__r.LastName = 'Tester'
        ];    
        return responses[0];    
    }
}
