@isTest
private with sharing class Test_ServicePrint {
    @testSetup
    static void makeData() {
        Time start = Time.newInstance(9,0,0,0);
        Time stop = Time.newInstance(17,0,0,0);
        contact c = new Contact();
        c.LastName = 'TestContact';
        insert c;

        Service__c s = new Service__c();
        s.Name = 'Test Service for Printing';
        insert s;

        Open_Hours__c ohSun = new Open_Hours__c();
        ohSun.Service__c = s.Id;
        ohSun.End_Time__c = stop;
        ohSun.Start_Time__c = start;
        ohSun.Day__c = 'Sunday';
        insert ohSun;

        Open_Hours__c ohM = new Open_Hours__c();
        ohM.Service__c = s.Id;
        ohM.End_Time__c = stop;
        ohM.Start_Time__c = start;
        ohM.Day__c = 'Monday';
        insert ohM;

        Open_Hours__c ohTu = new Open_Hours__c();
        ohTu.Service__c = s.Id;
        ohTu.End_Time__c = stop;
        ohTu.Start_Time__c = start;
        ohTu.Day__c = 'Tuesday';
        insert ohTu;

        Open_Hours__c ohW = new Open_Hours__c();
        ohW.Service__c = s.Id;
        ohW.End_Time__c = stop;
        ohW.Start_Time__c = start;
        ohW.Day__c = 'Wednesday';
        insert ohW;

        Open_Hours__c ohT = new Open_Hours__c();
        ohT.Service__c = s.Id;
        ohT.End_Time__c = stop;
        ohT.Start_Time__c = start;
        ohT.Day__c = 'Thursday';
        insert ohT;

        Open_Hours__c ohF = new Open_Hours__c();
        ohF.Service__c = s.Id;
        ohF.End_Time__c = stop;
        ohF.Start_Time__c = start;
        ohF.Day__c = 'Friday';
        insert ohF;

        Open_Hours__c ohSat = new Open_Hours__c();
        ohSat.Service__c = s.Id;
        ohSat.End_Time__c = stop;
        ohSat.Start_Time__c = start;
        ohSat.Day__c = 'Saturday';
        insert ohSat;

    }

    static testMethod void printReferral() {
        id contactId = getTestContactId();
        id serviceId = getTestServiceId();

        Test.StartTest();
        
        ServicePrint.PrintPage(serviceId);
        Test.StopTest();

        list<Attachment> attachs = [Select Id, Name, ParentId FROM  Attachment WHERE ParentId = :serviceId];
        System.assertEquals(1, attachs.size());
        System.assertEquals(attachs[0].ParentId, serviceId);
    }

    static testMethod void openHours() {
        system.debug('running open hours');
        id serviceId = getTestServiceId();
        
        ApexPages.CurrentPage().getParameters().put('servId',serviceId);
        System.debug(serviceId);
        Test.StartTest();
        ServicePrint servP = new ServicePrint();
        servP.Saturday = null;
        servP.Sunday = null;
        servP.Wednesday = null;
        servP.Friday = null;
        Test.StopTest();

        List<Open_Hours__c> openHrs = [SELECT Id,Day__c, End_Time__c, Start_Time__c, Service__c FROM Open_Hours__c WHERE Service__c = :serviceId];
        
        system.assertEquals(openHrs.Size(), 7);
        system.assertEquals(servP.Saturday, 'S: Closed');
        system.assertEquals(servP.Sunday, 'S: Closed');
        system.assertEquals(servP.Wednesday, 'W: Closed');
        system.assertEquals(servP.Friday, 'F: Closed');


    }


    private static Id getTestContactId() {
        return [SELECT id FROM Contact WHERE LastName = 'TestContact'].Id;
    }

    private static Id getTestServiceId() {
        return [SELECT id FROM Service__c WHERE Name = 'Test Service for Printing'].Id;
    }


  
}