import Domain
import Foundation
import RealmSwift

public class SmoothieRO: Object {
    
    @Persisted public var title: String
    
    @Persisted public var url: String

    @Persisted public var thumbnail: String
    
    @Persisted public var rating: String
    
    @Persisted public var tags = List<String>()
    
    @Persisted public var isSynced: Bool = false
    
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
        self.text = smoothie.description
        self.thumbnail = smoothie.thumbnail
        self.prepTime = smoothie.prepTime
        self.skill = smoothie.skill
        self.servings = smoothie.servings
        self.rating = smoothie.rating
        self.tags.append(objectsIn: smoothie.tags)
        self.ingredients.append(objectsIn: smoothie.ingredients)
        self.nutrition = SmoothieNutritionRO(nutrition: smoothie.nutrition)
        self.steps.append(objectsIn: smoothie.steps.compactMap { SmoothieStepRO(step: $0) })
        self.recommended.append(objectsIn: smoothie.recommended.compactMap { SmoothieRecommendedRO(recommended: $0) })
        self.tips.append(objectsIn: smoothie.tips.compactMap { SmoothieTipRO(tip: $0) })
    }
    
    override init() {
        super.init()
    }
    
}

extension SmoothieRO {
    
    func toDomain() -> Smoothie {
        let nutrition = (nutrition ?? SmoothieNutritionRO.zero()).toDomain()
        
        let steps = Array(steps.compactMap { $0.toDomain() })
        
        let recommended = Array(recommended.compactMap { $0.toDomain() })
        
        let tips = Array(tips.compactMap { $0.toDomain() })
        
        return Smoothie(title: title, url: url, description: text, thumbnail: thumbnail, prepTime: prepTime, skill: skill, servings: servings, rating: rating, tags: Array(tags), ingredients: Array(ingredients), nutrition: nutrition, steps: steps, recommended: recommended, tips: tips)
    }
    
}
