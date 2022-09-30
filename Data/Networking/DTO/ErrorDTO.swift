import Foundation

struct ErrorDTO: Decodable {
    
    public var status: Int
    
    public var error: String
    
    public var message: String
    
}

extension ErrorDTO {
    
    func toNetworkError() -> NetworkError {
        return status == 404 ? .notFound : .unknown
    }
    
}
