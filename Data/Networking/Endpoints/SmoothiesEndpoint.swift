import Foundation

public protocol SmoothiesEndpointProtocol {
    
    func start() async throws -> [SmoothieShortDTO]
    
}

public class SmoothiesEndpoint: Endpoint, SmoothiesEndpointProtocol {
    
    public func start() async throws -> [SmoothieShortDTO] {
        guard let url = URL(string: "\(host)/smoothies") else { throw NetworkError.urlParsing }
        
        return try await network.start([SmoothieShortDTO].self, request: URLRequest(url: url))
    }
    
}
