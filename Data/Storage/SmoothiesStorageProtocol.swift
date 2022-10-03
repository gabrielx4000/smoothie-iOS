import Domain
import Foundation

public protocol SmoothiesStorageProtocol {
    
    func fetchSmoothies() -> [Smoothie]
    
    func save(smoothies: [Smoothie]) throws
    
    func save(smoothie: Smoothie) throws
    
    func update(smoothie: Smoothie) throws
    
}
