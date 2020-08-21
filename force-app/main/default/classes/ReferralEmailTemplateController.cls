global with sharing class ReferralEmailTemplateController {
    public String referralResponseId {get;set;}

    public Referral_Response__c referralResponse {
        get {
            List<Referral_Response__c> referralResponses =
                referralResponseId != null ? [
                    SELECT  
                        Id,
                        Question__c,
                        Response__c,
                        Referral__c,
                        Referral__r.Contact__c,
                        Referral__r.Contact__r.FirstName,
                        Referral__r.Contact__r.LastName,
                        Referral__r.Preferred_Channel__c,
                        Referral__r.Owner.Name,
                        Referral__r.Service__c,
                        Referral__r.Service__r.Name,
                        Referral__r.Service__r.Type__c,
                        Referral__r.Service__r.Street__c,
                        Referral__r.Service__r.City__c,
                        Referral__r.Service__r.Zip_Code__c,
                        Referral__r.Service__r.Phone__c,
                        Referral__r.Service__r.Website__c,
                        Referral__r.Score__c
                        FROM Referral_Response__c
                        WHERE Id = :referralResponseId
                    ]
                    : new List<Referral_Response__c>();
    
                return referralResponses.size() > 0 ? referralResponses[0] : new Referral_Response__c();
        }
        set;
    }

    public Organization org {
        get {
            List<Organization> orgs = [
                SELECT 
                    Id,
                    Name
                FROM Organization
                LIMIT 1
            ];
            return orgs[0];
        }
        set;
    }

    public List<Open_Hours__c> openHours {
        get {
            List<Open_Hours__c> hours = [
                SELECT
                    Day__c,
                    End_Time__c,
                    Start_Time__c
                FROM Open_Hours__c
                WHERE Service__c = :referralResponse.Referral__r.Service__c
            ];
            return hours;
        }
        set;
    }

    public String openHoursString {
        get {
            String hoursString = '';
            for (Open_Hours__c hour : openHours) {
                Datetime startDt = Datetime.newInstance(Date.today(),hour.Start_Time__c);
                String startTime = startDt.format('h:mm a');
                Datetime endDt = Datetime.newInstance(Date.today(),hour.End_Time__c);
                String endTime = endDt.format('h:mm a');

                hoursString = hoursString + hour.Day__c + ': '+startTime+' - '+endTime+' ';
            }
            return hoursString;
        }
        set;
    }

}