import Domain
import Foundation

public struct FruitDTO: Decodable {
    
    public var id: Int
    
    public var name: String
    
    public var genus: String
    
    public var family: String
    
    public var order: String
    
    public var nutrition: FruitNutritionDTO
    
    public init(id: Int, name: String, genus: String, family: String, order: String, nutrition: FruitNutritionDTO) {
        self.id = id
        self.name = name
        self.genus = genus
        self.family = family
        self.order = order
        self.nutrition = nutrition
    }
    
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
