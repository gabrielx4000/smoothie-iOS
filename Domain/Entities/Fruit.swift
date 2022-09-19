import Foundation

public struct Nutrition {
    
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

public struct Fruit {
    
    public var id: Int
    
    public var name: String
    
    public var genus: String
    
    public var family: String
    
    public var order: String
    
    public var nutrition: Nutrition
    
    public init(id: Int, name: String, genus: String, family: String, order: String, nutrition: Nutrition) {
        self.id = id
        self.name = name
        self.genus = genus
        self.family = family
        self.order = order
        self.nutrition = nutrition
    }
    
}
