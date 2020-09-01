@isTest
public with sharing class Test_ComponentWrapperController {
    @testSetup
    static void makeData() {
        contact c = new Contact();
        c.FirstName = 'FirstName';
        c.LastName = 'TestContact';
        insert c;

        case cse = new Case();
        cse.Subject = 'TestCase';
        cse.ContactId = c.Id;
        insert cse;
    }

    static testMethod void testGetContactFromCase() {
        id contactId = getTestContactId();
        id caseId = getTestCaseId();

        String conId = ComponentWrapperController.getCaseContactId(caseId);

        System.assertEquals(conId,ContactId);

    }


    private static Id getTestContactId() {
        return [SELECT id, LastName FROM Contact WHERE LastName = 'TestContact'].Id;
    }

    private static Id getTestCaseId() {
        return [SELECT id, Subject, ContactId FROM Case WHERE Subject = 'TestCase'].Id;
    }
}
