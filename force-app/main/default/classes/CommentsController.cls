/** SECURITY REVIEW FALSE POSITIVE
 * This apex class CommentsController needs to explicity WITHOUT SHARING.
 * This apex class queries the FEED ITEMS related to the referral recommendation recods. 
 * If the class does not run, WIHTOUT SHARING, salesforces requires the user to have VIEW ALL DATA access.
 * Giving VIEW ALL DATA is more security risk than fetching the feed items and running query WITHOUT SHARING.
 * 
*/
public without Sharing class CommentsController{
       
    public static List<ServiceRecommendation> getComments(List<ServiceRecommendation> recs) {
        
        /** SECURITY REVIEW FALSE POSITIVE:
         * https://trailblazer.salesforce.com/ideaView?id=08730000000b1HpAAI
         * Without the VIEW ALL DATA access, this query throws "Implementation restriction: FeedItem requires a filter by Id".
         * Hence this query is being executed in a without sharing class so that it can run as any non System Admin user personas 
         */
         
        list<FeedItem> FeedItems = [
            SELECT id, ParentId, Body
            FROM FeedItem
            WHERE ParentId IN :getRecommendations.IDsFromRecommendations(recs) AND Type = 'TextPost'
            WITH SECURITY_ENFORCED
            ORDER BY ParentId
        ];
        map<id, list<string>> feedItemsByService = new Map<id, list<string>>();
        for (feedItem fi : FeedItems) {
            list<string> existing = feedItemsByService.get(fi.ParentId);
            if (existing == null) {
                existing = new List<string>();
            }
            existing.add(fi.Body);
            feedItemsByService.put(fi.ParentId, existing);
        }
        
        for (ServiceRecommendation rec : recs) {
            list<string> comments = feedItemsByService.get(rec.ServiceId);
            if (comments != null && comments.size() > 0) {
                for (string comment : comments) {
                    ServiceRecommendation.Comment commentToAdd = new ServiceRecommendation.Comment();
                    commentToAdd.CommentText = comment;
                    rec.Comments.add(commentToAdd);
                }
            }
        }
        return recs;
   } 
}