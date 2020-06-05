public with sharing class EmailService {

    public static void sendMessageToContact (String messageToSend, Id clientContactId) {
        // flag to indicate if we need to update the contact record
        Boolean contactNeedsUpdate = false; 

        if (String.isEmpty(messageToSend)) {
            throw new EmailServiceException('The message to send is empty'); 
         } 
        if (clientContactId == null) {
            throw new EmailServiceException('The client contact ID is empty'); 
        }
            
        // get the contact record
        Contact clientContact = getContactForId(clientContactId);
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

                // if contact needs to be updated, then update it
                if (contactNeedsUpdate) {
                        update clientContact;
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

    public class EmailServiceException extends Exception {}
}