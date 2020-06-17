public with sharing class ServiceProviderClient {
    public ServiceProviderClient() {

        ServiceProviderAbstractFactory spFactory = ServiceProviderFactoryCreator.getFactory('ServiceProvider');  
        ServiceProviderAbstractFactory spFactoryResults = ServiceProviderFactoryCreator.getFactory('ServiceProviderResults');          
        ServiceProvider spOneDegree = spFactory.getServiceProvider('OneDegree');
        ServiceProvider spAuntBertha = spFactory.getServiceProvider('AuntBertha');
        System.debug(LoggingLevel.DEBUG, '---> service provider one degree : ' + spOneDegree.getServiceProviderName());
        System.debug(LoggingLevel.DEBUG, '---> service provider aunt bertha : ' + spAuntBertha.getServiceProviderName());
        String api_key = '1dda1811987577b44bbcbcde186a9c14';
        String username = 'aguterman@salesforce.com';
        String pwd = '1mpactL@bs2020';
        String url = 'https://api.auntberthaqa.com/v3/authenticate';
        String method = 'POST';

        AuthParams ap = new AuthParams();
        ap.username = 'aguterman@salesforce.com';
        ap.password = '1mpactL@bs2020';
        ap.api_key = '1dda1811987577b44bbcbcde186a9c14';
        string authString = JSON.serializePretty(ap);        
        string authHeader = null;

        // ServiceResults oneDegreeResults = spFactoryResults.getServiceProviderResults('OneDegreeResults');
        // oneDegreeResults.setServiceParams(api_key, username, pwd, url);
        // String odResult = oneDegreeResults.getResults('testing one degree');
        // System.debug(LoggingLevel.DEBUG, '---> one degree ' + odResult);
        ServiceResults auntBerthaResults = spFactoryResults.getServiceProviderResults('AuntBerthaResults');
        auntBerthaResults.setServiceParams(api_key, username, pwd, url, method, authString, authHeader);
        String abResult = auntBerthaResults.getResults('testing ab degree');        
        System.debug(LoggingLevel.DEBUG, '---> ab  ' + abResult);
        Map<String, Object> m = (Map<String, Object>) JSON.deserializeUntyped(abResult);
            //System.debug(LoggingLevel.DEBUG, '----> token :' + a[0].get('token'));
        JSONParser parser = JSON.createParser(abResult);
        string token;
        while (parser.nextToken() != null) {
            if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) &&
                (parser.getText() == 'token')) {
                parser.nextToken();
                token =  parser.getText();
                System.debug(LoggingLevel.DEBUG, '----> token :' + token);
            }

        }
        System.debug(LoggingLevel.DEBUG, '----> status :' + m.get('success'));        
        // aunt bertha call
        //1. Search by a program id

        method = 'GET';
        url = 'https://api.auntberthaqa.com/v2/programs/4715932429582336';
        authString = null;
        authHeader = token;
        auntBerthaResults.setServiceParams(api_key, username, pwd, url, method, authString, authHeader);
        string abQueryResult = auntBerthaResults.getResults('testing ab degree');        
        system.debug(LoggingLevel.DEBUG, '---> ab query results by program id : ' + abQueryResult);
        //2. search by zipcode
        // string query = EncodingUtil.urlEncode('food pantry', 'UTF-8');
        // method = 'GET';
        // url = 'https://api.auntberthaqa.com/v2/zipcodes/78041/programs?serviceTag=' + query + '&cursor=25&limit=50';
        // authString = null;
        // authHeader = token;
        // auntBerthaResults.setServiceParams(api_key, username, pwd, url, method, authString, authHeader);
        // string abQueryResult = auntBerthaResults.getResults('testing ab degree');        
        // system.debug(LoggingLevel.DEBUG, '---> ab query results by zipcode : ' + abQueryResult);
        
        // //Insert data into service__c object after parsing
        // AuntBerthaDataWrapper abDataWrapper = AuntBerthaDataWrapper.parse(abQueryResult);
        // System.debug(LoggingLevel.DEBUG, '---> abDataWrapper.provider_name ' + abDataWrapper.provider_name );
        // List<Service__c> services = new List<Service__c>();
        // List<AuntBerthaDataWrapper.Offices> programOffices = abDataWrapper.offices;
        // for(AuntBerthaDataWrapper.Offices off : programOffices) {
        //     System.debug(LoggingLevel.DEBUG, '---> name ' + off.name);
        //     Service__c svcObject = new Service__c();
        //     svcObject.name = off.name;
        //     svcObject.Phone__c = off.phone_number;
        //     svcObject.Street__c = off.address1;
        //     svcObject.city__c = off.city;
        //     svcObject.Zip_Code__c = off.postal;
        //     svcObject.Description__c = off.notes;
        //     services.add(svcObject);
        // }
        // if(services.size() > 0) {
        //     try{
        //         insert services;
        //     }catch(Exception ex){
        //         System.debug(LoggingLevel.DEBUG, 'Error : ' + ex.getMessage());
        //     }
            
        // }



        // One degree call
        ServiceResults oneDegreeResults = spFactoryResults.getServiceProviderResults('OnedegreeResults');
        method = 'GET';
        string odQuery = EncodingUtil.urlEncode('health clinic', 'UTF-8');
        api_key = 'be9a3c70842d0138f4d20614a1d2fcd4';
        url = 'https://data.1degree.org/v1/opportunities?api_key=' + api_key + '&query[text]=' + odQuery + '&query[lat]=37.7823&query[long]=-122.46';
        authString = null;
        authHeader = null;
        oneDegreeResults.setServiceParams(api_key, username, pwd, url, method, authString, authHeader);        
        string odQueryResult = oneDegreeResults.getResults('testing od degree');
        system.debug(LoggingLevel.DEBUG, '---> od query results : ' + odQueryResult);
        OneDegreeDataWrapper odObject = OneDegreeDataWrapper.parse(odQueryResult);
        List<Account> acctRecords = new List<Account>();
        List<Service__c> serviceRecords = new List<Service__c>();
        List<Open_Hours__c> openhourRecords = new List<Open_Hours__c>();        
        List<OneDegreeDataWrapper.Opportunities> opportunities = odObject.opportunities;
        for(OneDegreeDataWrapper.Opportunities oppty : opportunities) {
            System.debug(LoggingLevel.DEBUG, '---> oppty id ' + oppty.id);
            OneDegreeDataWrapper.Organization org = oppty.organization;
            System.debug(LoggingLevel.DEBUG, '---> org id ' + org.id);
            //create the open hours first
            
            List<OneDegreeDataWrapper.Locations> locations = oppty.locations;
            
            for(OneDegreeDataWrapper.Locations loc : locations) {

                if(loc.schedule != null) {
                    OneDegreeDataWrapper.Schedule sched = loc.schedule;
                    Open_Hours__c oh = new Open_Hours__c();
                    if((sched.monday_start != null && sched.monday_end != null) && 
                            (sched.monday_start.length() > 0 && sched.monday_end.length() > 0)) {
                        String[] strTimeSplitStart = sched.monday_start.split(':');
                        String[] strTimeSplitEnd = sched.monday_end.split(':');
    
                        oh.Day__c = 'Monday';
                        oh.Start_Time__c = Time.newInstance(Integer.valueOf(strTimeSplitStart[0]), 
                                                            Integer.valueOf(strTimeSplitStart[1]), 0, 0);
                        oh.End_Time__c = Time.newInstance(Integer.valueOf(strTimeSplitEnd[0]), 
                                                                Integer.valueOf(strTimeSplitEnd[1]), 0, 0);
                    }
                    //services reference with external id
                    if(oh != null) {
                        Service__c  serviceReference = new Service__c(External_ID__c = String.valueOf(oppty.id+'-'+loc.id));
                        oh.Service__r = serviceReference;
                        openhourRecords.add(oh);    
                    }
                }

                //get the phone $
                OneDegreeDataWrapper.phones[] phones;
                if(oppty.phones != null) {
                    phones = oppty.phones;
                    if(phones[0].digits != null){
                        System.debug(Logginglevel.DEBUG, '---> phone ' + phones[0].digits);
                    }else{
                        phones[0].digits = '';
                    }
                }

                
                //get the website URL
                OneDegreeDataWrapper.Properties website = oppty.properties;
                string location_url;
                if(website.action_signup_url != null) {
                    location_url = website.action_signup_url;
                }else{
                    location_url = '';
                }
                //System.debug(Logginglevel.DEBUG, '---> url ' + website[0].action_signup_url);
                //create services record           
                System.debug(logginglevel.DEBUG, '---> data ' + loc.Name + ',' + loc.address + ',' +
                                                                loc.city + ',' + loc.zip_code); 
                Service__c newService = new Service__c(Name = loc.Name, 
                                                        Street__c = loc.address, 
                                                        City__c = loc.city,
                                                        Phone__c = phones[0].digits,
                                                        Zip_Code__c = loc.zip_code,
                                                        External_ID__c = String.valueOf(oppty.id+'-'+loc.id),
                                                        Description__c = oppty.description,
                                                        Website__c = location_url);
                //create account reference using account number
                Account acctReference = new Account(External_ID__c = String.valueOf(oppty.id+'-'+org.id));
                newService.Account__r = acctReference;
                serviceRecords.add(newService);

            }//end of locations
            //create the account record.
            Account newAcct = new Account(name = org.name, 
                                    External_ID__c = String.valueOf(oppty.id+'-'+org.id),
                                    description = oppty.description);
            acctRecords.add(newAcct);
            //finally database.insert goes with the following sequence
            // account, servcies, login hours
        }
        List<SObject> sobjList = new List<SObject>();
        sobjList.addAll(acctRecords);
        sobjList.addAll(serviceRecords);
        sobjList.addAll(openhourRecords);

        System.debug(LoggingLevel.DEBUG, '---> Starting insert');

        try{
            Database.SaveResult[] results = Database.insert(sobjList, false);
            //Database.SaveResult[] results2 = Database.insert(openhourRecords, false);

            // Iterate through each returned result
            for (Database.SaveResult sr : results) {
                if (sr.isSuccess()) {
                    // Operation was successful, so get the ID of the record that was processed
                    System.debug('Successfully inserted account. Account ID: ' + sr.getId());
                }
                else {
                    // Operation failed, so get all errors                
                    for(Database.Error err : sr.getErrors()) {
                        System.debug('The following error has occurred.');                    
                        System.debug(err.getStatusCode() + ': ' + err.getMessage());
                        System.debug('Account fields that affected this error: ' + err.getFields());
                    }
                }
            }
            System.debug(LoggingLevel.DEBUG, '---> Completed insert');
        }catch(exception ex) {
            System.debug(LoggingLevel.ERROR, '---> Error ' + ex.getMessage());
        }


    }
}
