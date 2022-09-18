@testable import Data
import XCTest

final class NetworkHandlerTests: XCTestCase {

    var sut: FruitsEndpoint!
    
    override func setUp() {
        let network = NetworkHandler()
        sut = FruitsEndpoint(host: "https://www.fruityvice.com/api/", network: network)
    }
    
    func testFruitSync() async {
        let fruits = try! await sut.start()
        
        XCTAssertTrue(fruits.count > 0)
    }

}
