import Combine
import Foundation

protocol GetSmoothieTagsUseCaseProtocol {
    
    func start() -> AnyPublisher<[String], Error>
    
}

public class GetSmoothieTagsUseCase: GetSmoothieTagsUseCaseProtocol {
    
    private let repository: SmoothiesRepositoryInterface
    
    public init(repository: SmoothiesRepositoryInterface) {
        self.repository = repository
    }
    
    func start() -> AnyPublisher<[String], Error> {
        return repository
            .getPublisher()
            .compactMap { smoothies in
                smoothies.compactMap { $0.tags }
            }
            .scan([String](), { partialResult, value in
                let reducedValues = value.reduce([String]()) { reducedResult, reducedValue in
                    var array = reducedResult
                    reducedValue.forEach { array.append($0) }
                    
                    return array
                }
                
                var scannedResult = partialResult
                
                reducedValues.forEach { reducedValue in
                    guard !scannedResult.contains(reducedValue) else { return }
                    
                    scannedResult.append(reducedValue)
                }
                
                return scannedResult
            })
            .map { tags in
                tags.sorted(by: { $0.caseInsensitiveCompare($1) == .orderedAscending })
            }
            .eraseToAnyPublisher()
    }
}
