@testable import Data
import RealmSwift
import XCTest

final class FruitsRepositoryTests: XCTestCase {

    var sut: FruitsRepository!
    var endpoint: FruitsEndpointMock!
    let realm = try! Realm()
    
    override func setUp() {
        endpoint = FruitsEndpointMock()
        sut = FruitsRepository(endpoint: endpoint, storage: RealmFruitsStorage())
    }

    override func tearDown() {
        try! realm.write {
            realm.deleteAll()
        }
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
                    XCTAssertEqual(fruits.count, 0)
                } else {
                    XCTAssertEqual(fruits.count, 1)
                }
                sinkCount += 1
            }

        wait(for: [expectation], timeout: 10)

        cancellable.cancel()
    }
    
    func testGetPublisherGivenStorageHasElements() {
        let banana = DataTestsHelper.makeBananaRO()

        try! realm.write {
            realm.add(banana)
        }

        let expectation = expectation(description: "testGetPublisherGivenStorageHasElementsExpectation")

        expectation.expectedFulfillmentCount = 2

        endpoint.values = [DataTestsHelper.makeAppleDTO()]
        
        var sinkCount = 0

        let cancellable = sut.getPublisher()
            .assertNoFailure()
            .sink { fruits in
                expectation.fulfill()
                if sinkCount == 0 {
                    XCTAssertEqual(fruits.count, 1)
                } else {
                    XCTAssertEqual(fruits.count, 2)
                }
                sinkCount += 1
            }

        wait(for: [expectation], timeout: 10)

        cancellable.cancel()
    }

    func testGetPublisherGivenStorageHasSameElement() {
        let apple = DataTestsHelper.makeAppleRO()

        try! realm.write {
            realm.add(apple)
        }

        let expectation = expectation(description: "testGetPublisherGivenStorageHasSameElementExpectation")

        endpoint.values = [DataTestsHelper.makeAppleDTO()]
        
        let cancellable = sut.getPublisher()
            .assertNoFailure()
            .sink { fruits in
                expectation.fulfill()
                XCTAssertEqual(fruits.count, 1)
            }

        wait(for: [expectation], timeout: 10)

        cancellable.cancel()
    }
    
}
