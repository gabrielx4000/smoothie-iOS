import Foundation

public class SmoothiesEndpoint: Endpoint {
    
    public func start() async throws -> [SmoothieShortDTO] {
        guard let url = URL(string: "\(host)/smoothies") else { throw NetworkError.urlParsing }
        
        return try await network.start([SmoothieShortDTO].self, request: URLRequest(url: url))
    }
    
}
