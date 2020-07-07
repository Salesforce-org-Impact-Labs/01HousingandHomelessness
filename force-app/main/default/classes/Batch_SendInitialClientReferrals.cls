global class Batch_SendInitialClientReferrals implements Database.Batchable<SObject>, Schedulable {

    global Database.QueryLocator start(Database.BatchableContext context) {
        // select referrals for which we have sent no messages
        return Database.getQueryLocator([
            SELECT
                Id
            FROM Referral__c
            WHERE Id NOT IN (SELECT Referral__c FROM Referral_Response__c)
        ]);
    }

    global void execute(Database.BatchableContext context, List<Referral__c> referrals) {
        if (!referrals.isEmpty()) {
            List<Id> referralIds = new List<Id>();
            for (Referral__c referral : referrals) {
                referralIds.add(referral.Id);
            }
            EmailService.sendInitialReferralMessages(referralIds);
        }
    }

    global void finish(Database.BatchableContext context) {
        // nothing to do here
    }

    global void execute(SchedulableContext context) {
        Database.executeBatch(new Batch_SendInitialClientReferrals());
    }
}
