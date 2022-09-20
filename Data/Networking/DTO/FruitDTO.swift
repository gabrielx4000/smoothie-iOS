import Domain
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

extension FruitDTO {
    
    public func toDomain() -> Fruit {
        return Fruit(id: id, name: name, genus: genus, family: family, order: order, nutrition: nutrition.toDomain())
    }
    
}

extension NutritionDTO {
    
    public func toDomain() -> FruitNutrition {
        return FruitNutrition(carbohydrates: carbohydrates, protein: protein, fat: fat, calories: calories, sugar: sugar)
    }
    
}
