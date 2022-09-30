@testable import Domain
import XCTest

final class GetSmoothieTagsUseCaseTests: XCTestCase {

    var sut: GetSmoothieTagsUseCase!
    let repository = SmoothiesRepositoryMock()
    
    override func setUp() {
        sut = GetSmoothieTagsUseCase(repository: repository)
    }
    
    func testStartGivenSuccess() {
        let expectation = expectation(description: "testStartGivenSuccess")
        
        repository.values = [
            DomainTestsHelper.makeAcaiSmoothie(),
            DomainTestsHelper.makeBananaSmoothie()
        ]
        
        let cancel = sut.start()
            .assertNoFailure()
            .sink { tags in
                expectation.fulfill()
                
                XCTAssertEqual(["freezable", "gluten-free", "healthy", "vegan", "vegetarian"], tags)
            }
        
        wait(for: [expectation], timeout: 10)
        
        cancel.cancel()
    }
    
}
