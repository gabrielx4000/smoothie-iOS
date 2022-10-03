import Presentation
import UIKit

public class MainCoordinator: CoordinatorProtocol {
    
    public var children: [CoordinatorProtocol] = []
    
    public var navigationController: UINavigationController
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func start() {
        showConnection()
    }
    
    private func showConnection() {
        navigationController.popToRootViewController(animated: true)
        
        let connectionViewController = ConnectionViewController(viewModel: ConnectionViewModel())
        
        navigationController.pushViewController(connectionViewController, animated: false)
    }
    
}
