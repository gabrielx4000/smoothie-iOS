import Combine
import Foundation

public protocol GetSmoothiesUseCaseProcol {
    
    func start() -> AnyPublisher<[Smoothie], Error>
    
}

public class GetSmoothiesUseCase: GetSmoothiesUseCaseProcol {
    
    private let repository: SmoothiesRepositoryInterface
    
    public init(repository: SmoothiesRepositoryInterface) {
        self.repository = repository
    }
    
    public func start() -> AnyPublisher<[Smoothie], Error> {
        return repository
            .getPublisher()
            .map { smoothies in
                smoothies.sorted(by: { $0.title.caseInsensitiveCompare($1.title) == .orderedAscending})
            }
            .eraseToAnyPublisher()
    }
    
}
