import Domain
import Foundation

public struct FruitNutritionDTO: Decodable {
    
    public var carbohydrates: Double
    
    public var protein: Double
    
    public var fat: Double
    
    public var calories: Double
    
    public var sugar: Double
    
    public init(carbohydrates: Double, protein: Double, fat: Double, calories: Double, sugar: Double) {
        self.carbohydrates = carbohydrates
        self.protein = protein
        self.fat = fat
        self.calories = calories
        self.sugar = sugar
    }
    
}

extension FruitNutritionDTO {
    
    public func toDomain() -> FruitNutrition {
        return FruitNutrition(carbohydrates: carbohydrates, protein: protein, fat: fat, calories: calories, sugar: sugar)
    }
    
}
