@testable import Data
import XCTest

final class SmoothieEndpointTests: XCTestCase {

    var sut: SmoothieEndpoint!
    
    override func setUp() {
        let network = NetworkHandler()
        sut = SmoothieEndpoint(host: "https://gxavier-smoothie-api.herokuapp.com", network: network)
    }
    
    func testSmoothieSync() async {
        let smoothies = try! await sut.start(title: "Breakfast super-shake")
        
        XCTAssertTrue(smoothies.count == 1)
    }

}
