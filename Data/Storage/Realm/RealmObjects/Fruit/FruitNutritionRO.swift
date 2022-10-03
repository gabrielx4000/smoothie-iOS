import Domain
import Foundation
import RealmSwift

public class FruitNutritionRO: EmbeddedObject {
    
    @Persisted public var carbohydrates: Double
    
    @Persisted public var protein: Double
    
    @Persisted public var fat: Double
    
    @Persisted public var calories: Double
    
    @Persisted public var sugar: Double
    
    override init() {
        super.init()
    }
    
    public init(nutrition: FruitNutrition) {
        self.carbohydrates = nutrition.carbohydrates
        self.protein = nutrition.protein
        self.fat = nutrition.fat
        self.calories = nutrition.calories
        self.sugar = nutrition.sugar
    }
    
}

extension FruitNutritionRO {
    
    func toDomain() -> FruitNutrition {
        return FruitNutrition(carbohydrates: carbohydrates, protein: protein, fat: fat, calories: calories, sugar: sugar)
    }
    
}
