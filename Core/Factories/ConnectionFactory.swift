import Data
import Domain
import Presentation
import Swinject
import UIKit

public protocol ConnectionCoreFactoryProtocol {
    func createConnectionViewController() -> ConnectionViewController
}

public typealias ConnectionCoreFactory = ConnectionFactoryPresentationProtocol & ConnectionCoreFactoryProtocol

public class ConnectionFactory: FactoryProtocol, ConnectionCoreFactory {

    let container: Container

    public init(container: Container = Container()) {
        self.container = container
        register()
    }
    
    func register() {
        
    }
    
    public func createConnectionViewModel() -> ConnectionViewModel {
        guard
            let viewModel = container.resolve(ConnectionViewModel.self)
        else { fatalError("could not resolve ConnectionViewModel class") }
        return viewModel
    }
    
    public func createConnectionViewController() -> ConnectionViewController {
        guard
            let viewController = container.resolve(ConnectionViewController.self)
        else { fatalError("could not resolve ConnectionViewController class") }
        return viewController
    }
    
    private func registerConnectionViewModel() {
        guard container.resolve(ConnectionViewModel.self) == nil else { return }
        container.register(ConnectionViewModel.self) { _ in
            return ConnectionViewModel(factory: self)
        }
    }

    private func registerConnectionViewController() {
        guard container.resolve(ConnectionViewController.self) == nil else { return }
        container.register(ConnectionViewController.self) { _ in
            return ConnectionViewController(factory: self)
        }
    }

}
