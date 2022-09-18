import Foundation

public class Endpoint {
    
    let host: String
    
    let network: NetworkHandler
    
    public init(host: String, network: NetworkHandler) {
        self.host = host.hasSuffix("/") ? String(host.dropLast(1)) : host
        self.network = network
    }
    
}
