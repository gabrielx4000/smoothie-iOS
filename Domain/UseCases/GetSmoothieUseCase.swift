import Foundation

public protocol GetSmoothieUseCaseProcol {
    
    func start(_ title: String) async throws -> Smoothie
    
}

public class GetSmoothieUseCase: GetSmoothieUseCaseProcol {

    private let repository: SmoothiesRepositoryInterface

    public init(repository: SmoothiesRepositoryInterface) {
        self.repository = repository
    }

    public func start(_ title: String) async throws -> Smoothie {
        return await repository.fetchSmoothie(title)
    }

}
