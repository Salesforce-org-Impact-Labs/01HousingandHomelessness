global class Batch_SendReferralFollowupReminders implements Database.Batchable<SObject>, Schedulable {
    private static final String REMINDER_TASK_SUBJECT = 'Reminder';
    private static final String TASK_STATUS_COMPLETED = 'Completed';

    global Database.QueryLocator start(Database.BatchableContext context) {
        // get 
        return Database.getQueryLocator([
            SELECT
                Id,
                WhatId,
                Status
            FROM Task
            WHERE ActivityDate = TODAY
            AND Subject = :REMINDER_TASK_SUBJECT
            AND Status != :TASK_STATUS_COMPLETED
        ]);
    }

    global void execute(Database.BatchableContext context, List<Task> reminderTasks) {
        if (!reminderTasks.isEmpty()) {
            // get the referral ids from each task
            List<Id> referralIds = new List<Id>();
            for (Task reminderTask : reminderTasks) {
                referralIds.add(reminderTask.WhatId);
            }
            // send the messages
            EmailService.sendReferralFollowupMessages(referralIds);
            // update the tasks to completed
            for (Task completedTask : reminderTasks) {
                completedTask.Status = TASK_STATUS_COMPLETED;
            }
            update reminderTasks;
        }
    }

    global void finish(Database.BatchableContext context) {
        // nothing to do here
    }

    global void execute(SchedulableContext context) {
        Database.executeBatch(new Batch_SendInitialClientReferrals());
    }
}

