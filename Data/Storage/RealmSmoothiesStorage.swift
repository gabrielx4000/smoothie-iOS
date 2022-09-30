import Domain
import Foundation
import RealmSwift

public class RealmSmoothiesStorage {
 
    private let realm: Realm?
    
    public init() {
        self.realm = try? Realm()
    }
    
    public func fetchSmoothies() -> [Smoothie] {
        guard let realm = realm else { return [] }
        
        return realm.objects(SmoothieRO.self).compactMap { $0.toDomain() }
    }
    
    public func save(smoothies: [Smoothie]) throws {
        try smoothies.forEach {
             try save(smoothie: $0)
        }
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
            smoothieRO.title = smoothie.title
            smoothieRO.url = smoothie.url
            smoothieRO.text = smoothie.description ?? ""
            smoothieRO.thumbnail = smoothie.thumbnail
            smoothieRO.prepTime = smoothie.prepTime ?? ""
            smoothieRO.skill = smoothie.skill ?? ""
            smoothieRO.servings = smoothie.servings ?? ""
            smoothieRO.rating = smoothie.rating
            
            smoothieRO.tags.removeAll()
            smoothieRO.tags.append(objectsIn: smoothie.tags)
            
            smoothieRO.ingredients.removeAll()
            
            if let ingredients = smoothie.ingredients {
                smoothieRO.ingredients.append(objectsIn: ingredients)
            }
            
            if let nutrition = smoothieRO.nutrition {
                realm.delete(nutrition)
            }
            if let nutrition = smoothie.nutrition {
                smoothieRO.nutrition = SmoothieNutritionRO(nutrition: nutrition)
            }
            
            smoothieRO.steps.forEach { realm.delete($0) }
            smoothieRO.steps.removeAll()
            if let steps = smoothie.steps {
                smoothieRO.steps.append(objectsIn: steps.compactMap { SmoothieStepRO(step: $0) })
            }
            
            smoothieRO.recommended.forEach { realm.delete($0) }
            smoothieRO.recommended.removeAll()
            if let recommended = smoothie.recommended {
                smoothieRO.recommended.append(objectsIn: recommended.compactMap { SmoothieRecommendedRO(recommended: $0) })
            }
            
            smoothieRO.tips.forEach { realm.delete($0) }
            smoothieRO.tips.removeAll()
            if let tips = smoothie.tips {
                smoothieRO.tips.append(objectsIn: tips.compactMap { SmoothieTipRO(tip: $0) })
            }
        }
    }
    
}
