public with sharing class ClientMessageHelper {
    // email template names
    public static final String INITIAL_CLIENT_REFERRAL_TEMPLATE = 'Initial_Client_Referral';
    public static final String CLIENT_REFERRAL_FOLLOWUP_TEMPLATE = 'Client_Referral_Followup';
    public static final String CLIENT_RATE_SERVICE_TEMPLATE = 'Client_Rate_Service_Experience';

    public static List<Messaging.SingleEmailMessage> createInitialClientReferralEmails(Map<Id, Referral__c> referralMap) {

        // get the email template for this kind of message
        EmailTemplate template = getEmailTemplateByName(INITIAL_CLIENT_REFERRAL_TEMPLATE);

        // get the org wide email for the reply-to
        OrgWideEmailAddress emailAddress = getReferralOrgWideEmailAddress();

        // create email messages containing this information
        List<Messaging.SingleEmailMessage> messages = createEmailMessages(referralMap, emailAddress, template);


        return messages;
    }

    public static List<Messaging.SingleEmailMessage> createReferralFollowupEmails(Map<Id, Referral__c> referralMap) {

        // get the email template for this kind of message
        EmailTemplate template = getEmailTemplateByName(CLIENT_REFERRAL_FOLLOWUP_TEMPLATE);

        // get the org wide email for the reply-to
        OrgWideEmailAddress emailAddress = getReferralOrgWideEmailAddress();

        // create email messages containing this information
        List<Messaging.SingleEmailMessage> messages = createEmailMessages(referralMap, emailAddress, template);

       return messages;
    }

    public static List<Messaging.SingleEmailMessage> createReferralRateServiceEmails(Map<Id, Referral__c> referralMap) {
 
        // get the email template for this kind of message
        EmailTemplate template = getEmailTemplateByName(CLIENT_RATE_SERVICE_TEMPLATE);

        // get the org wide email for the reply-to
        OrgWideEmailAddress emailAddress = getReferralOrgWideEmailAddress();

        // create email messages containing this information
        List<Messaging.SingleEmailMessage> messages = createEmailMessages(referralMap, emailAddress, template);

        return messages;
    }

    private static EmailTemplate getEmailTemplateByName(String templateName) {
        EmailTemplate template = [
            SELECT
                Id,
                DeveloperName
            FROM EmailTemplate
            WHERE DeveloperName = :templateName
        ][0];
        return template;
    }

    private static List<Messaging.SingleEmailMessage> 
            createEmailMessages(Map<Id, Referral__c> referralMap, OrgWideEmailAddress orgWideEmail, EmailTemplate template) {

        List<Messaging.SingleEmailMessage> messages = new List<Messaging.SingleEmailMessage>();

        for (Id referralId : referralMap.keySet()) {
            Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
            if (orgWideEmail != null) {
                message.setOrgWideEmailAddressId(orgWideEmail.Id);
            }
            message.setTemplateId(template.Id);
            message.setTargetObjectId(referralMap.get(referralId).Contact__c);
            message.setWhatId(referralId);
            message.setUseSignature(false);
            messages.add(message);
        }

        return messages;
    }

    public static Map<Id,Messaging.SingleEmailMessage> getContactEmailMap(List<Messaging.SingleEmailMessage> emails) {
        Map<Id,Messaging.SingleEmailMessage> contactEmailMap = new Map<Id,Messaging.SingleEmailMessage>();
        for (Messaging.SingleEmailMessage email : emails) {
            contactEmailMap.put(email.getTargetObjectId(), email);
        }
        return contactEmailMap;
    }

    public static Map<Id, Referral__c> getReferralRecords(List<Id> referralIds) {
        Map<Id, Referral__c> referralMap = new Map<Id, Referral__c>();
        
        List<Referral__c> referrals = [
            SELECT
                Id,
                Contact__c
            FROM Referral__c
            WHERE Id IN :referralIds
        ];
        for (Referral__c refer : referrals) {
            referralMap.put(refer.Id, refer);
        }

        return referralMap;
    }

    @TestVisible
    private static OrgWideEmailAddress getReferralOrgWideEmailAddress() {
        OrgWideEmailAddress emailAddress = null;

        List<RefRecSettings__mdt> settings = [
            SELECT
                Id,
                Recommendations_Email_Service_Address__c
            FROM RefRecSettings__mdt
            WHERE DeveloperName = 'Organization_Default'
        ];

        if (settings.size() > 0) {
            String recommendationsAddress = settings[0].Recommendations_Email_Service_Address__c;
            List<OrgWideEmailAddress> emailAddresses = [
                SELECT  
                    Id,
                    Address
                FROM OrgWideEmailAddress
                WHERE Address = :recommendationsAddress
            ];
            if (emailAddresses.size() > 0) {
                emailAddress = emailAddresses[0];
            }
        }

        return emailAddress;
    }

}