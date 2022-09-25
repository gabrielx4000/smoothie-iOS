import Combine
import Domain
import Foundation

public class FruitsRepository: FruitsRepositoryInterface {
    
    private let endpoint: FruitsEndpointProtocol
    
    private let storage: RealmFruitsStorage
    
    public init(endpoint: FruitsEndpointProtocol, storage: RealmFruitsStorage) {
        self.endpoint = endpoint
        self.storage = storage
    }
    
    private lazy var subject: CurrentValueSubject<[Fruit], Never> = CurrentValueSubject<[Fruit], Never>(storage.fetchFruits())
    
    private lazy var publisher: AnyPublisher<[Fruit], Never> = subject.eraseToAnyPublisher()
    
    public func getPublisher() -> AnyPublisher<[Fruit], Never> {
        Task {
            do {
                let syncedFruits = try await endpoint.start()
                
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    
                    var savedFruits = self.storage.fetchFruits()
                    
                    let newFruits = syncedFruits.filter { syncedFruit in
                        return savedFruits.filter { savedFruit in
                            return savedFruit.id == syncedFruit.id
                        }.count == 0
                    }.compactMap { $0.toDomain() }
                    
                    if newFruits.count > 0 {
                        do {
                            try self.storage.saveFruits(fruits: newFruits)
                            
                            savedFruits = self.storage.fetchFruits()
                            
                            self.subject.send(savedFruits)
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        
        return publisher
    }
    
}
