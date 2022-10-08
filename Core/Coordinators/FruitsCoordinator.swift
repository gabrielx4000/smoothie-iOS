import Presentation
import UIKit

public class FruitsCoordinator: CoordinatorProtocol {
    
    public var children: [CoordinatorProtocol] = []
    
    public var navigationController: UINavigationController
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func start() {
        let fruitsViewController = FruitsViewController()
        navigationController.pushViewController(fruitsViewController, animated: false)
    }
    
}

