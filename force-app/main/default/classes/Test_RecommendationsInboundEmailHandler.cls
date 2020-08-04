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
            Type__c = 'Food',
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

        // data for next recommendated service
        Decimal lat = 37.7897;
        Decimal lon = -122.397;
        Integer startHour = 9;
        Integer endHour = 17;
           
            //   Create an Account
        Account Provider = new Account();
        Provider.Name = 'GetRecommendations Test Provider';
        insert Provider;

        // create a contact with a profile
        Contact c = new Contact();
        c.FirstName = 'testContact';
        c.LastName = 'Test_getRecommendations';
        c.BirthDate = Date.newInstance(1979, 4, 20);
        c.Email = 'testReco@goodguy.org';
        insert c;

        Client_Profile__c profile = new Client_Profile__c();
        profile.Contact__c = c.Id;
        profile.Date_of_Birth__c = c.BirthDate;
        profile.First_Name__c = c.Firstname;
        profile.Last_Name__c = c.LastName;
        profile.Location__Latitude__s = lat;
        profile.Location__Longitude__s = lon;
        profile.Homeless__c = true;
        profile.Employment__c = 'Employed full-time';
        insert Profile;

        // create 2 services
        List<Service__c> Services = new List<Service__c>();

        Service__c GoodService = new Service__c();
        GoodService.Account__c = Provider.Id;
        GoodService.Name = 'The good service';
        GoodService.Preferred__c = true;
        GoodService.Location__Latitude__s = lat;
        GoodService.Location__Longitude__s = lon;
        GoodService.Homeless__c = true;
        GoodService.Employed_full_time__c = true;
        GoodService.Employed_part_time__c = true;
        GoodService.Type__c = 'Food';
        Services.add(GoodService);

        Service__c TeenService = new Service__c();
        TeenService.Account__c = Provider.Id;
        TeenService.Name = 'The teen service';
        TeenService.Type__c = 'Food';
        TeenService.Maximum_Age__c = 18;
        TeenService.Location__Latitude__s = lat;
        TeenService.Location__Longitude__s = lon;
        Services.add(TeenService);

        Service__c TheServiceNobodyLikes = new Service__c();
        TheServiceNobodyLikes.Account__c = Provider.Id;
        TheServiceNobodyLikes.Name = 'The service nobody likes';
        TheServiceNobodyLikes.Location__Latitude__s = lat;
        TheServiceNobodyLikes.Location__Longitude__s = lon;
        TheServiceNobodyLikes.Type__c = 'Transit';
        Services.add(TheServiceNobodyLikes);

        Service__c FarService = new Service__c();
        FarService.Account__c = Provider.Id;
        FarService.Name = 'FarService';
        FarService.Location__Latitude__s = 0;
        FarService.Location__Longitude__s = 0;
        FarService.Type__c = 'Work';
        Services.add(FarService);

        insert Services;

        // service plus hours
        Open_Hours__c hours = new Open_Hours__c();
        hours.Start_Time__c = Time.newInstance(startHour, 0, 0, 0);
        hours.End_Time__c = Time.newInstance(endHour, 0, 0, 0);
        hours.Service__c = GoodService.Id;
        hours.Day__c = getRecommendations.whatDayIsIt();
        insert hours;

        // service with comment
        FeedItem fi = new FeedItem();
        fi.Body = 'It is great';
        fi.Type = 'TextPost';
        fi.ParentId = GoodService.Id;
        insert fi;

        // referrals with scores
        Referral__c refer = new Referral__c();
        refer.Contact__c = c.Id;
        refer.Service__c = GoodService.Id;
        refer.Score__c = 5;
        refer.Preferred_Channel__c = 'Email';
        insert refer;

        Referral_Response__c refResp2 = new Referral_Response__c (
            Referral__c = refer.Id,
            Question__c = 'Have you visited'
        );
        insert refResp2;

        Scoring.scoreAllServices();
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
        Referral_Response__c refResponse = getRefResponseReco();
        // we need to ask the right question
        refResponse.Question__c = ClientMessageHelper.CLIENT_CANT_CONNECT_QUESTION;
        String referralId = refResponse.Referral__c;

        Test.startTest();
        RecommendationsInboundEmailHandler.handleClientResponse(response, refResponse, referralId);
        Test.stopTest();

        Referral_Response__c refResponseCheck = getRefResponseReco();
        System.assertEquals('2',refResponseCheck.Response__c);
    }

    static testMethod void testHandleClientResponseGuidance3() {
        String response = '3';
        Referral_Response__c refResponse = getRefResponseReco();
        // we need to ask the right question
        refResponse.Question__c = ClientMessageHelper.CLIENT_CANT_CONNECT_QUESTION;
        String referralId = refResponse.Referral__c;

        Test.startTest();
        RecommendationsInboundEmailHandler.handleClientResponse(response, refResponse, referralId);
        Test.stopTest();

        Referral_Response__c refResponseCheck = getRefResponseReco();
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

    static testMethod void testCreateEmailConfirmTask() {
        Test.startTest();
        RecommendationsInboundEmailHandler.createEmailConfirmTask('body of email');
        Test.stopTest();

        Task confirmTask = [
            SELECT
                Id,
                Description
            FROM Task
            WHERE Subject = 'Confirm Organization-Wide Email Address'
        ][0];

        System.assertEquals('body of email', confirmTask.Description);
    }

    static testMethod void testCreateNewReferralCopy() {
        Referral__c referral = getReferral();

        Test.startTest();
        Referral__c  newRef = 
            RecommendationsInboundEmailHandler.createNewReferralCopy(referral.Contact__c,referral.Preferred_Channel__c);
        Test.stopTest();

        System.assertEquals(referral.Contact__c, newRef.Contact__c);
        System.assertEquals(referral.Preferred_Channel__c, newRef.Preferred_Channel__c);
    }

    static testMethod void testCreateReferralTask() {
        Referral__c referral = getReferral();

        Test.startTest();
        Task newTask = RecommendationsInboundEmailHandler.createReferralTask(referral.Id);
        Test.stopTest();
       
        System.assertEquals(referral.Id,newTask.WhatId);
    }

    static testMethod void testGetNextServiceRecommendationForClient() {
        Contact testContact = [
            SELECT
                Id
            FROM Contact
            WHERE LastName = 'Test_getRecommendations'
        ][0];

        Test.startTest();
        Service__c nextService =  
                RecommendationsInboundEmailHandler.getNextServiceRecommendationForClient(testContact.Id, 'Food');
        Test.stopTest();

        System.assertEquals('The good service', nextService.Name);
    }

    static testMethod void testCreateNewReferralAndTask() {
        Referral_Response__c refResponse = getRefResponseReco();

        Test.startTest();
        RecommendationsInboundEmailHandler.createNewReferralAndTask(refResponse);
        Test.stopTest();

        Referral__c newReferral = [
            SELECT 
                Id,
                Service__r.Type__c
            FROM Referral__c
            ORDER BY CreatedDate DESC
        ][0];

        System.assertEquals('Food',newReferral.Service__r.Type__c);
    }

    static Referral_Response__c getReferralResponse() {
        List<Referral_Response__c> responses = [
            SELECT
                Id,
                Referral__c,
                Referral__r.Contact__c,
                Referral__r.Preferred_Channel__c,
                Referral__r.Service__r.Type__c,
                Question__c,
                Response__c
            FROM Referral_Response__c
            WHERE Referral__r.Contact__r.LastName = 'Tester'
        ];    
        return responses[0];    
    }

    static Referral_Response__c getRefResponseReco() {
        Referral_Response__c refResponse = [
            SELECT
                Id,
                Referral__c,
                Referral__r.Contact__c,
                Referral__r.Preferred_Channel__c,
                Referral__r.Service__r.Type__c,
                Question__c,
                Response__c
            FROM Referral_Response__c
            WHERE Question__c = 'Have you visited'
        ][0];
        return refResponse;
    }

    static Referral__c getReferral() {
        List<Referral__c> referrals = [
            SELECT
                Id,
                Contact__c,
                Preferred_Channel__c,
                Score__c
            FROM Referral__c
            WHERE Contact__r.LastName = 'Tester'
        ];
        return referrals[0];
    }
}