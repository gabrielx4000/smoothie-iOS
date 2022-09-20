import Foundation

public struct Smoothie {
 
    public var title: String
    
    public var url: String

    public var description: String
    
    public var thumbnail: String
    
    public var prepTime: String
    
    public var skill: String
    
    public var servings: String
    
    public var rating: String
    
    public var tags: [String]
    
    public var ingredients: [String]
    
    public var nutrition: SmoothieNutrition
    
    public var steps: [SmoothieStep]
    
    public var recommended: [SmoothieRecommended]
    
    public var tips: [SmoothieTip]
    
    public init(title: String, url: String, description: String, thumbnail: String, prepTime: String, skill: String, servings: String, rating: String, tags: [String], ingredients: [String], nutrition: SmoothieNutrition, steps: [SmoothieStep], recommended: [SmoothieRecommended], tips: [SmoothieTip]) {
        self.title = title
        self.url = url
        self.description = description
        self.thumbnail = thumbnail
        self.prepTime = prepTime
        self.skill = skill
        self.servings = servings
        self.rating = rating
        self.tags = tags
        self.ingredients = ingredients
        self.nutrition = nutrition
        self.steps = steps
        self.recommended = recommended
        self.tips = tips
    }
    
}
