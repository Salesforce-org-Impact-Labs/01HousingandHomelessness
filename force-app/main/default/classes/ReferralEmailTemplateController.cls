global class ReferralEmailTemplateController {
    global String referralId {get;set;}

    global Referral__c referral {
        get {
            List<Referral__c> referrals =
                referralId != null ? [
                    SELECT  
                        Id,
                        Contact__c,
                        Service__c,
                        Service__r.Type__c
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

}