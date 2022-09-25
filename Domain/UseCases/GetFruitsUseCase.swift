import Combine
import Foundation

public protocol GetFruitsUseCaseProtocol {
    
    func start() -> AnyPublisher<[Fruit], Never>
    
}

public class GetFruitsUseCase: GetFruitsUseCaseProtocol {
    
    private let repository: FruitsRepositoryInterface
    
    public init(repository: FruitsRepositoryInterface) {
        self.repository = repository
    }
    
    public func start() -> AnyPublisher<[Fruit], Never> {
        return repository.getPublisher()
    }
    
}
