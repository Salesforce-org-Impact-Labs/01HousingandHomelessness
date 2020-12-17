public with sharing class ComponentWrapperController {

     @AuraEnabled
    public static string getCaseContactId(String caseId){
        String contactId = [SELECT Id, ContactId FROM Case WHERE Id =:caseId WITH SECURITY_ENFORCED].ContactId;

        return contactId;
    }
}