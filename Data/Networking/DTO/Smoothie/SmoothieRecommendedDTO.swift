import Domain
import Foundation

public struct SmoothieRecommendedDTO: Decodable {
    
    public var title: String
    
    public var url: String
    
    public var image: String
    
    public init(title: String, url: String, image: String) {
        self.title = title
        self.url = url
        self.image = image
    }
    
}

extension SmoothieRecommendedDTO {
    
    func toDomain() -> SmoothieRecommended {
        return SmoothieRecommended(title: title, url: url, image: image)
    }
    
}
