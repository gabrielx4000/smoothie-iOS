import UIKit

extension UIColor {
    
    convenience init?(color: Colors) {
        self.init(named: color.name, in: .presentation, compatibleWith: nil)
    }
    
}
