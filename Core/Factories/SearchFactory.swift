import Presentation
import Swinject
import UIKit

public protocol SearchCoreFactoryProtocol {
    func createSearchViewController() -> SearchViewController
}

public typealias SearchCoreFactory = SearchFactoryPresentationProtocol & SearchCoreFactoryProtocol

public class SearchFactory: FactoryProtocol, SearchCoreFactory {

    let container: Container

    public init(container: Container = Container()) {
        self.container = container
        register()
    }

    func register() {
        registerSearchViewModel()
        registerSearchViewController()
    }

    public func createSearchViewController() -> SearchViewController {
        guard
            let viewController = container.resolve(SearchViewController.self)
        else { fatalError("could not resolve SearchViewController class") }
        return viewController
    }

    public func createSearchViewModel() -> SearchViewModel {
        guard
            let viewModel = container.resolve(SearchViewModel.self)
        else { fatalError("could not resolve SearchViewModel class") }
        return viewModel
    }

    private func registerSearchViewModel() {
        guard container.resolve(SearchViewModel.self) == nil else { return }
        container.register(SearchViewModel.self) { _ in
            return SearchViewModel()
        }
    }

    private func registerSearchViewController() {
        guard container.resolve(SearchViewController.self) == nil else { return }
        container.register(SearchViewController.self) { _ in
            return SearchViewController(factory: self)
        }
    }
}
