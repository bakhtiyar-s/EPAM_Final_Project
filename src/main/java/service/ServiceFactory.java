package service;

public class ServiceFactory {
    public static Service getService(String serviceName) {
        ServiceType serviceType = ServiceType.valueOf(serviceName);
        return serviceType.getService();
    }
}
