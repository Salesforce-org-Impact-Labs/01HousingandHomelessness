global class RecommendationsInboundEmailHandler implements Messaging.InboundEmailHandler {
        // the referral id should follow this token in the subject line
        private static final String EMAIL_REFERRAL_TOKEN = 'ref#';
        private static final Integer REFERRAL_ID_LENGTH = 18;
        private static final String EMAIL_REPLY_YES = 'YES';
        private static final String EMAIL_REPLY_NO = 'NO';
        private static final String EMAIL_REPLY_HELP = 'HELP';
        private static final Integer RESPONSE_TRUNCATION_LEN = 10;


    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
          Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
          System.debug('RecommendationsInboundEmailHandler received text of email '+email.plainTextBody);

          if (email.plainTextBody.containsIgnoreCase(EMAIL_REFERRAL_TOKEN)) {
            // get the referral id from the body of the reply
            String referralId = 
                email.plainTextBody.substringAfterLast(EMAIL_REFERRAL_TOKEN);
            referralId = referralId.substring(0,REFERRAL_ID_LENGTH);

            if (referralId != null) {
                // we need to parse out their response, which would be in the first portion of the response
                String truncatedResponse = email.plainTextBody.left(RESPONSE_TRUNCATION_LEN);
                String firstChar = truncatedResponse.substring(0,1);

                // if we can parse out the referral Id, we need to see what they replied with
                if (truncatedResponse.containsIgnoreCase(EMAIL_REPLY_YES)) {
                    // they met with the referral
                    EmailService.sendClientRateExperienceMessage(referralId);
                } else if (truncatedResponse.containsIgnoreCase(EMAIL_REPLY_NO)) {
                    // they were unable to meet with the referral
                    EmailService.sendClientCantConnectMessage(referralId);
                } else if (truncatedResponse.containsIgnoreCase(EMAIL_REPLY_HELP)) {
                    // they need help
                    EmailService.sendClientHelpResponseMessage(referralId);
                } else if (firstChar.equals('1') ||
                            firstChar.equals('2') ||
                            firstChar.equals('3') ||
                            firstChar.equals('4') || 
                            firstChar.equals('5') ) {
                    // save the score to the referral record, etc
                    Integer score = Integer.valueOf(firstChar);
                    ReferralResponseHelper.saveReferralScore(referralId, score);
                }
            }

          }
          
          return result;
      }


  }