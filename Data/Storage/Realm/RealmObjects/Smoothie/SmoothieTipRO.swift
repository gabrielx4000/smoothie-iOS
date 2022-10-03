import Domain
import Foundation
import RealmSwift

public class SmoothieTipRO: EmbeddedObject {
    
    @Persisted public var title: String
    
    @Persisted public var text: String
    
    public init(tip: SmoothieTip) {
        self.title = tip.title
        self.text = tip.text
    }
    
    override init() {
        super.init()
    }
    
}

extension SmoothieTipRO {
    
    func toDomain() -> SmoothieTip {
        return SmoothieTip(title: title, text: text)
    }
    
}
