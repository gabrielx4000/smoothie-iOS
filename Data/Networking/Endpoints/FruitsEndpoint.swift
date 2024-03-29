import Foundation

public protocol FruitsEndpointProtocol {
    
    func start() async throws -> [FruitDTO]
    
}

public class FruitsEndpoint: Endpoint, FruitsEndpointProtocol {
    
    public func start() async throws -> [FruitDTO] {
        guard let url = URL(string: "\(host)/fruit/all") else { throw NetworkError.urlParsing }
        
        return try await network.start([FruitDTO].self, request: URLRequest(url: url))
    }
    
}
