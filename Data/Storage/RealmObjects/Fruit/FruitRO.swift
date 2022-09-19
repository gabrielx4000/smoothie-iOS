import Domain
import Foundation
import RealmSwift

public class FruitRO: Object {
    
    @Persisted public var id: Int
    
    @Persisted public var name: String
    
    @Persisted public var genus: String
    
    @Persisted public var family: String
    
    @Persisted public var order: String
    
    @Persisted public var nutrition: FruitNutritionRO?
    
    override init() {
        super.init()
    }
    
    public init(fruit: Fruit) {
        self.id = fruit.id
        self.name = fruit.name
        self.genus = fruit.genus
        self.family = fruit.family
        self.order = fruit.order
        self.nutrition = FruitNutritionRO(nutrition: fruit.nutrition)
    }
    
}

extension FruitRO {
    
    func toDomain() -> Fruit {
        let nutrition = nutrition ?? FruitNutritionRO(nutrition: Nutrition(carbohydrates: 0, protein: 0, fat: 0, calories: 0, sugar: 0))
        
        return Fruit(id: id, name: name, genus: genus, family: family, order: order, nutrition: nutrition.toDomain())
    }
    
}
