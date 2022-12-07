import Domain
import Foundation

public protocol FruitsFactoryPresentationProtocol {
    func createFruitsViewModel() -> FruitsViewModel
    func createGetFruitsUseCase() -> GetFruitsUseCaseProtocol
}
