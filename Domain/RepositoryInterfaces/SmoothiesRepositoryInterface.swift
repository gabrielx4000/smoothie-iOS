import Combine
import Foundation

public protocol SmoothiesRepositoryInterface {
    
    func getPublisher() -> AnyPublisher<[Smoothie], Error>
    
}
