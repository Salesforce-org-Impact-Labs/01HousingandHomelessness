@IsTest
private with sharing class Test_CarrierSettingsData {

    static testMethod void testGetEmailForCarrier() {
        test.startTest();
        String email = carrierSettingsData.getEmailForCarrier('AT&T');
        test.stopTest();

        System.assertEquals('txt.att.net', email);
    }

    static testMethod void testGetNoEmailForBadCarrier() {
        test.startTest();
        String email = carrierSettingsData.getEmailForCarrier('foo');
        test.stopTest();

        System.assertEquals(null, email);
    }
}