import Foundation

public struct Fruit {
    
    public var id: Int
    
    public var name: String
    
    public var genus: String
    
    public var family: String
    
    public var order: String
    
    public var nutrition: FruitNutrition
    
    public init(id: Int, name: String, genus: String, family: String, order: String, nutrition: FruitNutrition) {
        self.id = id
        self.name = name
        self.genus = genus
        self.family = family
        self.order = order
        self.nutrition = nutrition
    }
    
}

extension Fruit: Equatable {

    public static func == (lhs: Fruit, rhs: Fruit) -> Bool {
        return lhs.id == rhs.id
    }

}
