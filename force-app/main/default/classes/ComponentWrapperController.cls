public class ComponentWrapperController {

    @AuraEnabled
    public static string getCaseContactId(String caseId){
        String contactId = [SELECT Id, ContactId FROM Case WHERE Id =:caseId].ContactId;

        return contactId;
    }
}