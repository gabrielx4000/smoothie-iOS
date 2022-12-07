import UIKit

public class MainTabBarController: UITabBarController {
    
    public init() {
        super.init(nibName: nil, bundle: nil)
        
        tabBar.isTranslucent = false
        tabBar.backgroundColor = Colors.backgroundPrimary.rawValue
        tabBar.tintColor = Colors.selectedPrimary.rawValue
        tabBar.unselectedItemTintColor = Colors.textPrimary.rawValue
        tabBar.shadowImage = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
