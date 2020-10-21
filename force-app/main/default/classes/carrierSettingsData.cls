public with sharing class carrierSettingsData {
    
    public static String getEmailForCarrier (String carrierName) {
        if (!Schema.sObjectType.Carrier_Setting__mdt.isAccessible()){
            throw new CarrierServicenException(
                System.Label.flsError);
               
             } else {  
        List<Carrier_Setting__mdt> settings = [
            SELECT 
                Email_Domain__c
            FROM Carrier_Setting__mdt
            WHERE Carrier_Name__c = :carrierName
        ];

        if (settings.size() > 0) {
            return settings[0].Email_Domain__c;
        } else {
            return null;
            }
        }
    }
    public class CarrierServicenException extends Exception {
    }
}