import Presentation
import UIKit

public class HomeCoordinator: CoordinatorProtocol {
    
    public var children: [CoordinatorProtocol] = []
    
    public var navigationController: UINavigationController
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func start() {
        let homeViewController = HomeViewController()
        navigationController.pushViewController(homeViewController, animated: false)
    }
    
}
