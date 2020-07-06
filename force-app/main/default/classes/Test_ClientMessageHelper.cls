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

        Referral_Response__c refResp = new Referral_Response__c (
            Referral__c = ref.Id,
            Question__c = 'how are you',
            Response__c = 'i am fine'
        );
        insert refResp;

    }

    static testMethod void testCreateInitialClientReferralEmails() {
        Referral__c ref = getReferral();

        Map<Id,Referral__c> referralMap = new Map<Id,Referral__c>();
        referralMap.put(ref.Id,ref);

        Test.startTest();
        List<Messaging.SingleEmailMessage> messages = ClientMessageHelper.createInitialClientReferralEmails(referralMap);
        Test.stopTest();
        
        System.assertEquals('Initial Client Referral',messages[0].getTemplateName());
    }

    static testMethod void testCreateReferralFollowupEmails() {
        Referral__c ref = getReferral();

        Map<Id,Referral__c> referralMap = new Map<Id,Referral__c>();
        referralMap.put(ref.Id,ref);

        Test.startTest();
        List<Messaging.SingleEmailMessage> messages = ClientMessageHelper.createReferralFollowupEmails(referralMap);
        Test.stopTest();
        
        System.assertEquals('Client Referral Followup',messages[0].getTemplateName());
    }

    static testMethod void testCreateReferralRateServiceEmails() {
        Referral__c ref = getReferral();

        Map<Id,Referral__c> referralMap = new Map<Id,Referral__c>();
        referralMap.put(ref.Id,ref);

        Test.startTest();
        List<Messaging.SingleEmailMessage> messages = ClientMessageHelper.createReferralRateServiceEmails(referralMap);
        Test.stopTest();
        
        System.assertEquals('Client Rate Service Experience',messages[0].getTemplateName());       
    }

    static testMethod void testCreateClientHelpResponseEmails() {
        Referral__c ref = [
            SELECT
                Id,
                Contact__c,
                Preferred_Channel__c
            FROM Referral__c
        ][0];

        Map<Id,Referral__c> referralMap = new Map<Id,Referral__c>();
        referralMap.put(ref.Id,ref);

        Test.startTest();
        List<Messaging.SingleEmailMessage> messages = ClientMessageHelper.createClientHelpResponseEmails(referralMap);
        Test.stopTest();
        
        System.assertEquals('Client_Help_Response',messages[0].getTemplateName());       
    }

    static testMethod void testCreateClientCantConnectEmails() {
        Referral__c ref = getReferral();

        Map<Id,Referral__c> referralMap = new Map<Id,Referral__c>();
        referralMap.put(ref.Id,ref);

        Test.startTest();
        List<Messaging.SingleEmailMessage> messages = ClientMessageHelper.createClientCantConnectEmails(referralMap);
        Test.stopTest();
        
        System.assertEquals('Client Cant Connect',messages[0].getTemplateName());       
    }

    static testMethod void testCreateRateServiceSavedEmails() {
        Referral__c ref = getReferral();

        Map<Id,Referral__c> referralMap = new Map<Id,Referral__c>();
        referralMap.put(ref.Id,ref);

        Test.startTest();
        List<Messaging.SingleEmailMessage> messages = ClientMessageHelper.createRateServiceSavedEmails(referralMap);
        Test.stopTest();
        
        System.assertEquals('Rate Service Saved Response',messages[0].getTemplateName());               
    }

    static testMethod void testCreateCantConnectGuidance1Emails() {
        Referral__c ref = getReferral();

        Map<Id,Referral__c> referralMap = new Map<Id,Referral__c>();
        referralMap.put(ref.Id,ref);

        Test.startTest();
        List<Messaging.SingleEmailMessage> messages = ClientMessageHelper.createCantConnectGuidance1Emails(referralMap);
        Test.stopTest();
        
        System.assertEquals('Cant Connect Guidance',messages[0].getTemplateName());               
    }

    static testMethod void testCreateCantConnectGuidance2Emails() {
        Referral__c ref = getReferral();

        Map<Id,Referral__c> referralMap = new Map<Id,Referral__c>();
        referralMap.put(ref.Id,ref);

        Test.startTest();
        List<Messaging.SingleEmailMessage> messages = ClientMessageHelper.createCantConnectGuidance2Emails(referralMap);
        Test.stopTest();
        
        System.assertEquals('Cant Connect Guidance 2',messages[0].getTemplateName());               
    }

    static testMethod void testCreateCantConnectGuidance3Emails() {
        Referral__c ref = getReferral();

        Map<Id,Referral__c> referralMap = new Map<Id,Referral__c>();
        referralMap.put(ref.Id,ref);

        Test.startTest();
        List<Messaging.SingleEmailMessage> messages = ClientMessageHelper.createCantConnectGuidance3Emails(referralMap);
        Test.stopTest();
        
        System.assertEquals('Cant Connect Guidance 3',messages[0].getTemplateName());               
    }

    static testMethod void testCreateCantConnectGuidance4Emails() {
        Referral__c ref = getReferral();

        Map<Id,Referral__c> referralMap = new Map<Id,Referral__c>();
        referralMap.put(ref.Id,ref);

        Test.startTest();
        List<Messaging.SingleEmailMessage> messages = ClientMessageHelper.createCantConnectGuidance4Emails(referralMap);
        Test.stopTest();
        
        System.assertEquals('Cant Connect Guidance 4',messages[0].getTemplateName());               
    }

    static testMethod void testSaveReferralQuestion() {
        Referral__c ref = getReferral();

        Test.startTest();
        Referral_Response__c response = 
            ClientMessageHelper.saveReferralQuestion(ref.Id,ClientMessageHelper.CLIENT_REFERRAL_FOLLOWUP_TEMPLATE);
        Test.stopTest();

        System.assertEquals(ClientMessageHelper.CLIENT_REFERRAL_FOLLOWUP_QUESTION, response.Question__c);
    }

    static testMethod void testGetContactEmailMap() {
        Referral__c ref = getReferral();

        Map<Id,Referral__c> referralMap = new Map<Id,Referral__c>();
        referralMap.put(ref.Id,ref);

        List<Messaging.SingleEmailMessage> messages = ClientMessageHelper.createInitialClientReferralEmails(referralMap);
        
        Test.startTest();
        Map<Id,Messaging.SingleEmailMessage> emailMap = ClientMessageHelper.getContactEmailMap(messages);
        Test.stopTest();

        List<Referral_Response__c> refResponses = [
            SELECT 
                Id,
                Referral__c,
                Question__c,
                Response__c
            FROM Referral_Response__c
            WHERE Referral__c = :ref.Id
        ]; 
        
        System.assertEquals(refResponses[0].Id,emailMap.get(ref.Contact__c).getWhatId());
    }

    static testMethod void testGetReferralRecords() {
        Referral__c ref = getReferral();

        List<Id> referralIds = new List<Id>();
        referralIds.add(ref.Id);

        Test.startTest();
        Map<Id, Referral__c> referralMap = ClientMessageHelper.getReferralRecords(referralIds);
        Test.stopTest();

        System.assertEquals(ref.Contact__c,referralMap.get(ref.Id).Contact__c);
    }

    static testMethod void testSendHelpMailToCaseManager() {
        Referral_Response__c refResp = [
            SELECT
                Id
            FROM Referral_Response__c
        ][0];

        Test.startTest();
        ClientMessageHelper.sendHelpMailToCaseManager(refResp.Id);
        Integer invocations = Limits.getEmailInvocations();
        Test.stopTest();

        System.assertEquals(1,invocations);
    }

    private static Referral__c getReferral() {
        Referral__c ref = [
            SELECT
                Id,
                Contact__c,
                Preferred_Channel__c
            FROM Referral__c
        ][0];
        return ref;
    }

}
