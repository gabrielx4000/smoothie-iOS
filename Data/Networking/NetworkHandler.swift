import Foundation
import Reachability

public class NetworkHandler {
    
    lazy var reachability = Reachability()
    
    public func start<T: Decodable>(_ type: T.Type, request: URLRequest) async throws -> T {
        return try await withCheckedThrowingContinuation { continuation in
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let data = data {
                    if let decoded = try? JSONDecoder().decode(type, from: data) {
                        continuation.resume(returning: decoded)
                    } else if let errorDTO = try? JSONDecoder().decode(ErrorDTO.self, from: data) {
                        continuation.resume(throwing: errorDTO.toNetworkError())
                    } else {
                        continuation.resume(throwing: NetworkError.unknown)
                    }
                } else {
                    continuation.resume(throwing: NetworkError.unknown)
                }
            }
            
            self.reachability.publisher
                .subscribe(on: DispatchQueue.main)
                .sink { path in
                    if path.isReachable {
                        task.resume()
                    } else {
                        continuation.resume(throwing: NetworkError.noInternet)
                    }
                }.cancel()
        }
    }
    
}
