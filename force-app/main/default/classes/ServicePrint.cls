public class ServicePrint {


    @AuraEnabled
    public String serviceId {get;set;}
    public Service__c service {get;set;}
    public List<Open_Hours__c> hrs {get;set;}
    public List<Open_Hours__c> allHours {get;set;}
    public String Sunday {
        get {
            if(Sunday == null){
                Sunday = 'S: Closed';
            }else{
                Sunday = Sunday;
            }
        return Sunday;}
        set;
    }
    public String Monday {
        get {
            if(Monday == null){
                Monday = 'M: Closed';
            }else{
                Monday = Monday;
            }
        return Monday;}
        set;
    }
    public String Tuesday {
        get {
            if(Tuesday == null){
                Tuesday = 'T: Closed';
            }else{
                Tuesday = Tuesday;
            }
        return Tuesday;}
        set;
    }
    public String Wednesday {
        get {
            if(Wednesday == null){
                Wednesday = 'W: Closed';
            }else{
                Wednesday = Wednesday;
            }
        return Wednesday;}
        set;
    }
    public String Thursday {
        get {
            if(Thursday == null){
                Thursday = 'T: Closed';
            }else{
                Thursday = Thursday;
            }
        return Thursday;}
        set;
    }
    public String Friday {
        get {
            if(Friday == null){
                Friday = 'F: Closed';
            }else{
                Friday = Friday;
            }
        return Friday;}
        set;
    }
    public String Saturday {
        get {
            if(Saturday == null){
                Saturday = 'S: Closed';
            }else{
                Saturday = Saturday;
            }
        return Saturday;}
        set;
    }

    public ServicePrint() {
        String servId = ApexPages.currentPage().getParameters().get('servId');
        System.debug('serviceId' + servId);
        List<Open_Hours__c> allHours = getOpenHours(servId);
    }

    public Service__c getServices(string serviceId) {
        Service__c newserv = [SELECT Id, Name, Account__r.Name, Type__c,Description__c, Website__c, Account__r.ShippingStreet, Account__r.ShippingCity, Account__r.ShippingState, Account__r.ShippingPostalCode, Account__r.Phone FROM Service__c WHERE Id = :serviceId];
        system.debug('serv' + newserv);
        return newserv;
    }

    public List<Open_Hours__c> getOpenHours(string serviceId){
        system.debug('serviceId' + serviceId);
        List<Open_Hours__c> hrs = [SELECT Id,Day__c, End_Time__c, Start_Time__c, Service__c FROM Open_Hours__c WHERE Service__c = :serviceId];
        
        for(Open_Hours__c hour: hrs){
            System.debug(hour.Day__c);
            System.debug(String.valueOf(hour.Start_Time__c));
            switch on hour.Day__c {
                when 'Sunday' {
                    Sunday = 'S: ' + Datetime.newInstance(Date.Today(), hour.Start_Time__c).format('hh:mm a') + ' - ' + Datetime.newInstance(Date.Today(), hour.End_Time__c).format('hh:mm a');
                }
                when 'Monday' {
                    Monday = 'M: ' + Datetime.newInstance(Date.Today(), hour.Start_Time__c).format('hh:mm a') + ' - ' + Datetime.newInstance(Date.Today(), hour.End_Time__c).format('hh:mm a');
                }
                when 'Tuesday' {
                    Tuesday = 'T: ' + Datetime.newInstance(Date.Today(), hour.Start_Time__c).format('hh:mm a') + ' - ' + Datetime.newInstance(Date.Today(), hour.End_Time__c).format('hh:mm a');
                }
                when 'Wednesday' {
                    Wednesday = 'W: ' + Datetime.newInstance(Date.Today(), hour.Start_Time__c).format('hh:mm a') + ' - ' + Datetime.newInstance(Date.Today(), hour.End_Time__c).format('hh:mm a');
                }
                when 'Thursday' {
                    Thursday = 'T: ' + Datetime.newInstance(Date.Today(), hour.Start_Time__c).format('hh:mm a') + ' - ' + Datetime.newInstance(Date.Today(), hour.End_Time__c).format('hh:mm a');
                    System.debug(Thursday);
                }
                when 'Friday' {
                    Friday = 'F: ' + Datetime.newInstance(Date.Today(), hour.Start_Time__c).format('hh:mm a') + ' - ' + Datetime.newInstance(Date.Today(), hour.End_Time__c).format('hh:mm a');
                }
                when 'Saturday' {
                    Saturday = 'S: ' + Datetime.newInstance(Date.Today(), hour.Start_Time__c).format('hh:mm a') + ' - ' + Datetime.newInstance(Date.Today(), hour.End_Time__c).format('hh:mm a');
                }
            }
        }
        service = getServices(serviceId);
        system.debug(service);
        return hrs;
    
    }

    @AuraEnabled
    public static String PrintPage(String serviceId){
        Attachment attach = new Attachment();
        attach.body = Blob.valueOf('');  
        Blob body = Blob.valueOf(''); 
        System.debug('serviceId' + serviceId);

        try {
           	PageReference nr = new PageReference('/apex/ServicePrintPage?servId=' + serviceId);
            //nr.getParameters().put('service', service);
            body = nr.getContentAsPDF();
            

            // need to pass unit test -- current bug
        } catch (Exception err) {
            System.debug('An Error occurred generating the PDF: ' + err);
            body = Blob.valueOf('Err');
        }
        attach.Body = body;
        
        // Create name with today's date
        Integer count = 1;
        attach.Name = 'Referral - ' + Datetime.now().format('yyyy-MM-dd') + ' - ' + String.valueOf(count) + '.pdf';
        attach.IsPrivate = false; //make public
        attach.ParentId = serviceId; //attach pdf to record
        insert attach;

        String fullURL = URL.getSalesforceBaseUrl().toExternalForm() + '/apex/ServicePrintPage?servId=' + serviceId;
        System.debug(fullURL);
        return fullURL;

    }
}
