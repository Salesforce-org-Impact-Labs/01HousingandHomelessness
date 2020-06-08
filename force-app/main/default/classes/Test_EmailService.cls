@IsTest
public with sharing class Test_EmailService {


    @TestSetup
    static void makeData(){
        Contact clientContact = new Contact (
            LastName = 'Tester',    
            Phone = '6105551212',
            Mobile_Phone_Carrier__c = 'AT&T'
        );
        insert clientContact;
    }

    static testMethod void testSendMessageToContact() {
        EmailService.ContactMessage contactMsg = createContactMessage();
        Boolean exceptionWasCaught = false;

        Test.startTest();
        try {
            EmailService.sendMessageToContact(new List<EmailService.ContactMessage>{contactMsg});
        } catch (EmailService.EmailServiceException ese) {
            exceptionWasCaught = true;
        }
        Test.stopTest();

        System.assertEquals(false,exceptionWasCaught);
    }

     static testMethod void testCreateClientContactMap() {
        EmailService.ContactMessage contactMsg = createContactMessage();

        Test.startTest();
        Map<Id,Contact> contactMap = EmailService.createClientContactMap(new List<EmailService.ContactMessage>{contactMsg});
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
        String messageToSend = 'test message';
        String phoneNumber = '(610) 555-1212';
        String carrierName = 'AT&T';

        Test.startTest();
        Messaging.SingleEmailMessage email = EmailService.createEmailForCarrier (messageToSend, phoneNumber, carrierName);
        Test.stopTest();

        System.assertNotEquals(null, email);
    }

    static testMethod void testSendEmailToCarrier() {
        String messageToSend = 'test message';
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
                Mobile_Phone_Carrier__c 
            FROM Contact
            WHERE LastName = 'Tester'
            LIMIT 1
        ];    

        EmailService.ContactMessage contactMsg = new EmailService.ContactMessage();
        contactMsg.clientContactId = testContact.Id;
        contactMsg.messageToSend = 'foo';

        return contactMsg;
    }

}
