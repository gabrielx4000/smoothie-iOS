import Combine
import Foundation

public protocol FruitsRepositoryInterface {
    
    func getPublisher() -> AnyPublisher<[Fruit], Never>
    
}
