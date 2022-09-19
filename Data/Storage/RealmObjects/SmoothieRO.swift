import Domain
import Foundation
import RealmSwift

public enum SmoothieDifficultyRO: String, PersistableEnum {
    
    case easy, medium, hard
    
    public init(difficulty: SmoothieDifficulty) {
        switch difficulty {
        case .easy: self = .easy
        case .medium: self = .medium
        case .hard: self = .hard
        }
    }
    
}

public class SmoothieStepRO: EmbeddedObject {
    
    @Persisted public var number: Int
    
    @Persisted public var text: String
    
    override init() {
        super.init()
    }
    
    public init(step: SmoothieStep) {
        self.number = step.number
        self.text = step.text
    }
    
}

public class SmoothieIngredientRO: EmbeddedObject {
    
    @Persisted public var ingredient: IngredientRO?
    
    @Persisted public var unit: String
    
    @Persisted public var quantity: Double
    
    override init() {
        super.init()
    }
    
    public init(smoothieIngredient: SmoothieIngredient) {
        self.ingredient = IngredientRO(ingredient: smoothieIngredient.ingredient)
        self.unit = smoothieIngredient.unit
        self.quantity = smoothieIngredient.quantity
    }
    
}

public class SmoothieRO: Object {
    
    @Persisted public var ingredients = List<SmoothieIngredientRO>()
    
    @Persisted public var name: String
    
    @Persisted public var id: String
    
    @Persisted public var prepTime: Double
    
    @Persisted public var difficulty: SmoothieDifficultyRO
    
    @Persisted public var servings: Double
    
    @Persisted public var steps = List<SmoothieStepRO>()
    
    override init() {
        super.init()
    }
    
    public init(smoothie: Smoothie) {
        self.name = smoothie.name
        self.id = smoothie.id
        self.prepTime = smoothie.prepTime
        self.servings = smoothie.servings
        self.difficulty = SmoothieDifficultyRO(difficulty: smoothie.difficulty)
        
        super.init()
        
        self.steps.append(objectsIn: smoothie.steps.compactMap { SmoothieStepRO(step: $0) })
        self.ingredients.append(objectsIn: smoothie.ingredients.compactMap { SmoothieIngredientRO(smoothieIngredient: $0) })
    }
    
}

extension SmoothieRO {
    
    func toDomain() -> Smoothie {
        let ingredients = Array(ingredients).compactMap { $0.toDomain() }
        let steps = Array(steps).compactMap { $0.toDomain() }
        let difficulty = difficulty.toDomain()
        
        return Smoothie(ingredients: ingredients, name: name, id: id, prepTime: prepTime, difficulty: difficulty, servings: servings, steps: steps)
    }
    
}

extension SmoothieStepRO {
    
    func toDomain() -> SmoothieStep {
        return SmoothieStep(number: number, text: text)
    }
    
}

extension SmoothieDifficultyRO {
    
    func toDomain() -> SmoothieDifficulty {
        switch self {
        case .easy: return SmoothieDifficulty.easy
        case .medium: return SmoothieDifficulty.medium
        case .hard:  return SmoothieDifficulty.hard
        }
    }
    
}

extension SmoothieIngredientRO {
    
    func toDomain() -> SmoothieIngredient {
        let ingredient = self.ingredient ?? IngredientRO(id: "", name: "")
        
        return SmoothieIngredient(ingredient: ingredient.toDomain(), unit: unit, quantity: quantity)
    }
    
}
