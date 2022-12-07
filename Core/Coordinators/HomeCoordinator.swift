import UIKit

public class HomeCoordinator: CoordinatorProtocol {
    
    public var children: [CoordinatorProtocol] = []
    
    public var navigationController: UINavigationController
    
    private var factory: HomeCoreFactory

    public init(navigationController: UINavigationController, factory: HomeCoreFactory = HomeFactory()) {
        self.factory = factory
        self.navigationController = navigationController
    }
    
    public func start() {
        let homeViewController = factory.createHomeViewController()
        navigationController.pushViewController(homeViewController, animated: false)
    }
    
}
