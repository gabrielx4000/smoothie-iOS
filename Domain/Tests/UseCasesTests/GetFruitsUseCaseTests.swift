@testable import Domain
import XCTest

final class GetFruitsUseCaseTests: XCTestCase {

    var sut: GetFruitsUseCase!
    
    override func setUp() {
        sut = GetFruitsUseCase(repository: MockFruitsRepository())
    }
    
    func testStartGivenSuccess() {
        let expectation = expectation(description: "testStartGivenSuccess")
        
        let cancel = sut.start()
            .assertNoFailure()
            .sink { fruits in
                XCTAssertEqual(fruits, [DomainTestsHelper.makeApple(), DomainTestsHelper.makeBanana()])
                expectation.fulfill()
            }
        
        wait(for: [expectation], timeout: 10)
        
        cancel.cancel()
    }
    
}
