import Presentation
import UIKit

public class ConnectionCoordinator: CoordinatorProtocol {

    public var children: [CoordinatorProtocol] = []

    public var navigationController: UINavigationController

    private let factory: ConnectionCoreFactory

    public init(navigationController: UINavigationController, factory: ConnectionCoreFactory = ConnectionFactory()) {
        self.factory = factory
        self.navigationController = navigationController
    }

    public func start() {
        navigationController.popToRootViewController(animated: true)
        
        let connectionViewController = factory.createConnectionViewController()
        
        navigationController.pushViewController(connectionViewController, animated: false)
    }

}
