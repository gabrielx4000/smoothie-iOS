import Combine
import Foundation

public protocol SmoothiesRepositoryInterface {
    
    func getPublisher() -> AnyPublisher<[Smoothie], Error>
    
    func fetchSmoothie(_ title: String) async -> Smoothie
    
}
