global class RecommendationsInboundEmailHandler implements Messaging.InboundEmailHandler {
        // the referral id should follow this token in the subject line
        private static final String EMAIL_SUBJECT_REFERRAL_TOKEN = 'ref#';
        private static final String EMAIL_REPLY_YES = 'YES';
        private static final String EMAIL_REPLY_NO = 'NO';
        private static final String EMAIL_REPLY_HELP = 'HELP';


    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
          Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();

          if (email.subject.containsIgnoreCase(EMAIL_SUBJECT_REFERRAL_TOKEN)) {
            // get the referral id from the subject
            String referralId = email.subject.substring(email.subject.indexOf(EMAIL_SUBJECT_REFERRAL_TOKEN));

            if (referralId != null) {
                // if we can parse out the referral Id, we need to see what they replied with
                if (email.plainTextBody.containsIgnoreCase(EMAIL_REPLY_YES)) {
                    // they met with the referral
                } else if (email.plainTextBody.containsIgnoreCase(EMAIL_REPLY_NO)) {
                    // they were unable to meet with the referral
                } else if (email.plainTextBody.containsIgnoreCase(EMAIL_REPLY_HELP)) {
                    // they need help
                }
            }

          }
          
          return result;
      }


  }