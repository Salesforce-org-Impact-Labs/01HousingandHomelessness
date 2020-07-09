global class AuntBerthaServiceQueueable implements Queueable {
    Set<String> querySet = new Set<String>();
    Map<String, String> authSet = new Map<String, String>();

    public AuntBerthaServiceQueueable() {
        Aunt_Bertha_Auth_Setting__mdt abSetting = [SELECT MasterLabel, DeveloperName, 
                                                        API_Key__c ,Username__c, Password__c, Hostname__c, Hostname_Program__c
                                                    FROM Aunt_Bertha_Auth_Setting__mdt LIMIT 1];


        authSet.put('API_Key__c', abSetting.API_Key__c);
        authSet.put('Username__c', abSetting.Username__c);
        authSet.put('Password__c', abSetting.Password__c);
        authSet.put('Hostname__c', abSetting.Hostname__c + '/authenticate');
        authSet.put('Hostname_Program__c', abSetting.Hostname_Program__c);
        authSet.put('MethodType', 'POST');

    }
    public void execute(QueueableContext context) {
        //get all attribute tags
        Aunt_Bertha_Attribute_Setting__mdt[] attributeTags = [SELECT Attribute_Tag__c from Aunt_Bertha_Attribute_Setting__mdt];        
        // awesome code here
        List<Service_Provider_ZipCode_Search__mdt> serviceZipCodes = [SELECT Zipcode__c from Service_Provider_ZipCode_Search__mdt];

        for(Service_Provider_ZipCode_Search__mdt serviceZipCode : serviceZipCodes) {
            System.debug(LoggingLevel.DEBUG, '---> zip code ' + serviceZipCode.Zipcode__c);
            for (Aunt_Bertha_Attribute_Setting__mdt attributeTag : attributeTags) {
                System.debug(LoggingLevel.DEBUG, '---> attribute tag ' + attributeTag.Attribute_Tag__c);
                String query = '/zipcodes/'+ serviceZipCode.Zipcode__c + '/programs?attributeTag=' + attributeTag.Attribute_Tag__c; 
                querySet.add(query);
            }
        }
        
        System.debug(LoggingLevel.DEBUG, '---> auth details ' + authSet.size());
        List<String> authParams = new List<String>();
        List<String> queryParams = new List<String>();
        //get query details
        System.debug(LoggingLevel.DEBUG, '---> total # of query produced ' + querySet.size());
        for(String s : querySet) {
            System.debug(LoggingLevel.DEBUG, '---> query url ' + s);
            queryParams.add(s);

        }
        if(!System.isFuture()) {
            ServiceProviderClient.processAuthBerthaService(authSet, queryParams);
        }          
    }    
}
