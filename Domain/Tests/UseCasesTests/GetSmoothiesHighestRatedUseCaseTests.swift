@testable import Domain
import XCTest

final class GetSmoothiesHighestRatedUseCaseTests: XCTestCase {

    var sut: GetSmoothiesHighestRatedUseCase!
    var repository: MockSmoothiesRepository!
    
    override func setUp() {
        repository = MockSmoothiesRepository()
        sut = GetSmoothiesHighestRatedUseCase(repository: repository)
    }

    func testStartGivenCountZero() {
        let expectation = expectation(description: "testStartGivenCountZero")
        
        repository.values = [DomainTestsHelper.makeBananaSmoothie(), DomainTestsHelper.makeAcaiSmoothie()]
        
        let cancellable = sut.start(0)
            .assertNoFailure()
            .sink { smoothies in
                expectation.fulfill()
                XCTAssertEqual([DomainTestsHelper.makeAcaiSmoothie(), DomainTestsHelper.makeBananaSmoothie()], smoothies)
            }
        
        wait(for: [expectation], timeout: 10)
        
        cancellable.cancel()
    }
    
    func testStartGivenCountOne() {
        let expectation = expectation(description: "testStartGivenCountOne")
        
        repository.values = [DomainTestsHelper.makeBananaSmoothie(), DomainTestsHelper.makeAcaiSmoothie()]
        
        let cancellable = sut.start(1)
            .assertNoFailure()
            .sink { smoothies in
                expectation.fulfill()
                XCTAssertEqual([DomainTestsHelper.makeAcaiSmoothie()], smoothies)
            }
        
        wait(for: [expectation], timeout: 10)
        
        cancellable.cancel()
    }
}
