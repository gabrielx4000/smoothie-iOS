@testable import Domain
import XCTest

final class GetSmoothieUseCaseTests: XCTestCase {

    var sut: GetSmoothieUseCase!
    
    override func setUp() {
        sut = GetSmoothieUseCase(repository: SmoothiesRepositoryMock())
    }

    func testStartGivenSuccess() async {
        let smoothie = try! await sut.start("Banana smoothie")
        
        XCTAssertEqual(smoothie, DomainTestsHelper.makeBananaSmoothie())
    }
    
}
