public with sharing class EmailService {

    public static void sendInitialReferralMessages(Map<Id,Id> taskToReferralMap) {
        // get the referral records
        Map<Id, Referral__c> referralMap = ClientMessageHelper.getReferralRecords(taskToReferralMap.values());
        // create the emails
        List<Messaging.SingleEmailMessage> emails = ClientMessageHelper.createInitialClientReferralEmails(referralMap, taskToReferralMap);
        // prep and send the emails
        prepareAndSendEmails(emails, referralMap);
    }

    public static void sendReferralFollowupMessages(Map<Id,Id> taskToReferralMap) {
        // get the referral records
        Map<Id, Referral__c> referralMap = ClientMessageHelper.getReferralRecords(taskToReferralMap.values());
        // create the emails
        List<Messaging.SingleEmailMessage> emails = ClientMessageHelper.createReferralFollowupEmails(referralMap, taskToReferralMap);
        // prep and send the emails
        prepareAndSendEmails(emails, referralMap);
    }

    public static void sendClientRateExperienceMessage(Id referralId) {
        // get the referral records
        Map<Id, Referral__c> referralMap = ClientMessageHelper.getReferralRecords(new List<Id>{referralId});
        // create the emails
        List<Messaging.SingleEmailMessage> emails = ClientMessageHelper.createReferralRateServiceEmails(referralMap);
        // prep and send the emails
        prepareAndSendEmails(emails, referralMap);
    }

    public static void sendClientHelpResponseMessage(Id referralId) {
        // get the referral records
        Map<Id, Referral__c> referralMap = ClientMessageHelper.getReferralRecords(new List<Id>{referralId});
        // create the emails
        List<Messaging.SingleEmailMessage> emails = ClientMessageHelper.createClientHelpResponseEmails(referralMap);
        // prep and send the emails
        prepareAndSendEmails(emails, referralMap);
    }

    public static void sendClientCantConnectMessage(Id referralId) {
        // get the referral records
        Map<Id, Referral__c> referralMap = ClientMessageHelper.getReferralRecords(new List<Id>{referralId});
        // create the emails
        List<Messaging.SingleEmailMessage> emails = ClientMessageHelper.createClientCantConnectEmails(referralMap);
        // prep and send the emails
        prepareAndSendEmails(emails, referralMap);
    }

    public static void sendRateServiceSavedMessage(Id referralId) {
        // get the referral records
        Map<Id, Referral__c> referralMap = ClientMessageHelper.getReferralRecords(new List<Id>{referralId});
        // create the emails
        List<Messaging.SingleEmailMessage> emails = ClientMessageHelper.createRateServiceSavedEmails(referralMap);
        // prep and send the emails
        prepareAndSendEmails(emails, referralMap);
    }

    public static void sendCantConnectGuidance1Message(Id referralId) {
        // get the referral records
        Map<Id, Referral__c> referralMap = ClientMessageHelper.getReferralRecords(new List<Id>{referralId});
        // create the emails
        List<Messaging.SingleEmailMessage> emails = ClientMessageHelper.createCantConnectGuidance1Emails(referralMap);
        // prep and send the emails
        prepareAndSendEmails(emails, referralMap);
    }

    public static void sendCantConnectGuidance2Message(Id referralId) {
        // get the referral records
        Map<Id, Referral__c> referralMap = ClientMessageHelper.getReferralRecords(new List<Id>{referralId});
        // create the emails
        List<Messaging.SingleEmailMessage> emails = ClientMessageHelper.createCantConnectGuidance2Emails(referralMap);
        // prep and send the emails
        prepareAndSendEmails(emails, referralMap);
    }

    public static void sendCantConnectGuidance3Message(Id referralId) {
        // get the referral records
        Map<Id, Referral__c> referralMap = ClientMessageHelper.getReferralRecords(new List<Id>{referralId});
        // create the emails
        List<Messaging.SingleEmailMessage> emails = ClientMessageHelper.createCantConnectGuidance3Emails(referralMap);
        // prep and send the emails
        prepareAndSendEmails(emails, referralMap);
    }

    public static void sendCantConnectGuidance4Message(Id referralId) {
        // get the referral records
        Map<Id, Referral__c> referralMap = ClientMessageHelper.getReferralRecords(new List<Id>{referralId});
        // create the emails
        List<Messaging.SingleEmailMessage> emails = ClientMessageHelper.createCantConnectGuidance4Emails(referralMap);
        // prep and send the emails
        prepareAndSendEmails(emails, referralMap);
    }

    public static void prepareAndSendEmails(List<Messaging.SingleEmailMessage> emails, Map<Id, Referral__c> referralMap) {
        Map<Id,Messaging.SingleEmailMessage> contactIdEmailMap = ClientMessageHelper.getContactEmailMap(emails);
        
        Map<Id,Contact> clientContactMap = createClientContactMap(contactIdEmailMap.keySet());
        List<ContactMessage> contactMessages = new List<ContactMessage>();
        for (Messaging.SingleEmailMessage email : emails) {
            Id contactId = email.getTargetObjectId();
            ContactMessage contMsg = new ContactMessage();
            contMsg.clientContact = clientContactMap.get(contactId);
            contMsg.messageToSend = email;
            contactMessages.add(contMsg);
        }

        // try to send the messages
        sendMessageToContact(contactMessages, clientContactMap, referralMap);
    }
    
    public static void sendMessageToContact (List<ContactMessage> contactMessages, 
                                            Map<Id,Contact> clientContactMap, 
                                            Map<Id, Referral__c> referralMap) {

        List<Contact> contactsToUpdate = new List<Contact>();
        List<Task> tasksToUpdate = new List<Task>();

        // we need to get the referral id from the referral response record
        //  the id to this record will be in the WhatId field on the email
        Set<Id> referralResponseIds = new Set<Id>();
        for (ContactMessage contMsg : contactMessages) {
            Messaging.SingleEmailMessage email = contMsg.messageToSend;
            referralResponseIds.add(email.getWhatId());
        }
        List<Referral_Response__c> referralResponses = [
            SELECT 
                Id,
                Referral__c,
                Task_Id__c
            FROM Referral_Response__c
            WHERE Id IN :referralResponseIds
        ];
        Map<Id, Id> referralResponseIdToReferralIdMap = new Map<Id, Id>();
        Map<Id, Id> referralResponseIdToTaskIdMap = new Map<Id, Id>();
        for (Referral_Response__c refResp : referralResponses) {
            referralResponseIdToReferralIdMap.put(refResp.Id, refResp.Referral__c);
            referralResponseIdToTaskIdMap.put(refResp.Id, refResp.Task_Id__c);
        }

        for (ContactMessage contactMsg : contactMessages) {
            // handle each contact/message, one record at a time
            Contact clientContact = contactMsg.clientContact;
            Messaging.SingleEmailMessage messageToSend = contactMsg.messageToSend;
        
            // flag to indicate if we need to update the contact record
            Boolean contactNeedsUpdate = false; 

            if (messageToSend == null) {
                throw new EmailServiceException('The message to send is empty'); 
            } 
            if (clientContact == null) {
                throw new EmailServiceException('The client contact is empty'); 
            }
                
            // check the contact
            if (clientContact != null) {

                // get the referral id from the email message, via the referral response
                Id referralResponseId = messageToSend.getWhatId();
                Id referralId = referralResponseIdToReferralIdMap.get(referralResponseId);
                // get the referral from the map
                Referral__c theReferral = referralMap.get(referralId);
                // get the task id (if any) from the map
                Id taskId = referralResponseIdToTaskIdMap.get(referralResponseId);
                
                // determine their preferred channel of contact
                if ('Email'.equalsIgnoreCase(theReferral.Preferred_Channel__c)) {
                    // if their preferred channel is email, this becomes easier
                    Messaging.SingleEmailMessage emailToSend = 
                        createEmailForContact (messageToSend, clientContact.Email);
                    Boolean emailWasSent = sendEmail(emailToSend);
                    if (!emailWasSent) {
                        throw new EmailServiceException('Failed to successfully send outgoing email to contact');
                    } else if (taskId != null) {
                        Task completedTask = createTaskToComplete(taskId);
                        tasksToUpdate.add(completedTask);
                    }

                } else if (clientContact.Phone != null) {
                    // if the preferred channel is SMS, we must use their phone number to create an email to the carrier
                    
                    if (clientContact.Mobile_Phone_Carrier__c == null) {
                        // if no carrier, look it up, add it to contact record
                        clientContact.Mobile_Phone_Carrier__c = lookupCarrierByPhone(clientContact.Phone);
                        
                        if (clientContact.Mobile_Phone_Carrier__c == null) {
                            // if still no carrier
                            throw new EmailServiceException('The carrier cannot be found for Contact with Id: '+clientContact.Id);
                        } else {
                            contactNeedsUpdate = true;
                        }
                    }

                    // add the destination to the email, based on the client's carrier
                    Messaging.SingleEmailMessage emailToSend = 
                        createEmailForCarrier (messageToSend, clientContact.Phone, clientContact.Mobile_Phone_Carrier__c);

                    // send email
                    if (emailToSend == null) {
                        // failed to create email
                        throw new EmailServiceException('Failed to create outgoing email to carrier'); 
                    }
                    Boolean emailWasSent = sendEmail(emailToSend);

                    // if email bounced, call carrier lookup
                    if (!emailWasSent) {
                        String carrier = lookupCarrierByPhone (clientContact.Phone);
                        if (carrier == null) {
                            throw new EmailServiceException('Unable to locate carrier for Contact with Id: '+clientContact.Id);
                        }
                        if (!carrier.equals(clientContact.Mobile_Phone_Carrier__c)) {
                            // if carrier is different, add it to contact record, resend email
                            clientContact.Mobile_Phone_Carrier__c = carrier;
                            contactNeedsUpdate = true;

                            emailToSend = 
                                createEmailForCarrier (messageToSend, clientContact.Phone, clientContact.Mobile_Phone_Carrier__c);
                            if (emailToSend == null) {
                                // failed to create email
                                throw new EmailServiceException('Failed to create outgoing email to carrier on retry'); 
                            }  
                            emailWasSent = sendEmail(emailToSend);
                            if (!emailWasSent) {
                                throw new EmailServiceException('Failed to successfully send outgoing email to carrier on retry');
                            }  else if (taskId != null) {
                                Task completedTask = createTaskToComplete(taskId);
                                tasksToUpdate.add(completedTask);
                            }
                        }
                    } else if (taskId != null) {
                        Task completedTask = createTaskToComplete(taskId);
                        tasksToUpdate.add(completedTask);
                   }

                    // if contacts need to be updated, then add it to the list for update
                    if (contactNeedsUpdate) {
                            contactsToUpdate.add(clientContact);
                    }

                    // all is well

                } else {
                        // contact found but phone is missing
                        throw new EmailServiceException('Failed to find Phone on the Contact record for Contact Id: '+clientContact.Id); 
                }
    
            } else {
                // contact wasn't found
                throw new EmailServiceException('Failed to find Contact record for Contact Id: '+clientContact.Id);
            } 

        }
        // update any contacts that have been changed (eg the mobile carrier has been changed)
        if (!contactsToUpdate.isEmpty()) {
            update contactsToUpdate;
        }
        // update any tasks that have been completed
        if (!tasksToUpdate.isEmpty()) {
            update tasksToUpdate;
        }
    }

    @TestVisible
    private static Boolean sendEmail(Messaging.SingleEmailMessage emailToSend) {
        Messaging.SendEmailResult[] results = Messaging.sendEmail( new List<Messaging.SingleEmailMessage>{ emailToSend } );

        for (Messaging.SendEmailResult result : results) {
            if (!result.isSuccess()) { 
                Messaging.SendEmailError[] errors = result.getErrors();
                for (Messaging.SendEmailError error : errors) {
                    // TODO is this okay?
                    if (error.getMessage().contains('bounced')) {
                        return false;
                    }
                }
            }
        }

        return true;
    }

    @TestVisible
    private static Messaging.SingleEmailMessage createEmailForCarrier(Messaging.SingleEmailMessage messageToSend, String phoneNumber, String carrierName) {

        String carrierEmail = convertPhoneToCarrierEmail (phoneNumber, carrierName);
        if (carrierEmail == null) {
            return null;
        }

        messageToSend.setToAddresses(new List<String>{carrierEmail});

        return messageToSend;
    }

    @TestVisible
    private static Messaging.SingleEmailMessage createEmailForContact (Messaging.SingleEmailMessage messageToSend, String contactEmail) {
        messageToSend.setToAddresses(new List<String>{contactEmail});

        return messageToSend;
    }

    @TestVisible
    private static String convertPhoneToCarrierEmail (String phoneNumber, String carrierName) {
        if (phoneNumber == null) {
            return null;
        }

        String carrierEmail = carrierSettingsData.getEmailForCarrier(carrierName);
        if (carrierEmail == null) {
            return null;
        }

        // convert the phone to a string of numbers
        String Str1 = phoneNumber.replaceAll('\\(','');
        String Str2 = Str1.replaceAll('\\)','');
        String Str3 = Str2.replaceAll('-','');
        phoneNumber = Str3.replaceAll(' ','');

        carrierEmail = phoneNumber + '@' + carrierEmail;
        return carrierEmail;        
    }

    @TestVisible
    private static String lookupCarrierByPhone (String phoneNumber) {
        // TODO need to call a lookup service
        return null;
    }

    @TestVisible
    private static Map<Id,Contact> createClientContactMap(Set<Id> contactIds) {
        Map<Id,Contact> clientContactMap = new Map<Id,Contact>();

        List<Contact> contactList = [
            SELECT  
                Id,
                Email,
                MobilePhone,
                Mobile_Phone_Carrier__c,
                Phone
            FROM Contact
            WHERE Id IN :contactIds
        ];

        for (Contact cont : contactList) {
            clientContactMap.put(cont.Id, cont);
        }
        return clientContactMap;
    }
    
    @TestVisible
    private static Contact getContactForId (Id clientContactId) {
        List<Contact> clientContacts = [
            SELECT  
                Id,
                Email,
                MobilePhone,
                Mobile_Phone_Carrier__c,
                Phone
            FROM Contact
            WHERE Id = :clientContactId
        ];

        if (clientContacts.size() > 0) {
            return clientContacts[0];
        } else {
            return null;
        }
    }

    private static Task createTaskToComplete(Id taskId) {
        Task completedTask = new Task(
            Id = taskId,
            Status = 'Completed'
        );
        return completedTask;
    }

    public without sharing class ContactMessage {
        public Contact clientContact;
        public Messaging.SingleEmailMessage messageToSend;
    }

     public class EmailServiceException extends Exception {}
}