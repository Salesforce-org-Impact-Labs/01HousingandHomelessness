public with sharing class ComponentWrapperController {


    public static String getCaseContactId(String caseId){
        String contactId = [SELECT Id, ContactId FROM Case WHERE Id =:caseId].ContactId;

        return contactId;
    }
}
