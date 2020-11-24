public class AuntBerthaServiceProvider implements ServiceProvider {
    private final String SVC_NAME;
    public AuntBerthaServiceProvider() {
        SVC_NAME = 'AuntBertha';
    }
    public String getServiceProviderName() {
        return SVC_NAME;
    }
}
