public class ServiceRecommendation {
  @AuraEnabled
  public Service__c Service { get; set; }

  @AuraEnabled
  public Decimal Relevance { get; set; }

  @AuraEnabled
  public String ServiceId { get; set; }

  @AuraEnabled
  public String ProviderName { get; set; }

  @AuraEnabled
  public String AccountId { get; set; }

  @AuraEnabled
  public String ProgramName { get; set; }

  @AuraEnabled
  public String ProgramType { get; set; }

  @AuraEnabled
  public String ProgramDescription { get; set; }

  @AuraEnabled
  public Open_Hours__c TodaysHours { get; set; }

  @AuraEnabled
  public String MailingStreet { get; set; }

  @AuraEnabled
  public String MailingCity { get; set; }

  @AuraEnabled
  public String Website { get; set; }

  @AuraEnabled
  public Decimal Rating { get; set; }

  @AuraEnabled
  public Decimal Distance { get; set; }

  @AuraEnabled
  public List<Comment> Comments { get; set; }

  @AuraEnabled
  public Boolean Hidden { get; set; }

  @AuraEnabled
  public Integer totalRatings { get; set; }

  @AuraEnabled
  public Integer Preferred { get; set; }

  @AuraEnabled
  public List<Indicator> Indicators { get; set; }

  // dynamic getter for supporting returning certain properties
  public Decimal getValue(string property) {
    if (property == 'Distance') {
      return this.Distance;
    }
    if (property == 'Rating') {
      return this.Rating;
    }
    if (property == 'Preferred') {
      return this.Preferred;
    }
    return null;
  }

  public class Indicator {
    @AuraEnabled
    public String IndicatorType { get; set; }

    @AuraEnabled
    public String IndicatorValue { get; set; }

    @AuraEnabled
    public Decimal IndicatorPercentile { get; set; }
  }

  public class Comment {
    @AuraEnabled
    public String CommentText { get; set; }
  }
}
