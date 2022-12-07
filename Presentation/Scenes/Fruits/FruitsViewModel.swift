import Combine
import Domain
import Foundation

public class FruitsViewModel {
    
    private let useCase: GetFruitsUseCaseProtocol
    
    private var cancellables = [AnyCancellable]()
    
    @Published var fruits = [Fruit]()
    
    public init(factory: FruitsFactoryPresentationProtocol) {
        self.useCase = factory.createGetFruitsUseCase()
        
        start()
    }

    private func start() {
        useCase.start().sink { completion in
            guard case .failure(let error) = completion else { return }
            print(error.localizedDescription)
        } receiveValue: { [weak self] fruits in
            guard let self = self else { return }
            self.fruits = fruits
        }.store(in: &cancellables)
    }
}
