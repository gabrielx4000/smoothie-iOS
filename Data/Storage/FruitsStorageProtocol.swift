import Domain
import Foundation

public protocol FruitsStorageProtocol {
    
    func fetchFruits() -> [Fruit]
    
    func saveFruits(fruits: [Fruit]) throws
    
}
