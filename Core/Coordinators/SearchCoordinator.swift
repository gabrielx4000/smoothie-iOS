import Presentation
import UIKit

public class SearchCoordinator: CoordinatorProtocol {
    
    public var children: [CoordinatorProtocol] = []
    
    public var navigationController: UINavigationController
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func start() {
        let searchViewController = SearchViewController()
        navigationController.pushViewController(searchViewController, animated: false)
    }
    
}
