import Combine
@testable import Domain
import Foundation

class MockFruitsRepository: FruitsRepositoryInterface {
    
    var values = [DomainTestsHelper.makeBanana(), DomainTestsHelper.makeApple()]
    
    lazy var subject: CurrentValueSubject<[Fruit], Error> = CurrentValueSubject(values)
    
    func getPublisher() -> AnyPublisher<[Fruit], Error> {
        subject.eraseToAnyPublisher()
    }
    
}
