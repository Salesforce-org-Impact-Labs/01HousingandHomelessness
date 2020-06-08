public with sharing class EmailService {

    public static void sendMessageToContact (List<ContactMessage> contactMessages) {
        List<Contact> contactsToUpdate = new List<Contact>();

        // create a map of contact records from the incoming list
        Map<Id,Contact> clientContactMap = createClientContactMap(contactMessages);
        
        for (ContactMessage contactMsg : contactMessages) {
            // handle each contact/message, one record at a time
            String clientContactId = contactMsg.clientContactId;
            String messageToSend = contactMsg.messageToSend;
        
            // flag to indicate if we need to update the contact record
            Boolean contactNeedsUpdate = false; 

            if (String.isEmpty(messageToSend)) {
                throw new EmailServiceException('The message to send is empty'); 
            } 
            if (clientContactId == null) {
                throw new EmailServiceException('The client contact ID is empty'); 
            }
                
            // get the contact record from the map we created
            Contact clientContact = clientContactMap.get(clientContactId);
            if (clientContact != null) {

                if (clientContact.Phone != null) {
                    
                    if (clientContact.Mobile_Phone_Carrier__c == null) {
                        // if no carrier, look it up, add it to contact record
                        clientContact.Mobile_Phone_Carrier__c = lookupCarrierByPhone(clientContact.Phone);
                        
                        if (clientContact.Mobile_Phone_Carrier__c == null) {
                            // if still no carrier
                            throw new EmailServiceException('The carrier cannot be found for Contact with Id: '+clientContactId);
                        } else {
                            contactNeedsUpdate = true;
                        }
                    }

                    // create email
                    Messaging.SingleEmailMessage emailToSend = 
                        createEmailForCarrier (messageToSend, clientContact.Phone, clientContact.Mobile_Phone_Carrier__c);

                    // send email
                    if (emailToSend == null) {
                        // failed to create email
                        throw new EmailServiceException('Failed to create outgoing email to carrier'); 
                    }
                    Boolean emailWasSent = sendEmailToCarrier(emailToSend);

                    // get response???

                    // if email bounced, call carrier lookup
                    if (!emailWasSent) {
                        String carrier = lookupCarrierByPhone (clientContact.Phone);
                        if (carrier == null) {
                            throw new EmailServiceException('Unable to locate carrier for Contact with Id: '+clientContactId);
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
                            emailWasSent = sendEmailToCarrier(emailToSend);
                            if (!emailWasSent) {
                                throw new EmailServiceException('Failed to successfully send outgoing email to carrier on retry');
                            } 
                        }
                    }

                    // if contacts need to be updated, then add it to the list for update
                    if (contactNeedsUpdate) {
                            contactsToUpdate.add(clientContact);
                    }

                    // all is well

                } else {
                        // contact found but phone is missing
                        throw new EmailServiceException('Failed to find Phone on the Contact record for Contact Id: '+clientContactId); 
                }
    
            } else {
                // contact wasn't found
                throw new EmailServiceException('Failed to find Contact record for Contact Id: '+clientContactId);
            } 

        }
        // update any contacts that have been changed (eg the mobile carrier has been changed)
        if (!contactsToUpdate.isEmpty()) {
            update contactsToUpdate;
        }
    }

    @TestVisible
    private static Boolean sendEmailToCarrier(Messaging.SingleEmailMessage emailToSend) {
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
    private static Messaging.SingleEmailMessage createEmailForCarrier (String messageToSend, String phoneNumber, String carrierName) {

        Messaging.SingleEmailMessage emailToSend = new Messaging.SingleEmailMessage();

        String carrierEmail = convertPhoneToCarrierEmail (phoneNumber, carrierName);
        if (carrierEmail == null) {
            return null;
        }

        emailToSend.setToAddresses(new List<String>{carrierEmail});
        emailToSend.setPlainTextBody(messageToSend);

        return emailToSend;
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
    private static Map<Id,Contact> createClientContactMap(List<ContactMessage> contactMessages) {
        Map<Id,Contact> clientContactMap = new Map<Id,Contact>();

        // create set of contact ids
        Set<Id> contactIds = new Set<Id>();
        for (ContactMessage contactMsg : contactMessages) {
            contactIds.add(contactMsg.clientContactId);
        }

        List<Contact> contactList = [
            SELECT  
                Id,
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

    public without sharing class ContactMessage {
        public Id clientContactId;
        public String messageToSend;
    }

     public class EmailServiceException extends Exception {}
}