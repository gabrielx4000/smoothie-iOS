import Data
import Domain
import Presentation
import Swinject
import UIKit

public protocol FruitsCoreFactoryProtocol {
    func createFruitsViewController() -> FruitsViewController
}

public typealias FruitsCoreFactory = FruitsFactoryPresentationProtocol & FruitsCoreFactoryProtocol

public class FruitsFactory: FactoryProtocol, FruitsCoreFactory {
    
    let container: Container

    public init(container: Container = Container()) {
        self.container = container
        register()
    }
    
    func register() {
        registerFruitsViewModel()
        registerFruitsViewController()
        registerGetFruitsUseCase()
    }
    
    public func createFruitsViewController() -> FruitsViewController {
        guard
            let viewController = container.resolve(FruitsViewController.self)
        else { fatalError("could not resolve FruitsViewController class") }
        return viewController
    }
    
    public func createFruitsViewModel() -> FruitsViewModel {
        guard
            let viewModel = container.resolve(FruitsViewModel.self)
        else { fatalError("could not resolve FruitsViewModel class") }
        return viewModel
    }

    public func createGetFruitsUseCase() -> GetFruitsUseCaseProtocol {
        guard
            let useCase = container.resolve(GetFruitsUseCaseProtocol.self)
        else { fatalError("could not resolve GetFruitsUseCaseProtocol class") }
        return useCase
    }
    
    private func registerFruitsViewModel() {
        guard container.resolve(FruitsViewModel.self) == nil else { return }
        container.register(FruitsViewModel.self) { _ in
            return FruitsViewModel(factory: self)
        }
    }

    private func registerFruitsViewController() {
        guard container.resolve(FruitsViewController.self) == nil else { return }
        container.register(FruitsViewController.self) { _ in
            return FruitsViewController(factory: self)
        }
    }

    private func registerGetFruitsUseCase() {
        guard container.resolve(GetFruitsUseCaseProtocol.self) == nil else { return }
        container.register(GetFruitsUseCaseProtocol.self) { _ in
            let network = NetworkHandler()
            let endpoint = FruitsEndpoint(host: "https://www.fruityvice.com/api/", network: network)
            let storage = RealmFruitsStorage()
            let repository = FruitsRepository(endpoint: endpoint, storage: storage)
            return GetFruitsUseCase(repository: repository)
        }
    }
}
