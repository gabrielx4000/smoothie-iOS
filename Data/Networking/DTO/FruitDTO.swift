import Foundation

public struct NutritionDTO: Decodable {
    
    public var carbohydrates: Double
    
    public var protein: Double
    
    public var fat: Double
    
    public var calories: Double
    
    public var sugar: Double
    
}

public struct FruitDTO: Decodable {
    
    public var id: Int
    
    public var name: String
    
    public var genus: String
    
    public var family: String
    
    public var order: String
    
    public var nutrition: NutritionDTO
    
    enum CodingKeys: String, CodingKey {
        case id, name, genus, family, order
        case nutrition = "nutritions"
    }
    
}
