import Domain
import Foundation

public struct SmoothieShortDTO: Decodable {
    
    public var title: String
    
    public var url: String
    
    public var thumbnail: String
    
    public var rating: String
    
    public var tags: [String]
    
    public init(title: String, url: String, thumbnail: String, rating: String, tags: [String]) {
        self.title = title
        self.url = url
        self.thumbnail = thumbnail
        self.rating = rating
        self.tags = tags
    }
    
}

extension SmoothieShortDTO {
    
    func toDomain() -> Smoothie {
        return Smoothie(title: title, url: url, thumbnail: thumbnail, rating: Double(rating) ?? 0, tags: tags)
    }
    
}
