public class Batch_SendInitialClientReferrals implements Database.Batchable<SObject>, Schedulable {
    private static final String REMINDER_TASK_SUBJECT = 'Info to Client';
    private static final String TASK_STATUS_COMPLETED = 'Completed';

    public Database.QueryLocator start(Database.BatchableContext context) {
        // select referrals for which we have sent no messages
        return Database.getQueryLocator([
            SELECT
                Id,
                WhatId,
                Status
            FROM Task
            WHERE Subject = :REMINDER_TASK_SUBJECT
            AND Status != :TASK_STATUS_COMPLETED
        ]);
    }

    public void execute(Database.BatchableContext context, List<Task> referralTasks) {
        // get the referral ids from each task
        List<Id> referralIds = new List<Id>();
        Map<Id,Id> taskToReferralMap = new Map<Id,Id>();
        for (Task referralTask : referralTasks) {
            String escapedWhatId = String.escapeSingleQuotes(referralTask.WhatId);
            if (!referralIds.contains(escapedWhatId)) {
                referralIds.add(escapedWhatId); // the whatId holds the id of the referral
            }
            taskToReferralMap.put(referralTask.Id, escapedWhatId);
        }
        // send the emails
        if (!referralIds.isEmpty()) {
            EmailService.sendInitialReferralMessages(taskToReferralMap);
        }
   }

    public void finish(Database.BatchableContext context) {
        // nothing to do here
    }

    public void execute(SchedulableContext context) {
        Database.executeBatch(new Batch_SendInitialClientReferrals());
    }
}
