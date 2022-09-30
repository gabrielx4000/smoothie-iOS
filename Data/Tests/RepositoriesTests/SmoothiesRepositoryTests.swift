@testable import Data
import RealmSwift
import XCTest

final class SmoothiesRepositoryTests: XCTestCase {

    var sut: SmoothiesRepository!
    var smoothiesEndpoint: SmoothiesEndpointMock!
    var smoothieEndpoint: SmoothieEndpointMock!
    
    let realm = try! Realm()
    
    override func setUp() {
        smoothiesEndpoint = SmoothiesEndpointMock()
        smoothieEndpoint = SmoothieEndpointMock()
        sut = SmoothiesRepository(smoothiesEndpoint: smoothiesEndpoint, smoothieEndpoint: smoothieEndpoint, storage: RealmSmoothiesStorage())
    }

    override func tearDown() {
        try! realm.write {
            realm.deleteAll()
        }
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
        DispatchQueue.main.sync {
            try! realm.write {
                realm.add(SmoothieRO(smoothie: DataTestsHelper.makeShortBananaSmoothieDTO().toDomain()))
            }
        }
        
        smoothieEndpoint.values = [DataTestsHelper.makeBananaSmoothieDTO()]
        
        let smoothie = await sut.fetchSmoothie("Banana smoothie")
        
        XCTAssertEqual(smoothie.title, "Banana smoothie")
    }
    
    func testFetchSmoothieGivenStorageHasCompleteData() async {
        DispatchQueue.main.sync {
            try! realm.write {
                realm.add(SmoothieRO(smoothie: DataTestsHelper.makeBananaSmoothieDTO().toDomain()))
            }
        }
        
        smoothieEndpoint.values = [DataTestsHelper.makeBananaSmoothieDTO()]
        
        let smoothie = await sut.fetchSmoothie("Banana smoothie")
        
        XCTAssertEqual(smoothie.title, "Banana smoothie")
    }
    
}
