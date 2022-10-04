import Combine
import Foundation

protocol GetSmoothiesHighestRatedUseCaseProtocol {
    
    func start(_ count: Int) -> AnyPublisher<[Smoothie], Error>
    
}

public class GetSmoothiesHighestRatedUseCase: GetSmoothiesHighestRatedUseCaseProtocol {
    
    private let repository: SmoothiesRepositoryInterface
    
    public init(repository: SmoothiesRepositoryInterface) {
        self.repository = repository
    }
    
    func start(_ count: Int) -> AnyPublisher<[Smoothie], Error> {
        return repository
            .getPublisher()
            .map { smoothies in
                let sortedSmoothies = smoothies.sorted(by: { $0.rating > $1.rating })
                
                return count > 0 ? Array(sortedSmoothies.prefix(count)) : sortedSmoothies
            }
            .eraseToAnyPublisher()
    }
    
}
