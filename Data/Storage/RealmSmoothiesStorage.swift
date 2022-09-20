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
        guard let realm = realm, let smoothieRO = realm.objects(SmoothieRO.self).where({ $0.url == smoothie.url }).first else { return }
        
        try realm.write {
            smoothieRO.isSynced = true
            
            smoothieRO.title = smoothie.title
            smoothieRO.url = smoothie.url
            smoothieRO.text = smoothie.description
            smoothieRO.thumbnail = smoothie.thumbnail
            smoothieRO.prepTime = smoothie.prepTime
            smoothieRO.skill = smoothie.skill
            smoothieRO.servings = smoothie.servings
            smoothieRO.rating = smoothie.rating
            
            smoothieRO.tags.removeAll()
            smoothieRO.tags.append(objectsIn: smoothie.tags)
            
            smoothieRO.ingredients.removeAll()
            smoothieRO.ingredients.append(objectsIn: smoothie.ingredients)
            
            if let nutrition = smoothieRO.nutrition {
                realm.delete(nutrition)
            }
            smoothieRO.nutrition = SmoothieNutritionRO(nutrition: smoothie.nutrition)
            
            smoothieRO.steps.forEach { realm.delete($0) }
            smoothieRO.steps.removeAll()
            smoothieRO.steps.append(objectsIn: smoothie.steps.compactMap { SmoothieStepRO(step: $0) })
            
            smoothieRO.recommended.forEach { realm.delete($0) }
            smoothieRO.recommended.removeAll()
            smoothieRO.recommended.append(objectsIn: smoothie.recommended.compactMap { SmoothieRecommendedRO(recommended: $0) })
            
            smoothieRO.tips.forEach { realm.delete($0) }
            smoothieRO.tips.removeAll()
            smoothieRO.tips.append(objectsIn: smoothie.tips.compactMap { SmoothieTipRO(tip: $0) })
        }
    }
    
}
