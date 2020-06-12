@IsTest
public with sharing class Test_EmailService {

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

    static testMethod void testSendInitialReferralMessages() {
        List<Referral__c> referrals = [
            SELECT
                Id
            FROM Referral__c
            WHERE Contact__r.LastName = 'Tester'
        ];
       List<Id> referralIds = new List<Id>{referrals[0].Id};

       Test.startTest();
       Boolean exceptionCaught = false;
       try {
            EmailService.sendInitialReferralMessages(referralIds);
       } catch (Exception ex) {
            exceptionCaught = true;
       }
       Test.stopTest();

       System.assertEquals(false,exceptionCaught);
    }

    static testMethod void testSendReferralFollowupMessages() {
        List<Referral__c> referrals = [
            SELECT
                Id
            FROM Referral__c
            WHERE Contact__r.LastName = 'Tester'
        ];
       List<Id> referralIds = new List<Id>{referrals[0].Id};

       Test.startTest();
       Boolean exceptionCaught = false;
       try {
            EmailService.sendReferralFollowupMessages(referralIds);
       } catch (Exception ex) {
            exceptionCaught = true;
       }
       Test.stopTest();

       System.assertEquals(false,exceptionCaught);
    }

    static testMethod void testSendMessageToContact() {
        Contact testContact = [
            SELECT 
                Id,
                Phone 
            FROM Contact
            WHERE LastName = 'Tester'
            LIMIT 1
        ];  
        Map<Id,Contact> contactMap = new Map<Id,Contact>();
        contactMap.put(testContact.Id,testContact);

        EmailService.ContactMessage contactMsg = createContactMessage();
        Boolean exceptionWasCaught = false;

        Test.startTest();
        try {
            EmailService.sendMessageToContact(new List<EmailService.ContactMessage>{contactMsg},contactMap);
        } catch (EmailService.EmailServiceException ese) {
            exceptionWasCaught = true;
        }
        Test.stopTest();

        System.assertEquals(false,exceptionWasCaught);
    }

    static testMethod void testSendMessageToContactNoPhone() {
        Contact testContact = [
            SELECT 
                Id,
                Phone 
            FROM Contact
            WHERE LastName = 'Tester'
            LIMIT 1
        ];  
        testContact.Phone = null;
        update(testContact);

        EmailService.ContactMessage contactMsg = createContactMessage();

        Map<Id,Contact> contactMap = new Map<Id,Contact>();
        contactMap.put(testContact.Id,testContact);
       
        Boolean exceptionWasCaught = false;
        String exceptionMsg = '';
        Test.startTest();
        try {
            EmailService.sendMessageToContact(new List<EmailService.ContactMessage>{contactMsg},contactMap);
        } catch (EmailService.EmailServiceException ese) {
            exceptionWasCaught = true;
            exceptionMsg = ese.getMessage();
        }
        Test.stopTest();

        System.assertEquals(true,exceptionWasCaught);
        System.assert(exceptionMsg.contains('Failed to find Phone on the Contact record for Contact Id'));
    }

     static testMethod void testCreateClientContactMap() {
        Contact clientContact = [
            SELECT 
                Id 
            FROM Contact
            WHERE LastName = 'Tester'
            LIMIT 1
        ];
        Set<Id> ids = new Set<Id>();
        ids.add(clientContact.Id);

        Test.startTest();
        Map<Id,Contact> contactMap = EmailService.createClientContactMap(ids);
        Test.stopTest();

        Contact testContact = contactMap.values()[0];
        System.assertEquals('AT&T',testContact.Mobile_Phone_Carrier__c);
    }

    static testMethod void testGetContactForId() {
        Contact testContact = [
            SELECT 
                Id 
            FROM Contact
            WHERE LastName = 'Tester'
            LIMIT 1
        ];

        Test.startTest();
        Contact checkContact = EmailService.getContactForId(testContact.Id);
        Test.stopTest();

        System.assertEquals(checkContact.Mobile_Phone_Carrier__c, 'AT&T');
    }

    static testMethod void testConvertPhoneToCarrierEmail() {
        String phoneNumber = '(610) 555-1212';
        String carrierName = 'AT&T';

        Test.startTest();
        String emailAddy = EmailService.convertPhoneToCarrierEmail (phoneNumber, carrierName);
        Test.stopTest();

        System.assertEquals('6105551212@txt.att.net', emailAddy);
    }

    static testMethod void testCreateEmailForCarrier() {
        Messaging.SingleEmailMessage messageToSend = createTestEmail();
        String phoneNumber = '(610) 555-1212';
        String carrierName = 'AT&T';

        Test.startTest();
        Messaging.SingleEmailMessage email = EmailService.createEmailForCarrier (messageToSend, phoneNumber, carrierName);
        Test.stopTest();

        System.assertNotEquals(null, email);
    }

    static testMethod void testSendEmailToCarrier() {
        Messaging.SingleEmailMessage messageToSend = createTestEmail();
        String phoneNumber = '(610) 555-1212';
        String carrierName = 'AT&T';
        Messaging.SingleEmailMessage email = EmailService.createEmailForCarrier (messageToSend, phoneNumber, carrierName);

        Test.startTest();
        EmailService.sendEmailToCarrier(email);
        Integer invocations = Limits.getEmailInvocations();
        Test.stopTest();
       
        System.assertEquals(1, invocations);
    }

    static EmailService.ContactMessage createContactMessage() {
        Contact testContact = [
            SELECT 
                Id,
                LastName,
                Phone,
                Mobile_Phone_Carrier__c 
            FROM Contact
            WHERE LastName = 'Tester'
            LIMIT 1
        ];    

        EmailService.ContactMessage contactMsg = new EmailService.ContactMessage();
        contactMsg.clientContact = testContact;
        contactMsg.messageToSend = createTestEmail();

        return contactMsg;
    }

    static Messaging.SingleEmailMessage createTestEmail() {
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        email.setPlainTextBody('foo message');
        return email;
    }

}
