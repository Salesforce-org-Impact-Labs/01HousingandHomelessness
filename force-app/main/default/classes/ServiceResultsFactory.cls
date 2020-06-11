public class ServiceResultsFactory extends ServiceProviderAbstractFactory {

	public override ServiceProvider getServiceProvider (string svc_name) {
        return null;
    }

    public override ServiceResults getServiceProviderResults(string query) {
        if(query == null) {
            return null;
        }
        if(query.equalsIgnoreCase('OneDegreeResults')) {
            return new OneDegreeServiceProviderResults();
        }else if(query.equalsIgnoreCase('AuntBerthaResults')) {
           return new AuntBerthaServiceProviderResults(); 
        }
        return null;
    }    
}
