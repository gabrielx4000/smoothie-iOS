import Foundation

public struct Smoothie {
 
    public var title: String
    
    public var url: String

    public var thumbnail: String
    
    public var rating: String
    
    public var tags: [String]
    
    public var description: String?
    
    public var prepTime: String?
    
    public var skill: String?
    
    public var servings: String?
    
    public var ingredients: [String]?
    
    public var nutrition: SmoothieNutrition?
    
    public var steps: [SmoothieStep]?
    
    public var recommended: [SmoothieRecommended]?
    
    public var tips: [SmoothieTip]?
    
    public init(title: String, url: String, thumbnail: String, rating: String, tags: [String], description: String? = nil, prepTime: String? = nil, skill: String? = nil, servings: String? = nil, ingredients: [String]? = nil, nutrition: SmoothieNutrition? = nil, steps: [SmoothieStep]? = nil, recommended: [SmoothieRecommended]? = nil, tips: [SmoothieTip]? = nil) {
        self.title = title
        self.url = url
        self.thumbnail = thumbnail
        self.rating = rating
        self.tags = tags
        self.description = description
        self.prepTime = prepTime
        self.skill = skill
        self.servings = servings
        self.ingredients = ingredients
        self.nutrition = nutrition
        self.steps = steps
        self.recommended = recommended
        self.tips = tips
    }
    
}

extension Smoothie: Equatable {

    public static func == (lhs: Smoothie, rhs: Smoothie) -> Bool {
        return lhs.url == rhs.url
    }
    
}
