import Foundation
import Presentation
import Swinject
import UIKit

public protocol TabCoreFactoryProtocol {
    func createNavigationController() -> UINavigationController
    func createMainTabBarController() -> MainTabBarController
}

public typealias TabCoreFactory = TabCoreFactoryProtocol

public class TabFactory: FactoryProtocol, TabCoreFactory {

    let container: Container

    public init(container: Container = Container()) {
        self.container = container
        register()
    }

    func register() {
        registerNavigationController()
        registerMainTabBarController()
    }
    
    public func createNavigationController() -> UINavigationController {
        guard
            let navigationController = container.resolve(UINavigationController.self)
        else { fatalError("could not resolve UINavigationController class") }
        return navigationController
    }

    public func createMainTabBarController() -> MainTabBarController {
        guard
            let viewController = container.resolve(MainTabBarController.self)
        else { fatalError("could not resolve MainTabBarController class") }
        return viewController
    }

    private func registerNavigationController() {
        guard container.resolve(UINavigationController.self) == nil else { return }
        container.register(UINavigationController.self) { _ in
            return UINavigationController()
        }
    }
    
    private func registerMainTabBarController() {
        guard container.resolve(MainTabBarController.self) == nil else { return }
        container.register(MainTabBarController.self) { _ in
            let tabBarController = MainTabBarController()
            let controllers = TabBarPages.allCases.compactMap {
                let navigationController = self.createNavigationController()
                navigationController.setNavigationBarHidden(true, animated: false)
                navigationController.tabBarItem = UITabBarItem(
                    title: $0.title,
                    image: $0.icon,
                    selectedImage: $0.iconSelected
                )

                return navigationController
            }
            tabBarController.setViewControllers(controllers, animated: false)
            return tabBarController
        }
    }

}
