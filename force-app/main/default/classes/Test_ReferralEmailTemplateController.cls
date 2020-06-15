@IsTest
public  class Test_ReferralEmailTemplateController {

    @TestSetup
    static void makeData(){
        Contact cont = new Contact (
            FirstName = 'Test',
            LastName = 'Tester',
            Email = 'testy@tester.org',
            Phone = '8885551212',
            MobilePhone = '8005551212',
            Mobile_Phone_Carrier__c = 'AT&T'
        );
        insert cont;

        Service__c svc = new Service__c (
            Name = 'Test Service',
            City__c = 'Boston',
            Description__c = 'Test Service for Testing',
            Maximum_Age__c = 100,
            Minimum_Age__c = 12,
            Phone__c = '4155551212',
            Street__c = '123 Main Street',
            Type__c = 'Care',
            Website__c = 'testing@testservice.org',
            Zip_Code__c = '12345'
        );
        insert svc;

        Open_Hours__c open = new Open_Hours__c (
            Day__c = 'Monday',
            Start_Time__c = Time.newInstance(9, 0, 0, 0),
            End_Time__c = Time.newInstance(17, 0, 0, 0),
            Service__c = svc.Id
        );
        insert open;

        Referral__c ref = new Referral__c (
            Contact__c = cont.Id,
            Preferred_Channel__c = 'SMS',
            Score__c = 5,
            Service__c = svc.Id
        );
        insert ref;
        
    }

    static testMethod void testGetData() {
        List<Contact> contacts = [
            SELECT 
                Id
            FROM Contact
            WHERE LastName = 'Tester'
        ];

        List<Referral__c> referrals = [
            SELECT
                Id
            FROM Referral__c
            WHERE Contact__c = :contacts[0].Id
        ];

        Test.startTest();
        ReferralEmailTemplateController controller = new ReferralEmailTemplateController();
        controller.referralId = referrals[0].Id;
        Test.stopTest();

        Referral__c referral = controller.referral;
        System.assertEquals('Care',referral.Service__r.Type__c);
        System.assertEquals('Test Service',referral.Service__r.Name);
        System.assertEquals('Tester',referral.Contact__r.LastName);

        System.assertEquals('Monday: 9:00 AM - 5:00 PM', controller.openHoursString);
    }


}
