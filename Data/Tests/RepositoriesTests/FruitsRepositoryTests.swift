@testable import Data
import RealmSwift
import XCTest

final class FruitsRepositoryTests: XCTestCase {

    var sut: FruitsRepository!
    var endpoint: MockFruitsEndpoint!
    var storage: MockFruitsStorage!
    
    override func setUp() {
        endpoint = MockFruitsEndpoint()
        storage = MockFruitsStorage()
        sut = FruitsRepository(endpoint: endpoint, storage: storage)
    }

    func testGetPublisherGivenStorageIsEmpty() {
        let expectation = expectation(description: "testGetPublisherGivenStorageIsEmpty")

        expectation.expectedFulfillmentCount = 2

        endpoint.values = [DataTestsHelper.makeAppleDTO()]
        
        var sinkCount = 0

        let cancellable = sut.getPublisher()
            .assertNoFailure()
            .sink { fruits in
                expectation.fulfill()
                if sinkCount == 0 {
                    XCTAssertEqual(0, fruits.count)
                } else {
                    XCTAssertEqual(1, fruits.count)
                }
                sinkCount += 1
            }

        wait(for: [expectation], timeout: 10)

        cancellable.cancel()
    }
    
    func testGetPublisherGivenStorageHasElements() {
        storage.values = [DataTestsHelper.makeBanana()]
        
        let expectation = expectation(description: "testGetPublisherGivenStorageHasElementsExpectation")

        expectation.expectedFulfillmentCount = 2

        endpoint.values = [DataTestsHelper.makeAppleDTO()]
        
        var sinkCount = 0

        let cancellable = sut.getPublisher()
            .assertNoFailure()
            .sink { fruits in
                expectation.fulfill()
                if sinkCount == 0 {
                    XCTAssertEqual(1, fruits.count)
                } else {
                    XCTAssertEqual(2, fruits.count)
                }
                sinkCount += 1
            }

        wait(for: [expectation], timeout: 10)

        cancellable.cancel()
    }

    func testGetPublisherGivenStorageHasSameElement() {
        storage.values = [DataTestsHelper.makeApple()]

        let expectation = expectation(description: "testGetPublisherGivenStorageHasSameElementExpectation")

        endpoint.values = [DataTestsHelper.makeAppleDTO()]
        
        let cancellable = sut.getPublisher()
            .assertNoFailure()
            .sink { fruits in
                expectation.fulfill()
                XCTAssertEqual(1, fruits.count)
            }

        wait(for: [expectation], timeout: 10)

        cancellable.cancel()
    }
    
}
