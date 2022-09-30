import Domain
import Foundation

public struct SmoothieStepDTO: Decodable {
    
    public var number: String
    
    public var text: String
    
    public init(number: String, text: String) {
        self.number = number
        self.text = text
    }
    
}

extension SmoothieStepDTO {
    
    func toDomain() -> SmoothieStep {
        return SmoothieStep(number: number, text: text)
    }
    
}
