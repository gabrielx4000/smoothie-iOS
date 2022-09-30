import Combine
import Domain
import Foundation

class SmoothiesRepositoryMock: SmoothiesRepositoryInterface {
    
    lazy var subject: CurrentValueSubject<[Smoothie], Error> = CurrentValueSubject([DomainTestsHelper.makeBananaSmoothie()])
    
    func getPublisher() -> AnyPublisher<[Smoothie], Error> {
        return subject.eraseToAnyPublisher()
    }
    
    func fetchSmoothie(_ title: String) async -> Smoothie {
        return await withCheckedContinuation { continuation in
            DispatchQueue.main.async {
                Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { timer in
                    timer.invalidate()
                    continuation.resume(returning: DomainTestsHelper.makeBananaSmoothie())
                }
            }
        }
    }
    
}
