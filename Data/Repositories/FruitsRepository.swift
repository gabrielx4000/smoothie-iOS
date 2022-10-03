import Combine
import Domain
import Foundation

public class FruitsRepository: FruitsRepositoryInterface {
    
    private let endpoint: FruitsEndpointProtocol
    
    private let storage: FruitsStorageProtocol
    
    public init(endpoint: FruitsEndpointProtocol, storage: FruitsStorageProtocol) {
        self.endpoint = endpoint
        self.storage = storage
    }
    
    private lazy var subject: CurrentValueSubject<[Fruit], Error> = CurrentValueSubject<[Fruit], Error>(storage.fetchFruits())
    
    private lazy var publisher: AnyPublisher<[Fruit], Error> = subject.eraseToAnyPublisher()
    
    public func getPublisher() -> AnyPublisher<[Fruit], Error> {
        Task {
            var savedFruits = await self.fetchFruits()
            
            do {
                let syncedFruits = try await endpoint.start()
                
                let newFruits = syncedFruits.filter { syncedFruit in
                    return savedFruits.filter { savedFruit in
                        return savedFruit.id == syncedFruit.id
                    }.count == 0
                }.compactMap { $0.toDomain() }
                
                if newFruits.count == 0 {
                    self.subject.send(savedFruits)
                } else {
                    try await self.saveFruits(newFruits)
                    
                    savedFruits = await self.fetchFruits()
                    
                    self.subject.send(savedFruits)
                }
            } catch NetworkError.noInternet {
                guard savedFruits.count > 0 else {
                    self.subject.send(completion: .failure(NetworkError.noInternet))
                    return
                }
                self.subject.send(savedFruits)
            } catch {
                guard savedFruits.count > 0 else {
                    self.subject.send(completion: .failure(NetworkError.unknown))
                    return
                }
                self.subject.send(savedFruits)
            }
        }
        
        return publisher
    }
    
    private func fetchFruits() async -> [Fruit] {
        return await withCheckedContinuation { continuation in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                
                continuation.resume(returning: self.storage.fetchFruits())
            }
        }
    }
    
    private func saveFruits(_ fruits: [Fruit]) async throws {
        return try await withCheckedThrowingContinuation { continuation in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                
                do {
                    try self.storage.saveFruits(fruits: fruits)
                    
                    continuation.resume()
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
}
