public with sharing class ReferralResponseHelper {
    
    public static void saveReferralScore(Id referralId, Integer score) {
        if (referralId != null && score != null) {
            Referral__c refer = new Referral__c (
                Id = referralId,
                Score__c = score
            );
        if (Schema.sObjectType.Referral__c.fields.Score__c.isUpdateable()){
            update refer;
        }
        }
    }

    public static Referral_Response__c createQuestionRecord(String referralId, String question, Id taskId) {
        Referral_Response__c refRes = new Referral_Response__c (
            Referral__c = referralId,
            Question__c = question,
            Task_Id__c = taskId
        );

        return refRes;
    }

    public static List<Referral_Response__c> saveQuestionRecords(List<Referral_Response__c> referralResponses) {
        insert referralResponses;
        return referralResponses;
    }

    public static Referral_Response__c updateRecordWithResponse(String referralResponseId, String response) {
        Referral_Response__c refRes = new Referral_Response__c (
            Id = referralresponseId,
            Response__c = response
        );
        if (Schema.sObjectType.Referral_Response__c.fields.Response__c.isUpdateable()){
            update refRes;
        }

        return refRes;
    }
}