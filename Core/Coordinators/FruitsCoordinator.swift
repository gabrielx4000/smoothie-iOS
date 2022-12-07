import UIKit

public class FruitsCoordinator: CoordinatorProtocol {
    
    public var children: [CoordinatorProtocol] = []
    
    public var navigationController: UINavigationController
    
    private let factory: FruitsCoreFactory
    
    public init(navigationController: UINavigationController, factory: FruitsCoreFactory = FruitsFactory()) {
        self.factory = factory
        self.navigationController = navigationController
    }
    
    public func start() {
        let fruitsViewController = factory.createFruitsViewController()
        navigationController.pushViewController(fruitsViewController, animated: false)
    }
    
}

