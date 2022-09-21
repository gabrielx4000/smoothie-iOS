import Foundation

public class SmoothieEndpoint: Endpoint {
    
    public func start(title: String) async throws -> [SmoothieCompleteDTO] {
        guard var components = URLComponents(string: host) else { throw NetworkError.urlParsing }
        
        components.queryItems = [URLQueryItem(name: "title", value: title)]
        components.path = "/smoothies"
        
        guard let url = components.url else { throw NetworkError.urlParsing }
        
        return try await network.start([SmoothieCompleteDTO].self, request: URLRequest(url: url))
    }
    
}

