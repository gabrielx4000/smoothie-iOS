import Domain
import Foundation

public struct SmoothieTipDTO: Decodable {
    
    public var title: String
    
    public var text: String
    
    public init(title: String, text: String) {
        self.title = title
        self.text = text
    }
    
}

extension SmoothieTipDTO {
    
    func toDomain() -> SmoothieTip {
        return SmoothieTip(title: title, text: text)
    }
    
}
