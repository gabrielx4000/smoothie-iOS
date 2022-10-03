import Domain
import Foundation
import RealmSwift

public class SmoothieNutritionRO: EmbeddedObject {
    
    @Persisted public var kcal: String
    
    @Persisted public var fat: String
    
    @Persisted public var saturates: String
    
    @Persisted public var carbs: String
    
    @Persisted public var sugars: String
    
    @Persisted public var fibre: String
    
    @Persisted public var protein: String
    
    @Persisted public var salt: String
    
    public init(nutrition: SmoothieNutrition) {
        self.kcal = nutrition.kcal
        self.fat = nutrition.fat
        self.saturates = nutrition.saturates
        self.carbs = nutrition.carbs
        self.sugars = nutrition.sugars
        self.fibre = nutrition.fibre
        self.protein = nutrition.protein
        self.salt = nutrition.salt
    }
    
    override init() {
        super.init()
    }
    
}

extension SmoothieNutritionRO {
    
    func toDomain() -> SmoothieNutrition {
        return SmoothieNutrition(kcal: kcal, fat: fat, saturates: saturates, carbs: carbs, sugars: sugars, fibre: fibre, protein: protein, salt: salt)
    }
    
    static func zero() -> SmoothieNutritionRO {
        return SmoothieNutritionRO(nutrition: SmoothieNutrition(kcal: "0", fat: "0", saturates: "0", carbs: "0", sugars: "0", fibre: "0", protein: "0", salt: "0"))
    }
    
}
