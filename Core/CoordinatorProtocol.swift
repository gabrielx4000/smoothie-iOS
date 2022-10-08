import UIKit

public protocol CoordinatorProtocol {
    
    var children: [CoordinatorProtocol] { get set }
    
    var navigationController: UINavigationController { get set }

    func start()
    
}
