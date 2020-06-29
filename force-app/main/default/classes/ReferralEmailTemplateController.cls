global class ReferralEmailTemplateController {
    global String referralId {get;set;}

    global Referral__c referral {
        get {
            List<Referral__c> referrals =
                referralId != null ? [
                    SELECT  
                        Id,
                        Contact__c,
                        Contact__r.FirstName,
                        Contact__r.LastName,
                        Preferred_Channel__c,
                        Owner.Name,
                        Service__c,
                        Service__r.Name,
                        Service__r.Type__c,
                        Service__r.Street__c,
                        Service__r.City__c,
                        Service__r.Zip_Code__c,
                        Service__r.Phone__c,
                        Service__r.Website__c
                    FROM Referral__c
                    WHERE Id = :referralId
                ]
                : new List<Referral__c>();

            return referrals.size() > 0 ? referrals[0] : new Referral__c();
        }
        set;
    }

    global Organization org {
        get {
            List<Organization> orgs = [
                SELECT 
                    Id,
                    Name
                FROM Organization
            ];
            return orgs[0];
        }
        set;
    }

    global List<Open_Hours__c> openHours {
        get {
            List<Open_Hours__c> hours = [
                SELECT
                    Day__c,
                    End_Time__c,
                    Start_Time__c
                FROM Open_Hours__c
                WHERE Service__c = :referral.Service__c
            ];
            return hours;
        }
        set;
    }

    global String openHoursString {
        get {
            String hoursString = '';
            for (Open_Hours__c hour : openHours) {
                Datetime startDt = Datetime.newInstance(Date.today(),hour.Start_Time__c);
                String startTime = startDt.format('h:mm a');
                Datetime endDt = Datetime.newInstance(Date.today(),hour.End_Time__c);
                String endTime = endDt.format('h:mm a');

                hoursString = hour.Day__c + ': '+startTime+' - '+endTime+'';
            }
            return hoursString;
        }
        set;
    }

}