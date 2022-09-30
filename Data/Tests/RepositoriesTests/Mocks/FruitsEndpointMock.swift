@testable import Data
import Foundation

class FruitsEndpointMock: FruitsEndpointProtocol {
    
    var values = [FruitDTO]()
    
    func start() async throws -> [FruitDTO] {
        return await withCheckedContinuation { continuation in
            DispatchQueue.main.async {
                Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { timer in
                    timer.invalidate()
                    continuation.resume(returning: self.values)
                }
            }
        }
    }
    
}
