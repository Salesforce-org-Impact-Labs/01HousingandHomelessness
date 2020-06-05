public with sharing class EmailService {

    public static Boolean sendMessageToContact (String messageToSend, Id clientContactId) {
        
        if (!String.isEmpty(messageToSend)) {
            
            // get the contact record
            List<Contact> clientContacts = [
                SELECT  
                    Id
                FROM Contact
                WHERE Id = :clientContactId
            ];

            if (clientContacts.size() > 0) {

            } else {
                // contact wasn't found
                return false;
            }

            // if no carrier, look it up, add it to contact record

            // create email

            // send email

            // get response???

            // if email bounced, call carrier lookup

            // if carrier is different, add it to contact record, resend email

            // do something with the response

            // all is well
            return true; 

        } else {
            // no message provided
            return false;
        }
    }
}