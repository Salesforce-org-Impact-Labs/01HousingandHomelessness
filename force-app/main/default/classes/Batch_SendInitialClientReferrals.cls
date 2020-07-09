global class Batch_SendInitialClientReferrals implements Database.Batchable<SObject>, Schedulable {
    private static final String REMINDER_TASK_SUBJECT = 'Info to Client';
    private static final String TASK_STATUS_COMPLETED = 'Completed';

    global Database.QueryLocator start(Database.BatchableContext context) {
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

    global void execute(Database.BatchableContext context, List<Task> referralTasks) {
        // get the referral ids from each task
        List<Id> referralIds = new List<Id>();
        for (Task referralTask : referralTasks) {
            if (!referralIds.contains(referralTask.WhatId)) {
                referralIds.add(referralTask.WhatId);
            }
    }
        // send the emails
        if (!referralIds.isEmpty()) {
            EmailService.sendInitialReferralMessages(referralIds);
        }
        // update the tasks to completed
        for (Task completedTask : referralTasks) {
            completedTask.Status = TASK_STATUS_COMPLETED;
        }
        update referralTasks;
    }

    global void finish(Database.BatchableContext context) {
        // nothing to do here
    }

    global void execute(SchedulableContext context) {
        Database.executeBatch(new Batch_SendInitialClientReferrals());
    }
}
