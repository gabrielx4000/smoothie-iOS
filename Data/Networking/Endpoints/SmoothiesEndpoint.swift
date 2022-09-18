import Foundation

public class SmoothiesEndpoint: Endpoint {
    
    public func start() async throws -> [SmoothieListDTO] {
        guard let url = URL(string: "\(host)/smoothies") else { throw NetworkError.urlParsing }
        
        return try await network.start([SmoothieListDTO].self, request: URLRequest(url: url))
    }
    
}
