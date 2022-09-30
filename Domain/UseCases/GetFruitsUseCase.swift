import Combine
import Foundation

public protocol GetFruitsUseCaseProtocol {
    
    func start() -> AnyPublisher<[Fruit], Error>
    
}

public class GetFruitsUseCase: GetFruitsUseCaseProtocol {
    
    private let repository: FruitsRepositoryInterface
    
    public init(repository: FruitsRepositoryInterface) {
        self.repository = repository
    }
    
    public func start() -> AnyPublisher<[Fruit], Error> {
        return repository.getPublisher()
    }
    
}
