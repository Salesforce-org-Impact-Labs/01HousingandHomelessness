public with sharing class getRecommendationsServiceQuery {

  // list of services with any hard filters
  // hard filters are currently Age
  public static list<Service__c> primaryQuery(Client_Profile__c client, String filterList) {
    if(Schema.Client_Profile__c.SObjectType == Id.valueOf(client.id).getSobjectType()) {
      List<String> filters = new List<String>();
    
        filters.addALL(filterList.split(','));
        String filterValue = '(\'' + String.join(filters, '\',\'') + '\')';
        
        String queryStr= 'SELECT id from Service__c ';
        if(client.Date_Of_Birth__c!=null){
            decimal age = calculateAge(client.Date_Of_Birth__c);
            queryStr+= ' where (Minimum_Age__c = null OR Minimum_Age__c < :age) AND (Maximum_Age__c = null OR Maximum_Age__c > :age)';
        }
        
        if(filterList != null && filterList != ''){
            queryStr +=queryStr.containsIgnoreCase('where')? ' AND All_Types__c includes '+ filterValue +' WITH SECURITY_ENFORCED':' where All_Types__c includes '+ filterValue +' WITH SECURITY_ENFORCED';
        }else{
            queryStr += ' WITH SECURITY_ENFORCED';
        }
        
      decimal defaultMaxDistance = [
        SELECT Default_Max_Distance__c
        FROM RefRecSettings__mdt limit 1
      ]
      .Default_Max_Distance__c;
      
      List<Service__c> serList = new List<Service__c>();
      serList = database.query(queryStr);
          
      return [
        SELECT
          id,
          Name,
          Account__c,
          Account__r.Name,
          Description__c,
          City__c,
          Phone__c,
          Street__c,
          Type__c,
          All_Types__c,
          Website__c,
          Zip_Code__c,
          Preferred__c,
          Near_Homeless__c, 
          Homeless__c,
          Runaway__c,
          Home_Owner__c,
          Home_Renter__c,
          Retired__c,
          Unemployed__c,
          Employed_full_time__c,
          Employed_part_time__c,
          Service_Tags__c,
          Situation_Tags__c,
          DISTANCE(
            Location__c,
            GEOLOCATION(:client.Location__Latitude__s,
              :client.Location__Longitude__s
            ),
            'mi'
          ) dist
        FROM Service__c
        WHERE
          DISTANCE(
            Location__c,
            GEOLOCATION(:client.Location__Latitude__s,
              :client.Location__Longitude__s
            ),
            'mi'
          ) < :defaultMaxDistance
          AND
              Id in : serList
        WITH SECURITY_ENFORCED
      ];
    } else{
      return null;
    }
}

public static decimal calculateAge(Date DOB) {
  return DOB.daysBetween(system.today()) / 365;
}
}
