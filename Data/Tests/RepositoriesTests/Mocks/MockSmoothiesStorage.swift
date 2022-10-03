import Data
import Domain
import Foundation

public class MockSmoothiesStorage: SmoothiesStorageProtocol {
    
    public var values = [Smoothie]()
    
    public func fetchSmoothies() -> [Smoothie] {
        return values
    }
    
    public func save(smoothies: [Smoothie]) throws {
        values.append(contentsOf: smoothies)
    }
    
    public func save(smoothie: Smoothie) throws {
        values.append(smoothie)
    }
    
    public func update(smoothie: Smoothie) throws {
        var filteredValues = values.filter { smoothie.url != $0.url }
        filteredValues.append(smoothie)
        values = filteredValues
    }
    
    
}
