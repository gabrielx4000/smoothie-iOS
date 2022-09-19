@testable import Data
import XCTest

final class SmoothiesEndpointTests: XCTestCase {

    var sut: SmoothiesEndpoint!
    
    override func setUp() {
        let network = NetworkHandler()
        sut = SmoothiesEndpoint(host: "https://gxavier-smoothie-api.herokuapp.com/", network: network)
    }
    
    func testSmoothiesSync() async {
        let smoothies = try! await sut.start()
        
        XCTAssertTrue(smoothies.count > 0)
    }

}
