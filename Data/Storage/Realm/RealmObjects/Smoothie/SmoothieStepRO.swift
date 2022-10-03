import Domain
import Foundation
import RealmSwift

public class SmoothieStepRO: EmbeddedObject {
    
    @Persisted public var number: String
    
    @Persisted public var text: String
    
    public init(step: SmoothieStep) {
        self.number = step.number
        self.text = step.text
    }
    
    override init() {
        super.init()
    }
    
}

extension SmoothieStepRO {
    
    func toDomain() -> SmoothieStep {
        return SmoothieStep(number: number, text: text)
    }
    
}
