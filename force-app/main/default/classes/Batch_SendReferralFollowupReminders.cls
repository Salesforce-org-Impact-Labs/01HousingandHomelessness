global with sharing class Batch_SendReferralFollowupReminders implements Database.Batchable<SObject>, Schedulable {
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
            WHERE Subject = :REMINDER_TASK_SUBJECT
            AND Status != :TASK_STATUS_COMPLETED
        ]);
    }

    global void execute(Database.BatchableContext context, List<Task> reminderTasks) {
        if (!reminderTasks.isEmpty()) {
            // get the referral ids from each task
            List<Id> referralIds = new List<Id>();
            Map<Id,Id> taskToReferralMap = new Map<Id,Id>();
            for (Task reminderTask : reminderTasks) {
                String escapedWhatId = String.escapeSingleQuotes(reminderTask.WhatId);
                if (!referralIds.contains(escapedWhatId)) { // the whatId holds the id of the referral
                    referralIds.add(escapedWhatId);
                }
                taskToReferralMap.put(reminderTask.Id, escapedWhatId);
            }
            if (!referralIds.isEmpty()) {
                // send the messages
                EmailService.sendReferralFollowupMessages(taskToReferralMap);
            }
        }
    }

    global void finish(Database.BatchableContext context) {
        // nothing to do here
    }

    global void execute(SchedulableContext context) {
        Database.executeBatch(new Batch_SendInitialClientReferrals());
    }
}