import Combine
@testable import Domain
import Foundation

class FruitsRepositoryMock: FruitsRepositoryInterface {
    
    let subject: CurrentValueSubject<[Fruit], Error> = CurrentValueSubject([DomainTestsHelper.makeApple(), DomainTestsHelper.makeBanana()])
    
    func getPublisher() -> AnyPublisher<[Fruit], Error> {
        subject.eraseToAnyPublisher()
    }
    
}
