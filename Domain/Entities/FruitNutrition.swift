import Foundation

public struct FruitNutrition {
    
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
