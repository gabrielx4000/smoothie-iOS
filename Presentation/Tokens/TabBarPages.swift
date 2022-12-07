import UIKit

public enum TabBarPages: Int, CaseIterable {
    
    case home = 0
    case search = 1
    case fruits = 2
    
    public init?(index: Int) {
        switch index {
        case 0: self = .home
        case 1: self = .search
        case 2: self = .fruits
        default: return nil
        }
    }
    
    public var title: String {
        switch self {
        case .home: return "tabBar_home_title".localized
        case .search: return "tabBar_search_title".localized
        case .fruits: return "tabBar_fruits_title".localized
        }
    }
    
    public var icon: UIImage? {
        switch self {
        case .home: return UIImage(systemName: "house")
        case .search: return UIImage(systemName: "magnifyingglass")
        case .fruits: return UIImage(systemName: "leaf")
        }
    }
    
    public var iconSelected: UIImage? {
        switch self {
        case .home: return UIImage(systemName: "house.fill")
        case .search: return UIImage(systemName: "text.magnifyingglass")
        case .fruits: return UIImage(systemName: "leaf.fill")
        }
    }
    
}
