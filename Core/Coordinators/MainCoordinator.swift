import UIKit

public class MainCoordinator: CoordinatorProtocol {
    
    public var children: [CoordinatorProtocol] = []
    
    public var navigationController: UINavigationController
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func start() {
        let vc = UIViewController()
        vc.view.backgroundColor = .purple
        
        navigationController.pushViewController(vc, animated: false)
    }
    
}
