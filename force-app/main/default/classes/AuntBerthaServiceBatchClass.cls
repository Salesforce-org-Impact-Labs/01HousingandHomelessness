global class AuntBerthaServiceBatchClass implements 
        Database.Batchable<sObject>, Database.Stateful, Database.AllowsCallouts {
    Set<String> querySet = new Set<String>();
    Map<String, String> authSet = new Map<String, String>();
    public AuntBerthaServiceBatchClass() {
        //get auth details in the constructor
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
    global Database.QueryLocator start(Database.BatchableContext bc) {
        // collect the batches of records or objects to be passed to execute
        return Database.getQueryLocator('SELECT Zipcode__c from Service_Provider_ZipCode_Search__mdt');
    }
    global void execute(Database.BatchableContext bc, List<Service_Provider_ZipCode_Search__mdt> records){
        
        //get all attribute tags
        Aunt_Bertha_Attribute_Setting__mdt[] attributeTags = [SELECT Attribute_Tag__c from Aunt_Bertha_Attribute_Setting__mdt];



        // process each batch of records
        List<Service_Provider_ZipCode_Search__mdt> serviceZipCodes = records;
        for(Service_Provider_ZipCode_Search__mdt serviceZipCode : serviceZipCodes) {
            System.debug(LoggingLevel.DEBUG, '---> zip code ' + serviceZipCode.Zipcode__c);
            for (Aunt_Bertha_Attribute_Setting__mdt attributeTag : attributeTags) {
                System.debug(LoggingLevel.DEBUG, '---> attribute tag ' + attributeTag.Attribute_Tag__c);
                String query = '/zipcodes/'+ serviceZipCode.Zipcode__c + '/programs?attributeTag=' + attributeTag.Attribute_Tag__c; 
                querySet.add(query);
            }

        }


      
    }    
    global void finish(Database.BatchableContext bc){
        // execute any post-processing operations
        System.debug(LoggingLevel.DEBUG, '---> Start of finish');
        //get auth details
        System.debug(LoggingLevel.DEBUG, '---> auth details ' + authSet.size());
        List<String> queryParams = new List<String>();
        //get query details
        System.debug(LoggingLevel.DEBUG, '---> total # of query produced ' + querySet.size());
        for(String s : querySet) {
            System.debug(LoggingLevel.DEBUG, '---> query url ' + s);
            queryParams.add(s);

        }
        ServiceProviderClient.processAuthBerthaServiceFromBatch(authSet, queryParams);
        
        AsyncApexJob batchJobDetails = [SELECT Id, Status, NumberOfErrors, 
            JobItemsProcessed,
            TotalJobItems, CreatedBy.Email
            FROM AsyncApexJob
            WHERE Id = :bc.getJobId()];
        System.debug(LoggingLevel.DEBUG, '---> job details ' + batchJobDetails);                    
        System.debug(LoggingLevel.DEBUG, '---> End of finish');
    }     
}
