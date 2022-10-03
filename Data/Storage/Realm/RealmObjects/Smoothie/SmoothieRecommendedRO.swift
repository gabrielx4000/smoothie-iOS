import Domain
import Foundation
import RealmSwift

public class SmoothieRecommendedRO: EmbeddedObject {
    
    @Persisted public var title: String
    
    @Persisted public var url: String
    
    @Persisted public var image: String
    
    public init(recommended: SmoothieRecommended) {
        self.title = recommended.title
        self.url = recommended.url
        self.image = recommended.image
    }
    
    override init() {
        super.init()
    }
    
}

extension SmoothieRecommendedRO {
    
    func toDomain() -> SmoothieRecommended {
        return SmoothieRecommended(title: title, url: url, image: image)
    }
    
}
