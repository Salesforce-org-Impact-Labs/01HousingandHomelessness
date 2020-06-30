public class ServicePrint {


    @AuraEnabled
    public String serviceId {get;set;}

    public ServicePrint() {

    }

    @AuraEnabled
    public static Blob PrintPage(Id serviceId){
        Attachment attach = new Attachment();
        attach.body = Blob.valueOf('');  
        Blob body = Blob.valueOf(''); 
        System.debug('serviceId' + serviceId);

        Service__c service = [SELECT Id, Name FROM Service__c WHERE Id =:serviceId];

        try {
           	PageReference nr = new PageReference('/apex/ServicePrintPage');
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
        return body;
        
        // return attach;

    }
}
