public with sharing class ClientMessageHelper {
    // template types - one for each interaction
    public static final String INITIAL_CLIENT_REFERRAL = 'INITIAL_CLIENT_REFERRAL';
    public static final String CLIENT_REFERRAL_FOLLOWUP = 'CLIENT_REFERRAL_FOLLOWUP';
    public static final String CLIENT_RATE_SERVICE = 'CLIENT_RATE_SERVICE';
    public static final String CLIENT_HELP_RESPONSE = 'CLIENT_HELP_RESPONSE';
    public static final String CLIENT_CANT_CONNECT = 'CLIENT_CANT_CONNECT';
    public static final String RATE_SERVICE_SAVED = 'RATE_SERVICE_SAVED';
    public static final String CANT_CONNECT_GUIDANCE_1 = 'CANT_CONNECT_GUIDANCE_1';
    public static final String CANT_CONNECT_GUIDANCE_2 = 'CANT_CONNECT_GUIDANCE_2';
    public static final String CANT_CONNECT_GUIDANCE_3 = 'CANT_CONNECT_GUIDANCE_3';
    public static final String CANT_CONNECT_GUIDANCE_4 = 'CANT_CONNECT_GUIDANCE_4';

    // channels - should have same strings as those in the Preferred_Channel__c picklist on Referral__c
    public static final String TEXT_CHANNEL = 'SMS';
    public static final String EMAIL_CHANNEL = 'Email';

    // email template developer names - one for email, one for text - for each type
    public static final String INITIAL_CLIENT_REFERRAL_TEMPLATE = 'Initial_Client_Referral';
    public static final String INITIAL_CLIENT_REFERRAL_TEXT_TEMPLATE = 'Initial_Client_Referral_Text';
    public static final String CLIENT_REFERRAL_FOLLOWUP_TEMPLATE = 'Client_Referral_Followup';
    public static final String CLIENT_REFERRAL_FOLLOWUP_TEXT_TEMPLATE = 'Client_Referral_Followup_Text';
    public static final String CLIENT_RATE_SERVICE_TEMPLATE = 'Client_Rate_Service_Experience';
    public static final String CLIENT_RATE_SERVICE_TEXT_TEMPLATE = 'Client_Rate_Service_Experience_Text';
    public static final String CLIENT_HELP_RESPONSE_TEMPLATE = 'Client_Help_Response';
    public static final String CLIENT_HELP_RESPONSE_TEXT_TEMPLATE = 'Client_Help_Response_Text';
    public static final String CLIENT_CANT_CONNECT_TEMPLATE = 'Client_Cant_Connect';
    public static final String CLIENT_CANT_CONNECT_TEXT_TEMPLATE = 'Client_Cant_Connect_Text';
    public static final String RATE_SERVICE_SAVED_TEMPLATE = 'Rate_Service_Saved_Response';
    public static final String RATE_SERVICE_SAVED_TEXT_TEMPLATE = 'Rate_Service_Saved_Response_Text';
    public static final String CANT_CONNECT_GUIDANCE_TEMPLATE_1 = 'Cant_Connect_Guidance';
    public static final String CANT_CONNECT_GUIDANCE_TEXT_TEMPLATE_1 = 'Cant_Connect_Guidance_Text';
    public static final String CANT_CONNECT_GUIDANCE_TEMPLATE_2 = 'Cant_Connect_Guidance_2';
    public static final String CANT_CONNECT_GUIDANCE_TEXT_TEMPLATE_2 = 'Cant_Connect_Guidance_2_Text';
    public static final String CANT_CONNECT_GUIDANCE_TEMPLATE_3 = 'Cant_Connect_Guidance_3';
    public static final String CANT_CONNECT_GUIDANCE_TEXT_TEMPLATE_3 = 'Cant_Connect_Guidance_3_Text';
    public static final String CANT_CONNECT_GUIDANCE_TEMPLATE_4 = 'Cant_Connect_Guidance_4';
    public static final String CANT_CONNECT_GUIDANCE_TEXT_TEMPLATE_4 = 'Cant_Connect_Guidance_4_Text';

    // questions for each interaction
    public static final String INITIAL_CLIENT_REFERRAL_QUESTION = 'Heres your referral information';
    public static final String CLIENT_REFERRAL_FOLLOWUP_QUESTION = 'Have you met with your referral';
    public static final String CLIENT_RATE_SERVICE_QUESTION = 'Rate your experience on a scale of 1-5';
    public static final String CLIENT_HELP_RESPONSE_QUESTION = 'Thank you for letting us know you need help';
    public static final String CLIENT_CANT_CONNECT_QUESTION = 'What’s getting in the way of connecting with the service';
    public static final String RATE_SERVICE_SAVED_QUESTION = 'Your feedback helps us know which services to recommend to others.';
    public static final String CANT_CONNECT_GUIDANCE_QUESTION_1 = 'We know life gets busy.';
    public static final String CANT_CONNECT_GUIDANCE_QUESTION_2 = 'We are sorry to hear they didn’t respond.';
    public static final String CANT_CONNECT_GUIDANCE_QUESTION_3 = 'We are sorry to hear the information was wrong.';
    public static final String CANT_CONNECT_GUIDANCE_QUESTION_4 = 'Can you tell me what happened';

    public static final String CASE_MANAGER_HELP_TEMPLATE = 'Case_Manager_Client_Asked_For_Help';

    public static final String REF_REC_SETTINGS_RECORD_DEVELOPER_NAME = 'Organization_Default';

    public static List<Messaging.SingleEmailMessage> createInitialClientReferralEmails(Map<Id, Referral__c> referralMap, Map<Id,Id> taskToReferralMap) {

        // get the org wide email for the reply-to
        OrgWideEmailAddress emailAddress = getReferralOrgWideEmailAddress();

        // create email messages containing this information
        List<Messaging.SingleEmailMessage> messages = createEmailMessages(referralMap, emailAddress, INITIAL_CLIENT_REFERRAL, taskToReferralMap);

        return messages;
    }

    public static List<Messaging.SingleEmailMessage> createReferralFollowupEmails(Map<Id, Referral__c> referralMap, Map<Id,Id> taskToReferralMap) {

        // get the org wide email for the reply-to
        OrgWideEmailAddress emailAddress = getReferralOrgWideEmailAddress();

        // create email messages containing this information
        List<Messaging.SingleEmailMessage> messages = createEmailMessages(referralMap, emailAddress, CLIENT_REFERRAL_FOLLOWUP, taskToReferralMap);

       return messages;
    }

    public static List<Messaging.SingleEmailMessage> createReferralRateServiceEmails(Map<Id, Referral__c> referralMap) {
 
        // get the org wide email for the reply-to
        OrgWideEmailAddress emailAddress = getReferralOrgWideEmailAddress();

        // create email messages containing this information
        Map<Id,Id> taskToReferralMap = new Map<Id,Id>();
        List<Messaging.SingleEmailMessage> messages = createEmailMessages(referralMap, emailAddress, CLIENT_RATE_SERVICE, taskToReferralMap);

        return messages;
    }

    public static List<Messaging.SingleEmailMessage> createClientHelpResponseEmails(Map<Id, Referral__c> referralMap) {
 
        // get the org wide email for the reply-to
        OrgWideEmailAddress emailAddress = getReferralOrgWideEmailAddress();

        // create email messages containing this information
        Map<Id,Id> taskToReferralMap = new Map<Id,Id>();
        List<Messaging.SingleEmailMessage> messages = createEmailMessages(referralMap, emailAddress, CLIENT_HELP_RESPONSE, taskToReferralMap);

        return messages;
    }

    public static List<Messaging.SingleEmailMessage> createClientCantConnectEmails(Map<Id, Referral__c> referralMap) {
 
        // get the org wide email for the reply-to
        OrgWideEmailAddress emailAddress = getReferralOrgWideEmailAddress();

        // create email messages containing this information
        Map<Id,Id> taskToReferralMap = new Map<Id,Id>();
        List<Messaging.SingleEmailMessage> messages = createEmailMessages(referralMap, emailAddress, CLIENT_CANT_CONNECT, taskToReferralMap);

        return messages;
    }

    public static List<Messaging.SingleEmailMessage> createRateServiceSavedEmails(Map<Id, Referral__c> referralMap) {
 
        // get the org wide email for the reply-to
        OrgWideEmailAddress emailAddress = getReferralOrgWideEmailAddress();

        // create email messages containing this information
        Map<Id,Id> taskToReferralMap = new Map<Id,Id>();
        List<Messaging.SingleEmailMessage> messages = createEmailMessages(referralMap, emailAddress, RATE_SERVICE_SAVED, taskToReferralMap);

        return messages;
    }

    public static List<Messaging.SingleEmailMessage> createCantConnectGuidance1Emails(Map<Id, Referral__c> referralMap) {
 
        // get the org wide email for the reply-to
        OrgWideEmailAddress emailAddress = getReferralOrgWideEmailAddress();

        // create email messages containing this information
        Map<Id,Id> taskToReferralMap = new Map<Id,Id>();
        List<Messaging.SingleEmailMessage> messages = createEmailMessages(referralMap, emailAddress, CANT_CONNECT_GUIDANCE_1, taskToReferralMap);

        return messages;
    }

    public static List<Messaging.SingleEmailMessage> createCantConnectGuidance2Emails(Map<Id, Referral__c> referralMap) {
 
        // get the org wide email for the reply-to
        OrgWideEmailAddress emailAddress = getReferralOrgWideEmailAddress();

        // create email messages containing this information
        Map<Id,Id> taskToReferralMap = new Map<Id,Id>();
        List<Messaging.SingleEmailMessage> messages = createEmailMessages(referralMap, emailAddress, CANT_CONNECT_GUIDANCE_2, taskToReferralMap);

        return messages;
    }

    public static List<Messaging.SingleEmailMessage> createCantConnectGuidance3Emails(Map<Id, Referral__c> referralMap) {
 
        // get the org wide email for the reply-to
        OrgWideEmailAddress emailAddress = getReferralOrgWideEmailAddress();

        // create email messages containing this information
        Map<Id,Id> taskToReferralMap = new Map<Id,Id>();
        List<Messaging.SingleEmailMessage> messages = createEmailMessages(referralMap, emailAddress, CANT_CONNECT_GUIDANCE_3, taskToReferralMap);

        return messages;
    }
   
    public static List<Messaging.SingleEmailMessage> createCantConnectGuidance4Emails(Map<Id, Referral__c> referralMap) {
 
        // get the org wide email for the reply-to
        OrgWideEmailAddress emailAddress = getReferralOrgWideEmailAddress();

        // create email messages containing this information
        Map<Id,Id> taskToReferralMap = new Map<Id,Id>();
        List<Messaging.SingleEmailMessage> messages = createEmailMessages(referralMap, emailAddress, CANT_CONNECT_GUIDANCE_4, taskToReferralMap);

        return messages;
    }

    public static Referral_Response__c createReferralQuestion(String referralId, String emailTemplateType, Id taskId) {
        String question = '';
        //  determine the question that was asked, based on the email template
        if (INITIAL_CLIENT_REFERRAL.equals(emailTemplateType)) {
            question = INITIAL_CLIENT_REFERRAL_QUESTION;
        } else if (CLIENT_REFERRAL_FOLLOWUP.equals(emailTemplateType)) {
            question = CLIENT_REFERRAL_FOLLOWUP_QUESTION;
        } else if (CLIENT_RATE_SERVICE.equals(emailTemplateType)) {
            question = CLIENT_RATE_SERVICE_QUESTION;   
        } else if (CLIENT_HELP_RESPONSE.equals(emailTemplateType)) {
            question = CLIENT_HELP_RESPONSE_QUESTION;
        } else if (CLIENT_CANT_CONNECT.equals(emailTemplateType)) {
            question = CLIENT_CANT_CONNECT_QUESTION;
        } else if (RATE_SERVICE_SAVED.equals(emailTemplateType)) {
            question = RATE_SERVICE_SAVED_QUESTION;
        } else if (CANT_CONNECT_GUIDANCE_1.equals(emailTemplateType)) {
            question = CANT_CONNECT_GUIDANCE_QUESTION_1;
        } else if (CANT_CONNECT_GUIDANCE_2.equals(emailTemplateType)) {
            question = CANT_CONNECT_GUIDANCE_QUESTION_2;
        } else if (CANT_CONNECT_GUIDANCE_3.equals(emailTemplateType)) {
            question = CANT_CONNECT_GUIDANCE_QUESTION_3;
        } else if (CANT_CONNECT_GUIDANCE_4.equals(emailTemplateType)) {
            question = CANT_CONNECT_GUIDANCE_QUESTION_4;
        }

        Referral_Response__c refRec = ReferralResponseHelper.createQuestionRecord(referralId, question, taskId);
        return refRec;
    }
    
    @TestVisible
    private static Map<String,EmailTemplate> getTemplatesByType(String messageType) {

        Set<String> templateNames = new Set<String>();
        if (INITIAL_CLIENT_REFERRAL.equals(messageType)) {
            templateNames.add(INITIAL_CLIENT_REFERRAL_TEXT_TEMPLATE);
            templateNames.add(INITIAL_CLIENT_REFERRAL_TEMPLATE);
        } else if (CLIENT_REFERRAL_FOLLOWUP.equals(messageType)) {
            templateNames.add(CLIENT_REFERRAL_FOLLOWUP_TEXT_TEMPLATE);
            templateNames.add(CLIENT_REFERRAL_FOLLOWUP_TEMPLATE);
        } else if (CLIENT_RATE_SERVICE.equals(messageType)) {
            templateNames.add(CLIENT_RATE_SERVICE_TEXT_TEMPLATE);
            templateNames.add(CLIENT_RATE_SERVICE_TEMPLATE);
        } else if (CLIENT_HELP_RESPONSE.equals(messageType)) {
            templateNames.add(CLIENT_HELP_RESPONSE_TEXT_TEMPLATE);
            templateNames.add(CLIENT_HELP_RESPONSE_TEMPLATE);
        } else if (CLIENT_CANT_CONNECT.equals(messageType)) {
            templateNames.add(CLIENT_CANT_CONNECT_TEXT_TEMPLATE);
            templateNames.add(CLIENT_CANT_CONNECT_TEMPLATE);
        } else if (RATE_SERVICE_SAVED.equals(messageType)) {
            templateNames.add(RATE_SERVICE_SAVED_TEXT_TEMPLATE);
            templateNames.add(RATE_SERVICE_SAVED_TEMPLATE);
        } else if (CANT_CONNECT_GUIDANCE_1.equals(messageType)) {
            templateNames.add(CANT_CONNECT_GUIDANCE_TEXT_TEMPLATE_1);
            templateNames.add(CANT_CONNECT_GUIDANCE_TEMPLATE_1);
        } else if (CANT_CONNECT_GUIDANCE_2.equals(messageType)) {
            templateNames.add(CANT_CONNECT_GUIDANCE_TEXT_TEMPLATE_2);
            templateNames.add(CANT_CONNECT_GUIDANCE_TEMPLATE_2);
        } else if (CANT_CONNECT_GUIDANCE_3.equals(messageType)) {
            templateNames.add(CANT_CONNECT_GUIDANCE_TEXT_TEMPLATE_3);
            templateNames.add(CANT_CONNECT_GUIDANCE_TEMPLATE_3);
        } else if (CANT_CONNECT_GUIDANCE_4.equals(messageType)) {
            templateNames.add(CANT_CONNECT_GUIDANCE_TEXT_TEMPLATE_4);
            templateNames.add(CANT_CONNECT_GUIDANCE_TEMPLATE_4);
        }

        List<EmailTemplate> templates = [
            SELECT
                Id,
                DeveloperName
            FROM EmailTemplate
            WHERE DeveloperName IN :templateNames
        ];
        Map<String,EmailTemplate> templateMap = new Map<String,EmailTemplate>();
        for (EmailTemplate template : templates) {
            if (template.DeveloperName.endsWith('_Text')) {
                templateMap.put(TEXT_CHANNEL,template);
            } else {
                templateMap.put(EMAIL_CHANNEL,template);
            }
            
        }        
        return templateMap;
    }

    private static List<Messaging.SingleEmailMessage> createEmailMessages(Map<Id, Referral__c> referralMap, 
                                                                        OrgWideEmailAddress orgWideEmail, 
                                                                        String emailTemplateType,
                                                                        Map<Id,Id> taskToReferralMap) {

        List<Messaging.SingleEmailMessage> messages = new List<Messaging.SingleEmailMessage>();
        List<Referral_Response__c> referralResponses = new List<Referral_Response__c>();                                                                        
        if (taskToReferralMap.isEmpty()) {
            for (Id referralId : referralMap.keySet()) {
                // create the referral response record
                Id taskId = null;
                Referral_Response__c refResp = createReferralQuestion(referralId, emailTemplateType, taskId);
                referralResponses.add(refResp);
            }
        } else {
            for (Id taskId : taskToReferralMap.keySet()) {
                // create the referral response record, containing the task id
                Id referralId = taskToReferralMap.get(taskId);
                Referral_Response__c refResp = createReferralQuestion(referralId, emailTemplateType, taskId);
                referralResponses.add(refResp);
            }
        }

        // save all the referral question records to the database
        referralResponses = ReferralResponseHelper.saveQuestionRecords(referralResponses);

        // create the email messages
        for (Referral_Response__c refResp : referralResponses) {
            string peferedChannel=referralMap.get(refResp.Referral__c).Preferred_Channel__c;
            if(peferedChannel=='Email;SMS' || peferedChannel=='SMS; Email' ){
                referralMap.get(refResp.Referral__c).Preferred_Channel__c='SMS';
                messages.add(createEmail(referralMap, orgWideEmail, emailTemplateType, refResp, refResp.Referral__c));
                referralMap.get(refResp.Referral__c).Preferred_Channel__c='Email';
                messages.add(createEmail(referralMap, orgWideEmail, emailTemplateType, refResp, refResp.Referral__c));
                referralMap.get(refResp.Referral__c).Preferred_Channel__c=peferedChannel;
            }
            else{
                Messaging.SingleEmailMessage message = createEmail(referralMap, orgWideEmail, emailTemplateType, refResp, refResp.Referral__c);
                messages.add(message);
                }
        }

        return messages;
    }

    private static Messaging.SingleEmailMessage createEmail(Map<Id, Referral__c> referralMap, 
                                                            OrgWideEmailAddress orgWideEmail, 
                                                            String emailTemplateType,
                                                            Referral_Response__c refResp,
                                                            Id referralId) {
        Map<String,EmailTemplate> templateMap = getTemplatesByType(emailTemplateType); 
        Id templateId = null;
        if (referralMap.get(referralId).Preferred_Channel__c != null) {
            EmailTemplate template = templateMap.get(referralMap.get(referralId).Preferred_Channel__c);
            if (template != null) {
                templateId = template.Id;
            }
        }                                                      

        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        if (orgWideEmail != null) {
            message.setOrgWideEmailAddressId(orgWideEmail.Id);
        }
        message.setTemplateId(templateId);
        message.setTargetObjectId(referralMap.get(referralId).Contact__c);
        message.setWhatId(refResp.Id);
        message.setUseSignature(false);
        
        return message;
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
                Contact__c,
                Preferred_Channel__c,
                Owner.Name,
                Owner.Email
            FROM Referral__c 
            WITH SECURITY_ENFORCED
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
            WHERE DeveloperName = :REF_REC_SETTINGS_RECORD_DEVELOPER_NAME
        ];

        if (settings.size() > 0) {
            String recommendationsAddress = String.escapeSingleQuotes(settings[0].Recommendations_Email_Service_Address__c);
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

    public static void sendHelpMailToCaseManager(Id referralResponseId) {
        OrgWideEmailAddress orgWideEmail = getReferralOrgWideEmailAddress();
        // get the email template for this kind of message
        EmailTemplate template = [
            SELECT 
                Id,
                DeveloperName
            FROM EmailTemplate  
            WHERE DeveloperName = :CASE_MANAGER_HELP_TEMPLATE
        ][0];

        List<Referral_Response__c> referralResponses = [
            SELECT
                Id,
                Referral__r.OwnerId,
                Referral__r.Owner.Email
            FROM Referral_Response__c
            WHERE Id = :referralResponseId WITH
            SECURITY_ENFORCED
        ];

        // create the email message
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        if (orgWideEmail != null) {
            message.setOrgWideEmailAddressId(orgWideEmail.Id);
        }
        message.setTemplateId(template.Id);
        message.setTargetObjectId(referralResponses[0].Referral__r.OwnerId);
        message.setWhatId(referralResponseId);
        message.setUseSignature(false);
        message.setSaveAsActivity(false);
        
        // send the email
        Messaging.sendEmail( new List<Messaging.SingleEmailMessage>{ message } );

    }
}