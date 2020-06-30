public with sharing class ReferralResponseHelper {
    
    public static void saveReferralScore(Id referralId, Integer score) {
        if (referralId != null && score != null) {
            Referral__c refer = new Referral__c (
                Id = referralId,
                Score__c = score
            );
            update refer;
        }
    }

    public static Referral_Response__c createQuestionRecord(String referralId, String question) {
        Referral_Response__c refRes = new Referral_Response__c (
            Referral__c = referralId,
            Question__c = question
        );
        insert refRes;

        return refRes;
    }
}
