import Foundation
import Presentation
import Swinject
import UIKit

public protocol HomeFactoryCoreProtocol {
    func createHomeViewController() -> HomeViewController
}

public typealias HomeCoreFactory = HomeFactoryPresentationProtocol & HomeFactoryCoreProtocol

public class HomeFactory: FactoryProtocol, HomeCoreFactory {

    let container: Container

    public init(container: Container = Container()) {
        self.container = container
        register()
    }

    func register() {
        registerHomeViewModel()
        registerHomeViewController()
    }

    public func createHomeViewController() -> HomeViewController {
        guard
            let homeViewController = container.resolve(HomeViewController.self)
        else { fatalError("could not resolve HomeViewController class") }
        return homeViewController
    }

    public func createHomeViewModel() -> HomeViewModel {
        guard
            let homeViewModel = container.resolve(HomeViewModel.self)
        else { fatalError("could not resolve HomeViewModel class") }
        return homeViewModel
    }

    private func registerHomeViewModel() {
        guard container.resolve(HomeViewModel.self) == nil else { return }
        container.register(HomeViewModel.self) { _ in
            return HomeViewModel()
        }
    }

    private func registerHomeViewController() {
        guard container.resolve(HomeViewController.self) == nil else { return }
        container.register(HomeViewController.self) { _ in
            return HomeViewController(factory: self)
        }
    }
}
