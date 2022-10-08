import Presentation
import UIKit

public class TabCoordinator: CoordinatorProtocol {
    
    public var children: [CoordinatorProtocol] = []
    
    public var navigationController: UINavigationController
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func start() {
        let controllers = getTabControllers()
        
        let tabBarController = MainTabBarController()
        tabBarController.setViewControllers(controllers, animated: false)
        tabBarController.selectedIndex = TabBarPages.home.rawValue
        
        navigationController.pushViewController(tabBarController, animated: false)
    }
    
    private func getTabControllers() -> [UIViewController] {
        TabBarPages.allCases.compactMap {
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
    }
    
}
