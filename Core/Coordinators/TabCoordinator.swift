import Presentation
import UIKit

public class TabCoordinator: CoordinatorProtocol {
    
    public var children: [CoordinatorProtocol] = []
    
    public var navigationController: UINavigationController
    
    private var factory: TabCoreFactory

    public init(navigationController: UINavigationController, factory: TabCoreFactory = TabFactory()) {
        self.factory = factory
        self.navigationController = navigationController
    }
    
    public func start() {
        let tabBarController = factory.createMainTabBarController()
        
        let controllers = TabBarPages.allCases.compactMap {
            let navigationController = UINavigationController()
            navigationController.setNavigationBarHidden(true, animated: false)
            navigationController.tabBarItem = UITabBarItem(
                title: $0.title,
                image: $0.icon,
                selectedImage: $0.iconSelected
            )
            
            var coordinator: CoordinatorProtocol
            
            switch $0 {
            case .home: coordinator = HomeCoordinator(navigationController: navigationController)
            case .search: coordinator = SearchCoordinator(navigationController: navigationController)
            case .fruits: coordinator = FruitsCoordinator(navigationController: navigationController)
            }
            
            children.append(coordinator)
            coordinator.start()
            
            return navigationController
        }
        tabBarController.setViewControllers(controllers, animated: false)
        tabBarController.selectedIndex = TabBarPages.home.rawValue
        
        navigationController.pushViewController(tabBarController, animated: false)
    }
    
}
