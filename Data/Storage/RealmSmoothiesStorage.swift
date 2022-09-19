import Domain
import Foundation
import RealmSwift

public class RealmSmoothiesStorage {
 
    private let realm: Realm?
    
    public init() {
        self.realm = try? Realm()
    }
    
    public func fetchSmoothie() -> [Smoothie] {
        guard let realm = realm else { return [] }
        
        return realm.objects(SmoothieRO.self).compactMap { $0.toDomain() }
    }
    
    public func save(smoothie: Smoothie) throws {
        guard let realm = realm else { return }
        
        let smoothieRO = SmoothieRO(smoothie: smoothie)
        
        try realm.write {
            realm.add(smoothieRO)
        }
    }
    
    public func update(smoothie: Smoothie) throws {
        guard let realm = realm, let smoothieRO = realm.objects(SmoothieRO.self).where({ $0.id == smoothie.id }).first else { return }
        
        try realm.write {
            smoothieRO.name = smoothie.name
            smoothieRO.prepTime = smoothie.prepTime
            smoothieRO.difficulty = SmoothieDifficultyRO(difficulty: smoothie.difficulty)
            smoothieRO.servings = smoothie.servings
            
            smoothieRO.ingredients.forEach { realm.delete($0) }
            smoothieRO.ingredients.removeAll()
            smoothieRO.ingredients.append(objectsIn: smoothie.ingredients.compactMap { SmoothieIngredientRO(smoothieIngredient: $0) })
            
            smoothieRO.steps.forEach { realm.delete($0) }
            smoothieRO.steps.removeAll()
            smoothieRO.steps.append(objectsIn: smoothie.steps.compactMap { SmoothieStepRO(step: $0) })
        }
    }
    
}
