import Domain
import Foundation
import RealmSwift

public class RealmFruitsStorage {
    
    private let realm: Realm?
    
    public init() {
        self.realm = try? Realm()
    }
    
    public func fetchFruits() -> [Fruit] {
        guard let realm = realm else { return [] }
        
        return realm.objects(FruitRO.self).compactMap { $0.toDomain() }
    }
    
    public func saveFruits(fruits: [Fruit]) throws {
        guard let realm = realm else { return }
        
        let fruitROs = fruits.compactMap { FruitRO(fruit: $0) }
        
        try realm.write {
            realm.add(fruitROs)
        }
    }
    
}
