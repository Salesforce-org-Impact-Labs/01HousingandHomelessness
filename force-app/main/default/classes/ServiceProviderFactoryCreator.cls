public class ServiceProviderFactoryCreator {

    public static ServiceProviderAbstractFactory getFactory(string param) {
        if(param.equalsIgnoreCase('ServiceProvider')) {
            return new ServiceProviderFactory();
        }else if(param.equalsIgnoreCase('ServiceProviderResults')) {
            return new ServiceResultsFactory();
        }
        return null;
    }
}
