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
        url = 'https://api.auntberthaqa.com/v2/zipcodes/94105/programs?attributeTag=teens&serviceTag=counseling';
        authString = null;
        authHeader = token;
        auntBerthaResults.setServiceParams(api_key, username, pwd, url, method, authString, authHeader);
        string abQueryResult = auntBerthaResults.getResults('testing ab degree');        
        //2. search by zipcode
        // string query = EncodingUtil.urlEncode('food pantry', 'UTF-8');
        // method = 'GET';
        // url = 'https://api.auntberthaqa.com/v2/zipcodes/78041/programs?serviceTag=' + query + '&cursor=25&limit=50';
        // authString = null;
        // authHeader = token;
        // auntBerthaResults.setServiceParams(api_key, username, pwd, url, method, authString, authHeader);
        // string abQueryResult = auntBerthaResults.getResults('testing ab degree');        
        // system.debug(LoggingLevel.DEBUG, '---> ab query results by zipcode : ' + abQueryResult);
        
        List<Account> acctRecords = new List<Account>();
        List<Service__c> serviceRecords = new List<Service__c>();
        List<Open_Hours__c> openhourRecords = new List<Open_Hours__c>();  
        //this will be used for update
        Map<Id, Service__c> updateServiceRecords = new Map<Id, Service__c>();

        // //Insert data into service__c object after parsing
        AuntBerthaDataWrapper abDataWrapper = AuntBerthaDataWrapper.parse(abQueryResult);
        AuntBerthaDataWrapper.Programs[] programs = abDataWrapper.programs;
        for(AuntBerthaDataWrapper.Programs prog : programs) {
            // account name
            Account acctReference = new Account(External_ID__c = String.valueOf(prog.provider_numeric_id));            
            System.debug(LoggingLevel.DEBUG, '---> provider name ' + prog.provider_name);
            System.debug(LoggingLevel.DEBUG, '---> provider desc ' + prog.coverage_description);
            List<AuntBerthaDataWrapper.Offices> offices = prog.offices;
            for(AuntBerthaDataWrapper.Offices off : offices) {
                // service details
                System.debug(LoggingLevel.DEBUG, '---> service name ' + off.name);
                System.debug(LoggingLevel.DEBUG, '---> service notes ' + prog.description);
                System.debug(LoggingLevel.DEBUG, '---> addr ' + off.address1 + ',' + off.city + ',' + 
                                                        off.postal + ', phone - ' + off.phone_number + 
                                                        ', website - ' + prog.website_url) ;


                Service__c  serviceReference = new Service__c(External_ID__c = String.valueOf(off.office_numeric_id));
                Service__c newService = new Service__c(Name = off.name, 
                                                        Street__c = off.address1, 
                                                        City__c = off.city,
                                                        Phone__c = off.phone_number,
                                                        Zip_Code__c = off.postal,
                                                        External_ID__c = String.valueOf(prog.provider_numeric_id + '-' + off.office_numeric_id),
                                                        Description__c = prog.description,
                                                        Website__c = prog.website_url);
                //create account reference using account number                                                        
                newService.Account__r = acctReference;                
                List<Service__c> newServiceRecord = new List<Service__c>();
                newServiceRecord.add(newService);

                // open hours records
                AuntBerthaDataWrapper.Hours hours = off.hours;
                openhourRecords.addAll( auntBerthaGetOpenHours(hours, prog.provider_numeric_id + '-' + off.office_numeric_id));                
                Map<Id, Service__c> updServiceRecords = dedupServiceRecords(newServiceRecord);
                if(updServiceRecords.size() < 1){
                    serviceRecords.add(newService);
                }else {
                    updateServiceRecords.putAll(updServiceRecords);
                }

                
            }
            //create the account record.
            // account records dedup will be matched in external id field
            Account newAcct = new Account(name = prog.provider_name, 
                                    External_ID__c = String.valueOf(prog.provider_numeric_id),
                                    description = prog.coverage_description);
            acctRecords.add(newAcct);
        }
        System.debug(LoggingLevel.DEBUG, '---> open hours list size : ' + openhourRecords.size());
        System.debug(LoggingLevel.DEBUG, '---> updated updateServiceRecords size : ' + updateServiceRecords.size());
        // update strategy
        if(updateServiceRecords.size() > 0) {
            // delete all open hours child records and reinsert them
            deleteOpenHourRecords(updateServiceRecords);
            // update service records
            updateServiceProviderRecords(updateServiceRecords);
        }
        List<SObject> sobjList = new List<SObject>();
        sobjList.addAll(acctRecords);
        sobjList.addAll(serviceRecords);
        sobjList.addAll(openhourRecords);
        // insert service records
        insertSObjectRecords(sobjList);



        // // One degree call - start
        // ServiceResults oneDegreeResults = spFactoryResults.getServiceProviderResults('OnedegreeResults');
        // method = 'GET';
        // string odQuery = EncodingUtil.urlEncode('health clinic', 'UTF-8');
        // api_key = 'be9a3c70842d0138f4d20614a1d2fcd4';
        // url = 'https://data.1degree.org/v1/opportunities?api_key=' + api_key + '&query[text]=' + odQuery + '&query[lat]=37.7823&query[long]=-122.46';
        // authString = null;
        // authHeader = null;
        // oneDegreeResults.setServiceParams(api_key, username, pwd, url, method, authString, authHeader);        
        // string odQueryResult = oneDegreeResults.getResults('testing od degree');
        // system.debug(LoggingLevel.DEBUG, '---> od query results : ' + odQueryResult);
        // OneDegreeDataWrapper odObject = OneDegreeDataWrapper.parse(odQueryResult);
        // List<Account> acctRecords = new List<Account>();
        // List<Service__c> serviceRecords = new List<Service__c>();
        // List<Open_Hours__c> openhourRecords = new List<Open_Hours__c>();        
        // List<OneDegreeDataWrapper.Opportunities> opportunities = odObject.opportunities;
        // for(OneDegreeDataWrapper.Opportunities oppty : opportunities) {
        //     System.debug(LoggingLevel.DEBUG, '---> oppty id ' + oppty.id);
        //     OneDegreeDataWrapper.Organization org = oppty.organization;
        //     System.debug(LoggingLevel.DEBUG, '---> org id ' + org.id);
        //     //create the open hours first
            
        //     List<OneDegreeDataWrapper.Locations> locations = oppty.locations;
            
        //     for(OneDegreeDataWrapper.Locations loc : locations) {

        //         if(loc.schedule != null) {
        //             OneDegreeDataWrapper.Schedule sched = loc.schedule;
        //             Open_Hours__c oh = new Open_Hours__c();
        //             if((sched.monday_start != null && sched.monday_end != null) && 
        //                     (sched.monday_start.length() > 0 && sched.monday_end.length() > 0)) {
        //                 String[] strTimeSplitStart = sched.monday_start.split(':');
        //                 String[] strTimeSplitEnd = sched.monday_end.split(':');
    
        //                 oh.Day__c = 'Monday';
        //                 oh.Start_Time__c = Time.newInstance(Integer.valueOf(strTimeSplitStart[0]), 
        //                                                     Integer.valueOf(strTimeSplitStart[1]), 0, 0);
        //                 oh.End_Time__c = Time.newInstance(Integer.valueOf(strTimeSplitEnd[0]), 
        //                                                         Integer.valueOf(strTimeSplitEnd[1]), 0, 0);
        //             }
        //             //services reference with external id
        //             if(oh != null) {
        //                 Service__c  serviceReference = new Service__c(External_ID__c = String.valueOf(oppty.id+'-'+loc.id));
        //                 oh.Service__r = serviceReference;
        //                 openhourRecords.add(oh);    
        //             }
        //         }

        //         //get the phone $
        //         OneDegreeDataWrapper.phones[] phones;
        //         if(oppty.phones != null) {
        //             phones = oppty.phones;
        //             if(phones[0].digits != null){
        //                 System.debug(Logginglevel.DEBUG, '---> phone ' + phones[0].digits);
        //             }else{
        //                 phones[0].digits = '';
        //             }
        //         }

                
        //         //get the website URL
        //         OneDegreeDataWrapper.Properties website = oppty.properties;
        //         string location_url;
        //         if(website.action_signup_url != null) {
        //             location_url = website.action_signup_url;
        //         }else{
        //             location_url = '';
        //         }
        //         //System.debug(Logginglevel.DEBUG, '---> url ' + website[0].action_signup_url);
        //         //create services record           
        //         System.debug(logginglevel.DEBUG, '---> data ' + loc.Name + ',' + loc.address + ',' +
        //                                                         loc.city + ',' + loc.zip_code); 
        //         Service__c newService = new Service__c(Name = loc.Name, 
        //                                                 Street__c = loc.address, 
        //                                                 City__c = loc.city,
        //                                                 Phone__c = phones[0].digits,
        //                                                 Zip_Code__c = loc.zip_code,
        //                                                 External_ID__c = String.valueOf(oppty.id+'-'+loc.id),
        //                                                 Description__c = oppty.description,
        //                                                 Website__c = location_url);
        //         //create account reference using account number
        //         Account acctReference = new Account(External_ID__c = String.valueOf(oppty.id+'-'+org.id));
        //         newService.Account__r = acctReference;
        //         serviceRecords.add(newService);

        //     }//end of locations
        //     //create the account record.
        //     Account newAcct = new Account(name = org.name, 
        //                             External_ID__c = String.valueOf(oppty.id+'-'+org.id),
        //                             description = oppty.description);
        //     acctRecords.add(newAcct);
        //     //finally database.insert goes with the following sequence
        //     // account, servcies, login hours
        // }
        // List<SObject> sobjList = new List<SObject>();
        // sobjList.addAll(acctRecords);
        // sobjList.addAll(serviceRecords);
        // sobjList.addAll(openhourRecords);

        // System.debug(LoggingLevel.DEBUG, '---> Starting insert');

        // try{
        //     Database.SaveResult[] results = Database.insert(sobjList, false);
        //     //Database.SaveResult[] results2 = Database.insert(openhourRecords, false);

        //     // Iterate through each returned result
        //     for (Database.SaveResult sr : results) {
        //         if (sr.isSuccess()) {
        //             // Operation was successful, so get the ID of the record that was processed
        //             System.debug('Successfully inserted account. Account ID: ' + sr.getId());
        //         }
        //         else {
        //             // Operation failed, so get all errors                
        //             for(Database.Error err : sr.getErrors()) {
        //                 System.debug('The following error has occurred.');                    
        //                 System.debug(err.getStatusCode() + ': ' + err.getMessage());
        //                 System.debug('Account fields that affected this error: ' + err.getFields());
        //             }
        //         }
        //     }
        //     System.debug(LoggingLevel.DEBUG, '---> Completed insert');
        // }catch(exception ex) {
        //     System.debug(LoggingLevel.ERROR, '---> Error ' + ex.getMessage());
        // }
        // //one degree call - end


    }
    private void insertSObjectRecords(List<SObject> sobjList) {
        System.debug(LoggingLevel.DEBUG, '---> Starting insert');

        try{
            Database.SaveResult[] results = Database.insert(sobjList, false);
            // Iterate through each returned result
            for (Database.SaveResult sr : results) {
                if (sr.isSuccess()) {
                    // Operation was successful, so get the ID of the record that was processed
                    System.debug('Successfully inserted record. ID: ' + sr.getId());
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

    private void updateServiceProviderRecords(Map<Id, Service__c> updateServiceRecords) {
        List<Service__c> updatedSvcrecords = new List<Service__c>();
        for(Id svcId : updateServiceRecords.keySet()) {
            Service__c svc = updateServiceRecords.get(svcId);
            svc.Id = svcId;
            updatedSvcrecords.add(svc);
        }
        try{
            Database.SaveResult[] results = Database.update(updatedSvcrecords, false);
            // Iterate through each returned result
            for (Database.SaveResult sr : results) {
                if (sr.isSuccess()) {
                    // Operation was successful, so get the ID of the record that was processed
                    System.debug('Successfully updated record. ID: ' + sr.getId());
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

    private void deleteOpenHourRecords(Map<Id, Service__c> serviceRecords) {
        Set<Id> serviceIds = new Set<Id>();
        for(Id svcId : serviceRecords.keySet()) {
            serviceIds.add(svcId);
        }
        List<Open_Hours__c> openHourRecords = [SELECT Id from Open_Hours__c WHERE Service__c IN :serviceIds];
        if(openHourRecords.size() > 0) {
            delete openHourRecords;
        }
    }

    private Map<Id, Service__c> dedupServiceRecords(List<Service__c> serviceRecord) {
        // dedup matching for service records - start
        Map<Id, Service__c> updateServiceRecords = new Map<Id, Service__c>();
        //get the ids of the service records.
        DataCloud.FindDuplicatesResult[] dups;
        dups = DataCloud.FindDuplicates.findDuplicates(serviceRecord);
        //List<Service__c> dedupedServiceRecords = new List<Service__c>();
        //dedupedServiceRecords.addAll(serviceRecords);
        for (Integer i = (serviceRecord.size()-1); i>=0 ; i--) {
            Service__c svc = null;
            for (Datacloud.DuplicateResult dr : dups[i].getDuplicateResults()) {    
                if (dr.matchResults.size() > 0 && dr.getMatchResults()[0].matchRecords.size() > 0) {
                    svc = (Service__c) dr.getMatchResults()[0].getMatchRecords()[0].getRecord();
                    System.debug(LoggingLevel.DEBUG, i + ') ---> matched record ' + svc.Id + ', ' + svc.name);
                    System.debug(LoggingLevel.DEBUG, ' removing ' + serviceRecord[i].name + ' from list.' );
                    updateServiceRecords.put(svc.Id, serviceRecord[i]);
                }
            }        
        }
        // dedup matching for service records - end
        return updateServiceRecords;
    }

    private List<Open_Hours__c> auntBerthaGetOpenHours(AuntBerthaDataWrapper.Hours hours, string off_id) {
        List<Open_Hours__c> ohs = new List<Open_Hours__c>();
        String[] strTimeSplitStart;
        String[] strTimeSplitStartAM;
        String[] strTimeSplitEnd;
        String[] strTimeSplitEndPM; 
        System.debug(LoggingLevel.DEBUG, '---> off Id : ' + off_id);
        System.debug(LoggingLevel.DEBUG, '---> timezone : ' + hours.timezone_name);
        Service__c  serviceReference = new Service__c(External_ID__c = String.valueOf(off_id));        
        If(hours.monday) {
            Open_Hours__c oh1 = new Open_Hours__c();
            oh1.Day__c = 'Monday';            
            strTimeSplitStart = hours.monday_start.split(':');
            strTimeSplitStartAM = strTimeSplitStart[1].split(' ');
            strTimeSplitEnd = hours.monday_finish.split(':'); 
            strTimeSplitEndPM = strTimeSplitEnd[1].split(' ');
            oh1.Start_Time__c = Time.newInstance(Integer.valueOf(strTimeSplitStart[0]), 
                                                    Integer.valueOf(strTimeSplitStartAM[0]), 0, 0);
            oh1.End_Time__c = Time.newInstance(12 + Integer.valueOf(strTimeSplitEnd[0]), 
                                                        Integer.valueOf(strTimeSplitEndPM[0]), 0, 0);

            oh1.Service__r = serviceReference;
            ohs.add(oh1);
        }
        if(hours.tuesday) {
            Open_Hours__c oh2 = new Open_Hours__c();
            oh2.Day__c = 'Tuesday';            
            strTimeSplitStart = hours.tuesday_start.split(':');
            strTimeSplitStartAM = strTimeSplitStart[1].split(' ');            
            strTimeSplitEnd = hours.tuesday_finish.split(':');     
            strTimeSplitEndPM = strTimeSplitEnd[1].split(' ');                   
            oh2.Start_Time__c = Time.newInstance(Integer.valueOf(strTimeSplitStart[0]), 
                                                    Integer.valueOf(strTimeSplitStartAM[0]), 0, 0);
            oh2.End_Time__c = Time.newInstance(12 + Integer.valueOf(strTimeSplitEnd[0]), 
                                                        Integer.valueOf(strTimeSplitEndPM[0]), 0, 0);
            oh2.Service__r = serviceReference;                                                        
            ohs.add(oh2);
        }
        if(hours.wednesday) {
            Open_Hours__c oh3 = new Open_Hours__c();
            oh3.Day__c = 'Wednesday';            
            strTimeSplitStart = hours.wednesday_start.split(':');
            strTimeSplitStartAM = strTimeSplitStart[1].split(' ');            
            strTimeSplitEnd = hours.wednesday_finish.split(':');  
            strTimeSplitEndPM = strTimeSplitEnd[1].split(' ');                      
            oh3.Start_Time__c = Time.newInstance(Integer.valueOf(strTimeSplitStart[0]), 
                                                    Integer.valueOf(strTimeSplitStartAM[0]), 0, 0);
            oh3.End_Time__c = Time.newInstance(12 + Integer.valueOf(strTimeSplitEnd[0]), 
                                                        Integer.valueOf(strTimeSplitEndPM[0]), 0, 0);
            oh3.Service__r = serviceReference;                                                        
            ohs.add(oh3);
        }
        if(hours.thursday) {
            Open_Hours__c oh4 = new Open_Hours__c();
            oh4.Day__c = 'Thursday';            
            strTimeSplitStart = hours.thursday_start.split(':');
            strTimeSplitStartAM = strTimeSplitStart[1].split(' ');            
            strTimeSplitEnd = hours.thursday_finish.split(':'); 
            strTimeSplitEndPM = strTimeSplitEnd[1].split(' ');                       
            oh4.Start_Time__c = Time.newInstance(Integer.valueOf(strTimeSplitStart[0]), 
                                                    Integer.valueOf(strTimeSplitStartAM[0]), 0, 0);
            oh4.End_Time__c = Time.newInstance(12 + Integer.valueOf(strTimeSplitEnd[0]), 
                                                        Integer.valueOf(strTimeSplitEndPM[0]), 0, 0);
            oh4.Service__r = serviceReference;                                                        
            ohs.add(oh4);
        }
        if(hours.friday) {
            Open_Hours__c oh5 = new Open_Hours__c();
            oh5.Day__c = 'Friday';            
            strTimeSplitStart = hours.friday_start.split(':');
            strTimeSplitStartAM = strTimeSplitStart[1].split(' ');            
            strTimeSplitEnd = hours.friday_finish.split(':');    
            strTimeSplitEndPM = strTimeSplitEnd[1].split(' ');                    
            oh5.Start_Time__c = Time.newInstance(Integer.valueOf(strTimeSplitStart[0]), 
                                                    Integer.valueOf(strTimeSplitStartAM[0]), 0, 0);
            oh5.End_Time__c = Time.newInstance(12 + Integer.valueOf(strTimeSplitEnd[0]), 
                                                        Integer.valueOf(strTimeSplitEndPM[0]), 0, 0);
            oh5.Service__r = serviceReference;                                                                                                                
            ohs.add(oh5);
        }
        if(hours.saturday) {
            Open_Hours__c oh6 = new Open_Hours__c();
            oh6.Day__c = 'Saturday';            
            strTimeSplitStart = hours.saturday_start.split(':');
            strTimeSplitStartAM = strTimeSplitStart[1].split(' ');            
            strTimeSplitEnd = hours.saturday_finish.split(':');   
            strTimeSplitEndPM = strTimeSplitEnd[1].split(' ');                     
            oh6.Start_Time__c = Time.newInstance(Integer.valueOf(strTimeSplitStart[0]), 
                                                    Integer.valueOf(strTimeSplitStartAM[0]), 0, 0);
            oh6.End_Time__c = Time.newInstance(12 + Integer.valueOf(strTimeSplitEnd[0]), 
                                                        Integer.valueOf(strTimeSplitEndPM[0]), 0, 0);
            oh6.Service__r = serviceReference;   
            ohs.add(oh6);
        }
        if(hours.sunday) {
            Open_Hours__c oh7 = new Open_Hours__c();
            oh7.Day__c = 'Sunday';            
            strTimeSplitStart = hours.sunday_start.split(':');
            strTimeSplitStartAM = strTimeSplitStart[1].split(' ');            
            strTimeSplitEnd = hours.sunday_finish.split(':');  
            strTimeSplitEndPM = strTimeSplitEnd[1].split(' ');                      
            oh7.Start_Time__c = Time.newInstance(Integer.valueOf(strTimeSplitStart[0]), 
                                                    Integer.valueOf(strTimeSplitStartAM[0]), 0, 0);
            oh7.End_Time__c = Time.newInstance(12 + Integer.valueOf(strTimeSplitEnd[0]), 
                                                        Integer.valueOf(strTimeSplitEndPM[0]), 0, 0);
            oh7.Service__r = serviceReference;
            ohs.add(oh7);
        }

        return ohs;
    }
}
