import Foundation

public struct SmoothieNutrition {
    
    public var kcal: String
    
    public var fat: String
    
    public var saturates: String
    
    public var carbs: String
    
    public var sugars: String
    
    public var fibre: String
    
    public var protein: String
    
    public var salt: String
    
    public init(kcal: String, fat: String, saturates: String, carbs: String, sugars: String, fibre: String, protein: String, salt: String) {
        self.kcal = kcal
        self.fat = fat
        self.saturates = saturates
        self.carbs = carbs
        self.sugars = sugars
        self.fibre = fibre
        self.protein = protein
        self.salt = salt
    }
    
}
