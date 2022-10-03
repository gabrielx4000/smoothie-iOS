@testable import Data
import Foundation

class MockSmoothiesEndpoint: SmoothiesEndpointProtocol {
    
    var values = [SmoothieShortDTO]()
    
    func start() async throws -> [SmoothieShortDTO] {
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
