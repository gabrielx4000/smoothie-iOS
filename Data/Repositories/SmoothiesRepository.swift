import Combine
import Domain
import Foundation

public class SmoothiesRepository: SmoothiesRepositoryInterface {
    
    private let smoothiesEndpoint: SmoothiesEndpointProtocol
    
    private let smoothieEndpoint: SmoothieEndpointProtocol
    
    private let storage: RealmSmoothiesStorage
    
    private lazy var subject: CurrentValueSubject<[Smoothie], Error> = CurrentValueSubject<[Smoothie], Error>(storage.fetchSmoothies())
    
    private lazy var publisher: AnyPublisher<[Smoothie], Error> = subject.eraseToAnyPublisher()
    
    public init(smoothiesEndpoint: SmoothiesEndpointProtocol, smoothieEndpoint: SmoothieEndpointProtocol, storage: RealmSmoothiesStorage) {
        self.smoothieEndpoint = smoothieEndpoint
        self.smoothiesEndpoint = smoothiesEndpoint
        self.storage = storage
    }
    
    public func getPublisher() -> AnyPublisher<[Smoothie], Error> {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            var smoothies = self.storage.fetchSmoothies()
            
            if smoothies.count > 0 {
                self.subject.send(smoothies)
            } else {
                Task {
                    do {
                        let smoothiesDTO = try await self.smoothiesEndpoint.start()
                        
                        smoothies = smoothiesDTO.map { $0.toDomain() }
                        
                        try self.storage.save(smoothies: smoothies)
                        
                        self.subject.send(smoothies)
                    } catch {
                        self.subject.send(completion: .failure(error))
                    }
                }
            }
        }
        
        return publisher
    }
    
    public func fetchSmoothie(_ title: String) async -> Smoothie {
        return await withCheckedContinuation { continuation in
            Task {
                let smoothie = await fetchStoredSmoothie(title)
                if let smoothie,
                   let description = smoothie.description,
                   !description.isEmpty {
                    continuation.resume(returning: smoothie)
                    return
                }
                do {
                    guard let completeSmoothieDTO = try await self.smoothieEndpoint.start(title: title).first else { return }
                    
                    let completeSmoothie = completeSmoothieDTO.toDomain()
                    
                    if let _ = smoothie {
                        try await self.updateSmoothie(smoothie: completeSmoothie)
                    } else {
                        try await self.storeSmoothie(smoothie: completeSmoothie)
                    }
                    
                    continuation.resume(returning: completeSmoothie)
                } catch {
                    self.subject.send(completion: .failure(error))
                }
            }
        }
    }
    
    private func fetchStoredSmoothie(_ title: String) async -> Smoothie? {
        return await withCheckedContinuation { continuation in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {
                    continuation.resume(returning: nil)
                    return
                }
                
                let smoothie = self.storage.fetchSmoothies().first(where: { $0.title == title })
                continuation.resume(returning: smoothie)
            }
        }
    }
    
    private func storeSmoothie(smoothie: Smoothie) async throws {
        return try await withCheckedThrowingContinuation { continuation in
            DispatchQueue.main.async { [weak self] in
                do {
                    guard let self = self else {
                        continuation.resume()
                        return }
                    
                    try self.storage.save(smoothie: smoothie)
                    
                    continuation.resume()
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    private func updateSmoothie(smoothie: Smoothie) async throws {
        return try await withCheckedThrowingContinuation { continuation in
            DispatchQueue.main.async { [weak self] in
                do {
                    guard let self = self else {
                        continuation.resume()
                        return }
                    
                    try self.storage.update(smoothie: smoothie)
                    
                    continuation.resume()
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }

}
