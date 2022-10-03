@testable import Data
import RealmSwift
import XCTest

final class SmoothiesRepositoryTests: XCTestCase {

    var sut: SmoothiesRepository!
    var smoothiesEndpoint: MockSmoothiesEndpoint!
    var smoothieEndpoint: MockSmoothieEndpoint!
    var storage: MockSmoothiesStorage!
    
    override func setUp() {
        smoothiesEndpoint = MockSmoothiesEndpoint()
        smoothieEndpoint = MockSmoothieEndpoint()
        storage = MockSmoothiesStorage()
        
        sut = SmoothiesRepository(smoothiesEndpoint: smoothiesEndpoint, smoothieEndpoint: smoothieEndpoint, storage: storage)
    }
    
    func testGetPublisherGivenStorageIsEmpty() {
        let expectation = expectation(description: "testGetPublisherGivenStorageIsEmpty")
        
        expectation.expectedFulfillmentCount = 2
        
        var sinkCount = 0
        
        smoothiesEndpoint.values = [DataTestsHelper.makeShortBananaSmoothieDTO()]
        
        let cancellable = sut.getPublisher()
            .assertNoFailure()
            .sink { smoothies in
                expectation.fulfill()
                
                if sinkCount == 0 {
                    XCTAssertEqual(smoothies.count, 0)
                } else {
                    XCTAssertEqual(smoothies.count, 1)
                }
                
                sinkCount += 1
            }
        
        wait(for: [expectation], timeout: 10)
        
        cancellable.cancel()
    }
    
    func testFetchSmoothieGivenStorageIsEmpty() async {
        smoothieEndpoint.values = [DataTestsHelper.makeBananaSmoothieDTO()]
        
        let smoothie = await sut.fetchSmoothie("Banana smoothie")
        
        XCTAssertEqual(smoothie.title, "Banana smoothie")
    }
    
    func testFetchSmoothieGivenStorageHasData() async {
        storage.values = [DataTestsHelper.makeShortBananaSmoothieDTO().toDomain()]
        
        smoothieEndpoint.values = [DataTestsHelper.makeBananaSmoothieDTO()]
        
        let smoothie = await sut.fetchSmoothie("Banana smoothie")
        
        XCTAssertEqual(smoothie.title, "Banana smoothie")
    }
    
    func testFetchSmoothieGivenStorageHasCompleteData() async {
        storage.values = [DataTestsHelper.makeBananaSmoothieDTO().toDomain()]
        
        smoothieEndpoint.values = [DataTestsHelper.makeBananaSmoothieDTO()]
        
        let smoothie = await sut.fetchSmoothie("Banana smoothie")
        
        XCTAssertEqual(smoothie.title, "Banana smoothie")
    }
    
}
