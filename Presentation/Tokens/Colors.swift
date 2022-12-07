import Foundation
import UIKit

enum Colors {
    
    case actionTextOnColor, backgroundPrimary, selectedPrimary, primary, textPrimary
    
    var name: String {
        switch self {
        case .actionTextOnColor: return "actionTextOnColor"
        case .backgroundPrimary: return "backgroundPrimary"
        case .selectedPrimary: return "selectedPrimary"
        case .primary: return "primary"
        case .textPrimary: return "textPrimary"
        }
    }
    
}

extension Colors: RawRepresentable {
    
    typealias RawValue = UIColor
    
    init(rawValue: UIColor) {
        switch rawValue {
        case UIColor(color: .actionTextOnColor): self = .actionTextOnColor
        case UIColor(color: .backgroundPrimary): self = .backgroundPrimary
        case UIColor(color: .primary): self = .primary
        case UIColor(color: .textPrimary): self = .textPrimary
        case UIColor(color: .selectedPrimary): self = .selectedPrimary
        default: self = .primary
        }
    }
    
    var rawValue: UIColor {
        switch self {
        case .actionTextOnColor: return UIColor(color: .actionTextOnColor) ?? .white
        case .backgroundPrimary: return UIColor(color: .backgroundPrimary) ?? .white
        case .primary: return UIColor(color: .primary) ?? .systemPink
        case .textPrimary: return UIColor(color: .textPrimary) ?? .black
        case .selectedPrimary: return UIColor(color: .selectedPrimary) ?? .blue
        }
    }
    
}
