import UIKit

extension UIColor {
    
    convenience init?(color: Color) {
        self.init(named: color.name, in: Bundle(for: ConnectionViewController.self), compatibleWith: nil)
    }
    
}
