import Foundation

extension Bundle {
    
    static var presentation: Bundle {
        return Bundle(identifier: "com.smoothie.Presentation") ?? .main
    }
    
}
