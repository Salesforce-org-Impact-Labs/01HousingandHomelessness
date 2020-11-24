public class OneDegreeServiceProvider implements ServiceProvider {

    private final String SVC_NAME;
    public OneDegreeServiceProvider() {
        SVC_NAME = 'OneDegree';
    }

    public String getServiceProviderName() {
        return SVC_NAME;
    }

}
