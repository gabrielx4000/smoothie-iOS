import Foundation

public class ConnectionViewModel {
    
    public init(factory: ConnectionFactoryPresentationProtocol) {}
    
    @objc public func retryConnection() {
        print("noConnetion")
    }
    
}
