public with sharing class serviceHide {
  @AuraEnabled
  public static void hide(id serviceId, Id contactId) {
    system.debug(serviceId);
    List<Service_Exclusion__c> toInsert = new List<Service_Exclusion__c>();
    Service_Exclusion__c SE = new Service_Exclusion__c();
    SE.Service__c = serviceId;
    if (serviceId != null && contactId != null) {
      SE.Contact__c = contactId;
    }
    toInsert.add(SE);
    insert Security.stripInaccessible(AccessType.CREATABLE, toInsert)
      .getRecords();
    // insert SE;
  }

  @AuraEnabled
  public static void unHide(id serviceId, Id contactId) {
    if (contactId != null) {
      delete [
        SELECT id
        FROM Service_Exclusion__c
        WHERE
          createdById = :UserInfo.getUserId()
          AND Service__c = :serviceId
          AND Contact__c = :contactId
      ];
    } else {
      delete [
        SELECT id
        FROM Service_Exclusion__c
        WHERE
          createdById = :UserInfo.getUserId()
          AND Service__c = :serviceId
          AND Contact__c = null
      ];
    }
  }
}
