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
  public Time TodaysEndHours { get; set; }

  @AuraEnabled
  public String MailingStreet { get; set; }

  @AuraEnabled
  public String MailingCity { get; set; }

  @AuraEnabled
  public String MailingState { get; set; }

  @AuraEnabled
  public String ServiceTags { get; set; }

  @AuraEnabled
  public String SituationTags { get; set; }

  @AuraEnabled
  public String[] AllTypes { get; set; }

  @AuraEnabled
  public String Website {
    get {
      if (Website != null) {
        if (Website.startsWith('https://') || Website.startsWith('http://')) {
          Website = Website;
        } else {
          Website = 'https://' + Website;
        }
      }
      return Website;
    }
    set;
  }

  @AuraEnabled
  public String ServicePhone { get; set; }

  @AuraEnabled
  public Decimal Rating { get; set; }

  @AuraEnabled
  public Integer ReferralCount { get; set; }

  @AuraEnabled
  public Decimal Distance { get; set; }

  @AuraEnabled
  public List<Comment> Comments { get; set; }

  @AuraEnabled
  public Boolean Hidden { get; set; }

  @AuraEnabled
  public Boolean HiddenAll { get; set; }

  @AuraEnabled
  public Integer totalRatings { get; set; }

  @AuraEnabled
  public Integer Preferred { get; set; }

  @AuraEnabled
  public List<Indicator> Indicators { get; set; }

  @AuraEnabled
  public List<String> Matches { get; set; }

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
    public String IndicatorType {
      get {
        IndicatorType = IndicatorType.replace('_', ' ');
        return IndicatorType;
      }
      set;
    }

    @AuraEnabled
    public String IndicatorValue {
      get {
        if (IndicatorValue.contains('.')) {
          Double value = Double.valueOf(IndicatorValue);
          if (value != null) {
            Double scale = Math.pow(10, 2);
            value = Math.round(value * scale) / scale;
          }
          return String.valueOf(value);
        } else {
          return IndicatorValue;
        }
      }
      set;
    }
    @AuraEnabled
    public Decimal IndicatorPercentile { get; set; }
  }

  public ServiceRecommendation addIndicator(
    string typ,
    string value,
    decimal pct
  ) {
    Indicator i = new Indicator();
    i.IndicatorPercentile = pct;
    i.IndicatorType = typ;
    i.IndicatorValue = value;
    this.Indicators.add(i);
    return this;
  }

  public class Comment {
    @AuraEnabled
    public String CommentText { get; set; }
  }
}