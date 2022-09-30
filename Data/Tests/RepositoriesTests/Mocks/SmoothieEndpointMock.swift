@testable import Data
import Foundation

class SmoothieEndpointMock: SmoothieEndpointProtocol {
    
    var values = [SmoothieCompleteDTO]()
    
    func start(title: String) async throws -> [SmoothieCompleteDTO] {
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
