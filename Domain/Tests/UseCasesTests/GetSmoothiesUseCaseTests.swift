@testable import Domain
import XCTest

final class GetSmoothiesUseCaseTests: XCTestCase {

    var sut: GetSmoothiesUseCase!

    override func setUp() {
        sut = GetSmoothiesUseCase(repository: SmoothiesRepositoryMock())
    }
    
    func testStartGivenSuccess() {
        let expectation = expectation(description: "testStartGivenSuccess")
        
        let cancel = sut.start()
            .assertNoFailure()
            .sink { smoothies in
                XCTAssertEqual(smoothies, [DomainTestsHelper.makeBananaSmoothie()])
                expectation.fulfill()
            }
        
        wait(for: [expectation], timeout: 10)
        
        cancel.cancel()
    }
    
}
