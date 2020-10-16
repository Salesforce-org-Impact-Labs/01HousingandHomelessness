public with sharing class RecommendationsInboundEmailHandler implements Messaging.InboundEmailHandler {
    // the referral response id should follow this token in the subject line
    public static final String EMAIL_REFERRAL_RESPONSE_TOKEN = 'ref#';
    public static final Integer REFERRAL_RESPONSE_ID_LENGTH = 18;
    public static final String EMAIL_REPLY_YES = 'YES';
    public static final String EMAIL_REPLY_NO = 'NO';
    public static final String EMAIL_REPLY_HELP = 'HELP';
    public static final Integer RESPONSE_TRUNCATION_LEN = 10;

    // key string to find the org-wide email verification link
    public static final String CONFIRM_EMAIL_LINK_KEY = 'Click this link to confirm this Organization-Wide Email Address:';

    public Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
        Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();

        // create a task for the org-wide email address verification link
        if (email.plainTextBody.containsIgnoreCase(CONFIRM_EMAIL_LINK_KEY)) {
            createEmailConfirmTask(email.plainTextBody);
        }

        if (email.plainTextBody.containsIgnoreCase(EMAIL_REFERRAL_RESPONSE_TOKEN)) {
            // get the referral response id from the body of the reply
            String referralResponseId = 
                email.plainTextBody.substringAfterLast(EMAIL_REFERRAL_RESPONSE_TOKEN);
            referralResponseId = referralResponseId.substring(0,REFERRAL_RESPONSE_ID_LENGTH);

            if (referralResponseId != null) {
                // get the referral response record from the database
                Referral_Response__c refResponse = getReferralResponse(referralResponseId);
                String referralId = refResponse.Referral__c;

                // if we can parse out the referral response Id, we need to see what they replied with
                handleClientResponse(email.plainTextBody, refResponse, referralId);
            }

        }
          
        return result;
    }

    @TestVisible
    private static void handleClientResponse(String emailPlainTextBody, Referral_Response__c refResponse, String referralId) {
        String referralResponseId = refResponse.Id;
        // we need to parse out their response, which would be in the first portion of the response
        String truncatedResponse = emailPlainTextBody.left(RESPONSE_TRUNCATION_LEN);
        String firstChar = truncatedResponse.substring(0,1);

        if (truncatedResponse.containsIgnoreCase(EMAIL_REPLY_YES)) {
            // they met with the referral
            ReferralResponseHelper.updateRecordWithResponse(referralResponseId, EMAIL_REPLY_YES);
            EmailService.sendClientRateExperienceMessage(referralId);
        } else if (truncatedResponse.containsIgnoreCase(EMAIL_REPLY_NO)) {
            // they were unable to meet with the referral
            ReferralResponseHelper.updateRecordWithResponse(referralResponseId, EMAIL_REPLY_NO);
            EmailService.sendClientCantConnectMessage(referralId);
        } else if (truncatedResponse.containsIgnoreCase(EMAIL_REPLY_HELP)) {
            // they need help
            ReferralResponseHelper.updateRecordWithResponse(referralResponseId, EMAIL_REPLY_HELP);
            EmailService.sendClientHelpResponseMessage(referralId);
            // also alert the case manager
            ClientMessageHelper.sendHelpMailToCaseManager(referralResponseId);
        } else if (firstChar.equals('1') ||
                    firstChar.equals('2') ||
                    firstChar.equals('3') ||
                    firstChar.equals('4') || 
                    firstChar.equals('5') ) {
            // determine the question that was asked so we can handle the response correctly
            if (ClientMessageHelper.CLIENT_RATE_SERVICE_QUESTION.equals(refResponse.Question__c)) {
                // save the score to the referral record, etc
                Integer score = Integer.valueOf(firstChar);
                ReferralResponseHelper.saveReferralScore(referralId, score);
                ReferralResponseHelper.updateRecordWithResponse(referralResponseId, firstChar);
                // send response email to client
                EmailService.sendRateServiceSavedMessage(referralId);

            } else if (firstChar.equals('1') && ClientMessageHelper.CLIENT_CANT_CONNECT_QUESTION.equals(refResponse.Question__c)) {
                // they didn't have time for the appt
                ReferralResponseHelper.updateRecordWithResponse(referralResponseId, firstChar);
                // send response email to client
                EmailService.sendCantConnectGuidance1Message(referralId);

            } else if (firstChar.equals('2') && ClientMessageHelper.CLIENT_CANT_CONNECT_QUESTION.equals(refResponse.Question__c)) {
                // the service didn't respond
                ReferralResponseHelper.updateRecordWithResponse(referralResponseId, firstChar);
                // send response email to client
                EmailService.sendCantConnectGuidance2Message(referralId);
                // create a new referral
                createNewReferralAndTask(refResponse);

            } else if (firstChar.equals('3') && ClientMessageHelper.CLIENT_CANT_CONNECT_QUESTION.equals(refResponse.Question__c)) {
                // the referral information was wrong
                ReferralResponseHelper.updateRecordWithResponse(referralResponseId, firstChar);
                // send response email to client
                EmailService.sendCantConnectGuidance3Message(referralId);
                // create a new referral
                createNewReferralAndTask(refResponse);

            } else if (firstChar.equals('4') && ClientMessageHelper.CLIENT_CANT_CONNECT_QUESTION.equals(refResponse.Question__c)) {
                // something else happened
                ReferralResponseHelper.updateRecordWithResponse(referralResponseId, firstChar);
                // send response email to client
                EmailService.sendCantConnectGuidance4Message(referralId);
            }
        } else if (ClientMessageHelper.CANT_CONNECT_GUIDANCE_QUESTION_4.equals(refResponse.Question__c)) {
            // they couldn't connect, answered '4' to indicate something 'Other' got in the way, and this is their response
            String truncatedBody = emailPlainTextBody.left(254);
            ReferralResponseHelper.updateRecordWithResponse(referralResponseId, truncatedBody);
        }

      }

      @TestVisible
      private static void createEmailConfirmTask(String emailBody) {
        // get the running user
        Id runningUserId = UserInfo.getUserId();

        // create the task and assign it to the user
        Task confirmTask = new Task(
            Subject = 'Confirm Organization-Wide Email Address',
            Status = 'Not Started',
            OwnerId = runningUserId,
            Description = emailBody
        );
        /* Task confirmTask = new Task();
        if (Schema.SObjectType.Task.fields.Subject.isCreateable()) {
            confirmTask.Subject = 'Confirm Organization-Wide Email Address';
        }
        if (Schema.SObjectType.Task.fields.Status.isCreateable()) {
            confirmTask.Status = 'Not Started';
        }
        if (Schema.SObjectType.Task.fields.OwnerId.isCreateable()) {
            confirmTask.OwnerId = runningUserId;
        }
        if (Schema.SObjectType.Task.fields.Description.isCreateable()) {
            confirmTask.Description = emailBody;
        }*/
             
         if (!Schema.sObjectType.Task.isCreateable()){
        throw new emailServicenException(
                System.Label.flsError);
           
         } else { 
             insert confirmTask;
        }

        
        
      }

      @TestVisible
      private static Referral_Response__c getReferralResponse(String referralResponseId) {
        
        if (!Schema.sObjectType.Referral_Response__c.isAccessible()){
            throw new emailServicenException(
                    System.Label.flsError);
               
             } else { 

        Referral_Response__c response = new Referral_Response__c();  
        List<Referral_Response__c> responses = [
            SELECT
                Id,
                Referral__c,
                Referral__r.Service__r.Type__c,
                Referral__r.Contact__c,
                Referral__r.Preferred_Channel__c,
                Question__c,
                Response__c
            FROM Referral_Response__c
            WHERE Id = :referralResponseId
        ];
        if (responses.size() > 0) {
            response = responses[0];
        }
        return response;

                    }
      }

      @TestVisible
      private static void createNewReferralAndTask(Referral_Response__c refResponse) {

        if (!Schema.sObjectType.Referral__c.isCreateable()){
            throw new emailServicenException(
                System.Label.flsError);
               
             } else { 
        // get the next recommended service of the same type
        Service__c recService = 
            getNextServiceRecommendationForClient(refResponse.Referral__r.Contact__c, refResponse.Referral__r.Service__r.Type__c);
            
        if (recService != null) {
            // create the new referral
            Referral__c newReferral = createNewReferralCopy(refResponse.Referral__r.Contact__c, refResponse.Referral__r.Preferred_Channel__c);
                   if (Schema.SObjectType.Referral__c.fields.Service__c.isCreateable()) {
                newReferral.Service__c = recService.Id;
            }
            insert newReferral;
            // create a new task for the next batch job run
            Task newTask = createReferralTask(newReferral.Id);
            insert newTask;
        }
                    }
      }

      @TestVisible
      private static Referral__c createNewReferralCopy(Id contactId, String preferredChannel) {
        Referral__c newReferral = new Referral__c ();
        if (Schema.SObjectType.Referral__c.fields.Contact__c.isCreateable()) {
            newReferral.Contact__c = contactId;
        }
        if (Schema.SObjectType.Referral__c.fields.Preferred_Channel__c.isCreateable()) {
            newReferral.Preferred_Channel__c = preferredChannel;
        }

        return newReferral;
      }

      @TestVisible
      private static Task createReferralTask(Id referralId) {
        // get the running user
        Id runningUserId = UserInfo.getUserId();

        // create the task and assign it to the user
        Task referralTask = new Task();
        if (Schema.SObjectType.Task.fields.Subject.isCreateable()) {
            referralTask.Subject = 'Info to Client';
        }
        if (Schema.SObjectType.Task.fields.Status.isCreateable()) {
            referralTask.Status = 'Not Started';
        }
        if (Schema.SObjectType.Task.fields.OwnerId.isCreateable()) {
            referralTask.OwnerId = runningUserId;
        }
        if (Schema.SObjectType.Task.fields.WhatId.isCreateable()) {
            referralTask.WhatId = referralId;
        }

        return referralTask;
      }

      @TestVisible
      private static Service__c getNextServiceRecommendationForClient(Id contactId, String serviceType) {
        List<ServiceRecommendation> recommendationsList = getRecommendations.getRecommendations(contactId);

        Service__c nextService = null;
        for (ServiceRecommendation recommendation : recommendationsList) {
            // get the first recommendation with the specified type
            if (recommendation.Service.Type__c != null && recommendation.Service.Type__c.equals(serviceType)) {
                nextService = recommendation.Service;
                break;
            }
        }

        return nextService;
      }
     
    public class EmailServicenException extends Exception {
    }
  }