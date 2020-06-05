public with sharing class carrierSettingsData {
    
    public static String getEmailForCarrier (String carrierName) {
        Carrier_Setting__mdt setting = [
            SELECT 
                Email_Domain__c
            FROM Carrier_Setting__mdt
            WHERE Carrier_Name__c = :carrierName
            LIMIT 1
        ];

        return setting.Email_Domain__c;
    }

}