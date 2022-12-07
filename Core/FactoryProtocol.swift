import Foundation
import Swinject

protocol FactoryProtocol {
    var container: Container { get }
    func register()
}
