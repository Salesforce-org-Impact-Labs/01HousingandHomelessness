public class ServiceRecommendation {

    @AuraEnabled
    public Integer Relevance {get;set;}
    
    @AuraEnabled
    public String ServiceId {get;set;}

    @AuraEnabled
    public String ProviderName {get;set;}
    
    @AuraEnabled
    public String AccountId {get;set;}

    @AuraEnabled
    public String ProgramName {get;set;}
    
    @AuraEnabled
    public String ProgramType {get;set;}

    @AuraEnabled
    public String ProgramDescription {get;set;}

    @AuraEnabled
    public Open_Hours__c TodaysHours {get;set;}

    @AuraEnabled
    public String MailingStreet {get;set;}

    @AuraEnabled
    public String MailingCity {get;set;}

    @AuraEnabled
    public String Website {get;set;}

    @AuraEnabled
    public Decimal Rating {get;set;}

    @AuraEnabled
    public List<Comment> Comments {get;set;}

    @AuraEnabled
    public List<Indicator> Indicators {get;set;}

    public class Indicator {
        @AuraEnabled
        public String IndicatorType {get;set;}

        @AuraEnabled
        public String IndicatorValue {get;set;}
    }

    public class Comment {
        @AuraEnabled
        public String CommentText {get;set;}
    }
}
