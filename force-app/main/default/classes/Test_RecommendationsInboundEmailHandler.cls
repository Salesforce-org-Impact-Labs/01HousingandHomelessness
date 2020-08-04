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
        String response = RecommendationsInboundEmailHandler.EMAIL_REPLY_YES;
        Referral_Response__c refResponse = getReferralResponse();
        String referralId = refResponse.Referral__c;

        Test.startTest();
        RecommendationsInboundEmailHandler.handleClientResponse(response, refResponse, referralId);
        Test.stopTest();

        Referral_Response__c refResponseCheck = getReferralResponse();
        System.assertEquals(RecommendationsInboundEmailHandler.EMAIL_REPLY_YES,refResponseCheck.Response__c);
    }

    static testMethod void testHandleClientResponseNo() {
        String response = RecommendationsInboundEmailHandler.EMAIL_REPLY_NO;
        Referral_Response__c refResponse = getReferralResponse();
        String referralId = refResponse.Referral__c;

        Test.startTest();
        RecommendationsInboundEmailHandler.handleClientResponse(response, refResponse, referralId);
        Test.stopTest();

        Referral_Response__c refResponseCheck = getReferralResponse();
        System.assertEquals(RecommendationsInboundEmailHandler.EMAIL_REPLY_NO,refResponseCheck.Response__c);
    }

    static testMethod void testHandleClientResponseHelp() {
        String response = RecommendationsInboundEmailHandler.EMAIL_REPLY_HELP;
        Referral_Response__c refResponse = getReferralResponse();
        String referralId = refResponse.Referral__c;

        Test.startTest();
        RecommendationsInboundEmailHandler.handleClientResponse(response, refResponse, referralId);
        Test.stopTest();

        Referral_Response__c refResponseCheck = getReferralResponse();
        System.assertEquals(RecommendationsInboundEmailHandler.EMAIL_REPLY_HELP,refResponseCheck.Response__c);
    }

    static testMethod void testHandleClientResponseScore() {
        String response = '3';
        Referral_Response__c refResponse = getReferralResponse();
        // we need to ask the right question
        refResponse.Question__c = ClientMessageHelper.CLIENT_RATE_SERVICE_QUESTION;
        String referralId = refResponse.Referral__c;

        Test.startTest();
        RecommendationsInboundEmailHandler.handleClientResponse(response, refResponse, referralId);
        Test.stopTest();

        Referral_Response__c refResponseCheck = getReferralResponse();
        System.assertEquals('3',refResponseCheck.Response__c);
        Referral__c referral = getReferral();
        System.assertEquals(3,referral.Score__c);
    }

    static testMethod void testHandleClientResponseGuidance1() {
        String response = '1';
        Referral_Response__c refResponse = getReferralResponse();
        // we need to ask the right question
        refResponse.Question__c = ClientMessageHelper.CLIENT_CANT_CONNECT_QUESTION;
        String referralId = refResponse.Referral__c;

        Test.startTest();
        RecommendationsInboundEmailHandler.handleClientResponse(response, refResponse, referralId);
        Test.stopTest();

        Referral_Response__c refResponseCheck = getReferralResponse();
        System.assertEquals('1',refResponseCheck.Response__c);
    }

    static testMethod void testHandleClientResponseGuidance2() {
        String response = '2';
        Referral_Response__c refResponse = getReferralResponse();
        // we need to ask the right question
        refResponse.Question__c = ClientMessageHelper.CLIENT_CANT_CONNECT_QUESTION;
        String referralId = refResponse.Referral__c;

        Test.startTest();
        RecommendationsInboundEmailHandler.handleClientResponse(response, refResponse, referralId);
        Test.stopTest();

        Referral_Response__c refResponseCheck = getReferralResponse();
        System.assertEquals('2',refResponseCheck.Response__c);
    }

    static testMethod void testHandleClientResponseGuidance3() {
        String response = '3';
        Referral_Response__c refResponse = getReferralResponse();
        // we need to ask the right question
        refResponse.Question__c = ClientMessageHelper.CLIENT_CANT_CONNECT_QUESTION;
        String referralId = refResponse.Referral__c;

        Test.startTest();
        RecommendationsInboundEmailHandler.handleClientResponse(response, refResponse, referralId);
        Test.stopTest();

        Referral_Response__c refResponseCheck = getReferralResponse();
        System.assertEquals('3',refResponseCheck.Response__c);
    }

    static testMethod void testHandleClientResponseGuidance4() {
        String response = '4';
        Referral_Response__c refResponse = getReferralResponse();
        // we need to ask the right question
        refResponse.Question__c = ClientMessageHelper.CLIENT_CANT_CONNECT_QUESTION;
        String referralId = refResponse.Referral__c;

        Test.startTest();
        RecommendationsInboundEmailHandler.handleClientResponse(response, refResponse, referralId);
        Test.stopTest();

        Referral_Response__c refResponseCheck = getReferralResponse();
        System.assertEquals('4',refResponseCheck.Response__c);
    }

    static testMethod void testHandleClientResponseOther() {
        String response = 'Something Happened';
        Referral_Response__c refResponse = getReferralResponse();
        // we need to ask the right question
        refResponse.Question__c = ClientMessageHelper.CANT_CONNECT_GUIDANCE_QUESTION_4;
        String referralId = refResponse.Referral__c;

        Test.startTest();
        RecommendationsInboundEmailHandler.handleClientResponse(response, refResponse, referralId);
        Test.stopTest();

        Referral_Response__c refResponseCheck = getReferralResponse();
        System.assertEquals('Something Happened',refResponseCheck.Response__c);
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