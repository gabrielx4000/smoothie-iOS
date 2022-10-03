import Data
import Domain
import Foundation

public class MockFruitsStorage: FruitsStorageProtocol {
    
    public var values = [Fruit]()
    
    public func fetchFruits() -> [Fruit] {
        return values
    }
    
    public func saveFruits(fruits: [Fruit]) throws {
        values.append(contentsOf: fruits)
    }
    
}
