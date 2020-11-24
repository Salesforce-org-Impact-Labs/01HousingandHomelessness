@IsTest
public class Test_ServiceProvider {

    @testSetup static void setup() {
        // Create test accounts
        List<Account> testAccts = new List<Account>();
        
        Account testAcct1 = new Account();
        testAcct1.Name = 'Test Account 1';
        testAcct1.External_ID__c = 'TEST-1';
        testAccts.add(testAcct1);
        
        Account testAcct2 = new Account();
        testAcct2.Name = 'Test Account 2';
        testAcct2.External_ID__c = 'TEST-2';        
        testAccts.add(testAcct2);
        
        insert testAccts;
        // Create test services
        List<Service__c> testServices = new List<Service__c>();
        
        Service__c testService1 = new Service__c();
        testService1.Name = 'Test Service 1';
        testService1.External_ID__c = 'TEST-1-SVC-1';
        testService1.Account__c = testAccts[0].Id;
        testServices.add(testService1);
        
        Service__c testService2 = new Service__c();
        testService2.Name = 'Test Service 2';
        testService2.Account__c = testAccts[1].Id;
        testService2.External_ID__c = 'TEST-2-SVC-2';
        testServices.add(testService2);

        insert testServices;
        // Create open hours
        List<Open_Hours__c> testOpenHours = new List<Open_Hours__c>();
        
        Open_Hours__c openHours1 = new Open_Hours__c();
        openHours1.Day__c = 'Monday';
        openHours1.Service__c = testServices[0].Id;
        openHours1.Start_Time__c = Time.newInstance(Integer.valueOf('8'), Integer.valueOf('00'), 0, 0);
        openHours1.End_Time__c = Time.newInstance(Integer.valueOf('17'), Integer.valueOf('00'), 0, 0);
        testOpenHours.add(openHours1);
        
        Open_Hours__c openHours2 = new Open_Hours__c();
        openHours2.Day__c = 'Monday';
        openHours2.Service__c = testServices[1].Id;
        openHours2.Start_Time__c = Time.newInstance(Integer.valueOf('8'), Integer.valueOf('00'), 0, 0);
        openHours2.End_Time__c = Time.newInstance(Integer.valueOf('17'), Integer.valueOf('00'), 0, 0);        
        testOpenHours.add(openHours2);

        insert testOpenHours;
    }

    @IsTest
    static void testAuntBerthaCallout() {
        //Initiate the factory
        ServiceProviderAbstractFactory spFactory = ServiceProviderFactoryCreator.getFactory('ServiceProvider');  
        ServiceProviderAbstractFactory spFactoryResults = ServiceProviderFactoryCreator.getFactory('ServiceProviderResults');    
        //Check you are getting null back
        ServiceProviderAbstractFactory spFactoryNull = ServiceProviderFactoryCreator.getFactory('');
        System.assertEquals(null, spFactoryNull);        
        //check for AuntBertha
        ServiceProvider spAuntBertha = spFactory.getServiceProvider('AuntBertha');
        System.assertEquals('AuntBertha', spAuntBertha.getServiceProviderName(), 'Service name should be Aunt Bertha');

        //service that do not exist
        ServiceProvider spfooService = spFactory.getServiceProvider('fooService');
        System.assertEquals(null, spFactory.getServiceProvider('fooService'), 'Service should not exist.');
        System.assertEquals(null, spFactory.getServiceProvider(null), 'Service should return null.');
        //Service provider factory getServiceProviderResults should; return null
        ServiceResults spNullFactoryResults = spFactory.getServiceProviderResults('some query');
        System.assertEquals(null, spNullFactoryResults, 'Service results should return null.');


        AuthParams ap = new AuthParams();
        ap.api_key = 'api_key';
        ap.password = 'user name';
        ap.username = 'password';

        //checking service results factory
        String api_key = 'api_key';
        String username = 'user name';
        String pwd = 'password';
        String url = 'https://api.serviceprovider.com/authenticate';
        String method = 'GET';
        String body = JSON.serializePretty(ap);
        String authHeader = 'token';
        //check for null, when passed null
        System.assertEquals(null, spFactoryResults.getServiceProviderResults(null), 'Service results should return null.');
        //if it does not match results name it will return null
        System.assertEquals(null, spFactoryResults.getServiceProviderResults('fooResults'), 'Service results should return null.');
        //service provider should return null
        System.assertEquals(null, spFactoryResults.getServiceProvider('AuntBertha'), 'Service provider should return null.');
        //aunt bertha results
        ServiceResults auntBerthaResults = spFactoryResults.getServiceProviderResults('AuntBerthaResults');
        auntBerthaResults.setServiceParams(api_key, username, pwd, url, method, body, authHeader);   
        
        Test.startTest();
            // Set mock callout class
            //Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
            Test.setMock(HttpCalloutMock.class, new Test_AuntBerthaMockService());
            // This causes a fake response to be sent
            String res = auntBerthaResults.getResults('testing mock service');
            system.debug(LoggingLevel.DEBUG, '---> res' + res);
            ServiceProviderClient sp = new ServiceProviderClient();
            
            // assert accounts
            List<Account> accts = [SELECT Id, Name, External_Id__c from Account ORDER BY External_Id__c];
            System.assertEquals(3, accts.size(), 'Total number of accounts will be 3');
            Integer counter = 0;
            for(Account acct : accts) {
                if(counter == 0) {
                    // asert name and external id
                    System.assertEquals('Donaldina Cameron House', acct.name, 'Account name should be Donaldina Cameron House');
                    System.assertEquals('6279973675466752', acct.external_id__c, 'External Account should be 6279973675466752');
                }else if(counter == 1) {
                    System.assertEquals('Test Account 1', acct.name, 'Account name should be Test Account 1');
                    System.assertEquals('TEST-1', acct.external_id__c, 'External Account should be TEST-1');
                }else if(counter == 2) {
                    System.assertEquals('Test Account 2', acct.name, 'Account name should be Test Account 2');
                    System.assertEquals('TEST-2', acct.external_id__c, 'External Account should be TEST-2');
                }
                counter++;
            }
            

            //assert services
            // reset counter to 0
            counter = 0;
            List<Service__c> services = [SELECT Id, Name, External_Id__c from Service__c ORDER BY External_Id__c];
            //assert number of services record
            System.assertEquals(3, services.size(), 'Total # of seervices records should be 3');
            for(Service__c service : services) {
                System.debug(LoggingLevel.DEBUG, '---> svc name ' + service.name);
                System.debug(LoggingLevel.DEBUG, '---> svc external id  ' + service.external_id__c);
                if(counter == 0) {
                    //assert external id
                    System.assertEquals('6279973675466752-6001564835643392', service.external_id__c, 'External id should be 6279973675466752-6001564835643392');
                    // assert name
                    System.assertEquals('Donaldina Cameron House', service.name, 'Name should be Donaldina Cameron House');
                }else if(counter == 1) {
                    //assert external id
                    System.assertEquals('TEST-1-SVC-1', service.external_id__c, 'External id should be TEST-1-SVC-1');
                    // assert name
                    System.assertEquals('Test Service 1', service.name, 'Name should be Test Service 1');
                }else if(counter == 2) {
                    //assert external id
                    System.assertEquals('TEST-2-SVC-2', service.external_id__c, 'External id should be TEST-2-SVC-2');
                    // assert name
                    System.assertEquals('Test Service 2', service.name, 'Name should be Test Service 2');
                }
                
                counter++;
            }
            //assert open hours
            // reset counter to 0
            counter = 0;
            Integer counter1 = 0;
            Integer counter2 = 0;
            Integer counter3 = 0;            
            List<open_hours__c> openhours = [SELECT id, name, day__c, service__c, service__r.name from open_hours__c ORDER BY service__r.name, day__c];
            System.debug(Logginglevel.DEBUG, '---> # of open hour records ' + openhours.size());
            
            // sun - sat 7 days for Donaldina Cameron House and Test Service 1
            // Monday record for Test Service 2
            System.assertEquals(15, openhours.size(), 'There should be 15 open hours records');
            for(open_hours__c openhour : openhours) {
                System.debug(LoggingLevel.DEBUG, '---> oh day__c ' + openhour.day__c);
                System.debug(LoggingLevel.DEBUG, '---> oh service  ' + openhour.service__c);
                System.debug(LoggingLevel.DEBUG, '---> oh service name ' + openhour.service__r.name);                
                if(openhour.service__r.name.equals('Donaldina Cameron House')) {
                    counter1++;
                }else if(openhour.service__r.name.equals('Test Service 1')) {
                    counter2++;
                }else if(openhour.service__r.name.equals('Test Service 2')) {
                    counter3++;
                }
                counter++;
            }
            System.assertEquals(7, counter1, 'There should be  7 open hours records for Donaldina Cameron House');
            System.assertEquals(7, counter2, 'There should be  7 open hours records for Test Service 1');
            System.assertEquals(1, counter3, 'There should be  1 open hours records for Test Service 2');
        Test.stopTest();

    }
    @IsTest
    static void testUpdateStrategy() {


    }
    @IsTest
    static void testOneDegreeCallout() {
        ServiceProviderAbstractFactory spFactory = ServiceProviderFactoryCreator.getFactory('ServiceProvider');  
        ServiceProviderAbstractFactory spFactoryResults = ServiceProviderFactoryCreator.getFactory('ServiceProviderResults');    
        //Check you are getting null back
        ServiceProviderAbstractFactory spFactoryNull = ServiceProviderFactoryCreator.getFactory('');
        System.assertEquals(null, spFactoryNull);

        // check for OneDegree
        ServiceProvider spOneDegree = spFactory.getServiceProvider('OneDegree');
        System.assertEquals('OneDegree', spOneDegree.getServiceProviderName(), 'Service name should be One Degree');        
        //service that do not exist
        ServiceProvider spfooService = spFactory.getServiceProvider('fooService');
        System.assertEquals(null, spFactory.getServiceProvider('fooService'), 'Service should not exist.');
        System.assertEquals(null, spFactory.getServiceProvider(null), 'Service should return null.');
        //Service provider factory getServiceProviderResults should; return null
        ServiceResults spNullFactoryResults = spFactory.getServiceProviderResults('some query');
        System.assertEquals(null, spNullFactoryResults, 'Service results should return null.');

        //checking service results factory
        String api_key = 'api_key';
        String username = '';
        String pwd = '';
        String url = 'https://api.serviceprovider.com/authenticate';
        String method = 'GET';
        String body = 'req body';
        String authHeader = 'token';
        //check for null, when passed null
        System.assertEquals(null, spFactoryResults.getServiceProviderResults(null), 'Service results should return null.');
        //if it does not match results name it will return null
        System.assertEquals(null, spFactoryResults.getServiceProviderResults('fooResults'), 'Service results should return null.');
        //service provider should return null
        System.assertEquals(null, spFactoryResults.getServiceProvider('AuntBertha'), 'Service provider should return null.');

        //one degree results
        ServiceResults onedegreeResults = spFactoryResults.getServiceProviderResults('OneDegreeResults');
        onedegreeResults.setServiceParams(api_key, username, pwd, url, method, body, authHeader);    

        // Set mock callout class
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        // This causes a fake response to be sent
        String res = onedegreeResults.getResults('testing mock service');
        system.debug(LoggingLevel.DEBUG, '---> res' + res);                                            
    }    

}
