import Domain
import Foundation
import RealmSwift

public class SmoothieRO: Object {
    
    @Persisted public var title: String
    
    @Persisted public var url: String

    @Persisted public var thumbnail: String
    
    @Persisted public var rating: String
    
    @Persisted public var tags = List<String>()
    
    @Persisted public var text: String
    
    @Persisted public var prepTime: String
    
    @Persisted public var skill: String
    
    @Persisted public var servings: String
    
    @Persisted public var ingredients = List<String>()
    
    @Persisted public var nutrition: SmoothieNutritionRO?
    
    @Persisted public var steps = List<SmoothieStepRO>()
    
    @Persisted public var recommended = List<SmoothieRecommendedRO>()
    
    @Persisted public var tips = List<SmoothieTipRO>()
    
    public init(smoothie: Smoothie) {
        super.init()
        
        self.title = smoothie.title
        self.url = smoothie.url
        self.thumbnail = smoothie.thumbnail
        self.text = smoothie.description ?? ""
        self.prepTime = smoothie.prepTime ?? ""
        self.skill = smoothie.skill ?? ""
        self.servings = smoothie.servings ?? ""
        self.rating = String(smoothie.rating)
        self.tags.append(objectsIn: smoothie.tags)
        
        if let ingredients = smoothie.ingredients {
            self.ingredients.append(objectsIn: ingredients)
        }
        
        if let nutrition = smoothie.nutrition {
            self.nutrition = SmoothieNutritionRO(nutrition: nutrition)
        }
        
        if let steps = smoothie.steps {
            self.steps.append(objectsIn: steps.compactMap { SmoothieStepRO(step: $0) })
        }
        
        if let recommended = smoothie.recommended {
            self.recommended.append(objectsIn: recommended.compactMap { SmoothieRecommendedRO(recommended: $0) })
        }
        
        if let tips = smoothie.tips {
            self.tips.append(objectsIn: tips.compactMap { SmoothieTipRO(tip: $0) })
        }
    }
    
    override init() {
        super.init()
    }
    
}

extension SmoothieRO {
    
    func toDomain() -> Smoothie {
        let rating = Double(rating) ?? 0
        
        let nutrition = (nutrition ?? SmoothieNutritionRO.zero()).toDomain()
        
        let steps = Array(steps.compactMap { $0.toDomain() })
        
        let recommended = Array(recommended.compactMap { $0.toDomain() })
        
        let tips = Array(tips.compactMap { $0.toDomain() })
        
        return Smoothie(title: title, url: url, thumbnail: thumbnail, rating: rating, tags: Array(tags), description: text, prepTime: prepTime, skill: skill, servings: servings, ingredients: Array(ingredients), nutrition: nutrition, steps: steps, recommended: recommended, tips: tips)
    }
    
}
