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

        // method = 'GET';
        // url = 'https://api.auntberthaqa.com/v2/programs/4715932429582336';
        // authString = null;
        // authHeader = token;
        // auntBerthaResults.setServiceParams(api_key, username, pwd, url, method, authString, authHeader);
        // string abQueryResult = auntBerthaResults.getResults('testing ab degree');        
        // system.debug(LoggingLevel.DEBUG, '---> ab query results by program id : ' + abQueryResult);
        //2. search by zipcode
        method = 'GET';
        url = 'https://api.auntberthaqa.com/v2/zipcodes/78041/programs?serviceTag=food%20pantry&cursor=25&limit=50';
        authString = null;
        authHeader = token;
        auntBerthaResults.setServiceParams(api_key, username, pwd, url, method, authString, authHeader);
        string abQueryResult = auntBerthaResults.getResults('testing ab degree');        
        system.debug(LoggingLevel.DEBUG, '---> ab query results by zipcode : ' + abQueryResult);
        




        // One degree call
        ServiceResults oneDegreeResults = spFactoryResults.getServiceProviderResults('OnedegreeResults');
        method = 'GET';
        api_key = 'be9a3c70842d0138f4d20614a1d2fcd4';
        url = 'https://data.1degree.org/v1/opportunities?api_key=' + api_key + '&query[text]=health+clinic&query[lat]=37.7823&query[long]=-122.46';
        authString = null;
        authHeader = null;
        oneDegreeResults.setServiceParams(api_key, username, pwd, url, method, authString, authHeader);        
        string odQueryResult = oneDegreeResults.getResults('testing od degree');
        system.debug(LoggingLevel.DEBUG, '---> od query results : ' + odQueryResult);

    }
}
