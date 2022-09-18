import Foundation

public class NetworkHandler {
    
    public func start<T: Decodable>(_ type: T.Type, request: URLRequest) async throws -> T {
        return try await withCheckedThrowingContinuation { continuation in
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let data = data, let decoded = try? JSONDecoder().decode(type, from: data) {
                    continuation.resume(returning: decoded)
                } else {
                    continuation.resume(throwing: NetworkError.unknown)
                }
            }.resume()
        }
    }
    
}
