@testable import Data
import RealmSwift
import XCTest

class FruitsEndpointMock: FruitsEndpointProtocol {
    
    var continuation: CheckedContinuation<[FruitDTO], Never>?
    
    func start() async throws -> [FruitDTO] {
        return await withCheckedContinuation { continuation in
            self.continuation = continuation
        }
    }
    
}

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
    
    func testGetPublisherGivenStorageHasElements() {
        let banana = DataTestsHelper.makeBananaRO()

        try! realm.write {
            realm.add(banana)
        }

        let expectation = expectation(description: "testGetPublisherGivenStorageHasElementsExpectation")

        expectation.expectedFulfillmentCount = 2

        var sinkCount = 0

        let cancellable = sut.getPublisher().sink { fruits in
            expectation.fulfill()
            if sinkCount == 0 {
                XCTAssertEqual(fruits.count, 1)
                self.endpoint.continuation?.resume(returning: [DataTestsHelper.makeAppleDTO()])
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

        let cancellable = sut.getPublisher().sink { fruits in
            expectation.fulfill()
            XCTAssertEqual(fruits.count, 1)
            self.endpoint.continuation?.resume(returning: [DataTestsHelper.makeAppleDTO()])
        }

        wait(for: [expectation], timeout: 10)

        cancellable.cancel()
    }
    
}
