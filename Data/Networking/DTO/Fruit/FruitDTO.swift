import Domain
import Foundation

public struct FruitDTO: Decodable {
    
    public var id: Int
    
    public var name: String
    
    public var genus: String
    
    public var family: String
    
    public var order: String
    
    public var nutrition: FruitNutritionDTO
    
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
