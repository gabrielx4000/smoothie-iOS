import UIKit

public class SearchCoordinator: CoordinatorProtocol {
    
    public var children: [CoordinatorProtocol] = []
    
    public var navigationController: UINavigationController

    private let factory: SearchCoreFactory
    
    public init(navigationController: UINavigationController, factory: SearchCoreFactory = SearchFactory()) {
        self.factory = factory
        self.navigationController = navigationController
    }
    
    public func start() {
        let searchViewController = factory.createSearchViewController()
        navigationController.pushViewController(searchViewController, animated: false)
    }

}
