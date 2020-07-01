global class RecommendationsInboundEmailHandler implements Messaging.InboundEmailHandler {
        // the referral response id should follow this token in the subject line
        private static final String EMAIL_REFERRAL_RESPONSE_TOKEN = 'ref#';
        private static final Integer REFERRAL_RESPONSE_ID_LENGTH = 18;
        private static final String EMAIL_REPLY_YES = 'YES';
        private static final String EMAIL_REPLY_NO = 'NO';
        private static final String EMAIL_REPLY_HELP = 'HELP';
        private static final Integer RESPONSE_TRUNCATION_LEN = 10;


    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
        Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
        System.debug('RecommendationsInboundEmailHandler received text of email '+email.plainTextBody);

        if (email.plainTextBody.containsIgnoreCase(EMAIL_REFERRAL_RESPONSE_TOKEN)) {
            // get the referral response id from the body of the reply
            String referralResponseId = 
                email.plainTextBody.substringAfterLast(EMAIL_REFERRAL_RESPONSE_TOKEN);
            referralResponseId = referralResponseId.substring(0,REFERRAL_RESPONSE_ID_LENGTH);

            if (referralResponseId != null) {
                // get the referral response record from the database
                Referral_Response__c refResponse = getReferralResponse(referralResponseId);
                String referralId = refResponse.Response__c;

                // we need to parse out their response, which would be in the first portion of the response
                String truncatedResponse = email.plainTextBody.left(RESPONSE_TRUNCATION_LEN);
                String firstChar = truncatedResponse.substring(0,1);

                // if we can parse out the referral response Id, we need to see what they replied with
                handleClientResponse(truncatedResponse, firstChar, refResponse, referralId);
            }

        }
          
        return result;
    }

    @TestVisible
    private void handleClientResponse(String truncatedResponse, String firstChar, Referral_Response__c refResponse, String referralId) {
        String referralResponseId = refResponse.Id;

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
        } else if (firstChar.equals('1') ||
                    firstChar.equals('2') ||
                    firstChar.equals('3') ||
                    firstChar.equals('4') || 
                    firstChar.equals('5') ) {
            // save the score to the referral record, etc
            Integer score = Integer.valueOf(firstChar);
            ReferralResponseHelper.saveReferralScore(referralId, score);
            ReferralResponseHelper.updateRecordWithResponse(referralResponseId, firstChar);
            // send response email to client
            EmailService.sendRateServiceSavedMessage(referralId);
        }

      }

      @TestVisible
      private static Referral_Response__c getReferralResponse(String referralResponseId) {
        Referral_Response__c response = new Referral_Response__c();  
        List<Referral_Response__c> responses = [
            SELECT
                Id,
                Referral__c,
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