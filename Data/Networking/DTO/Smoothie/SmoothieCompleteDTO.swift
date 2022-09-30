import Domain
import Foundation

public struct SmoothieCompleteDTO: Decodable {
 
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
    
    public var nutrition: SmoothieNutritionDTO
    
    public var steps: [SmoothieStepDTO]
    
    public var recommended: [SmoothieRecommendedDTO]
    
    public var tips: [SmoothieTipDTO]
    
    public init(title: String, url: String, description: String, thumbnail: String, prepTime: String, skill: String, servings: String, rating: String, tags: [String], ingredients: [String], nutrition: SmoothieNutritionDTO, steps: [SmoothieStepDTO], recommended: [SmoothieRecommendedDTO], tips: [SmoothieTipDTO]) {
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

extension SmoothieCompleteDTO {
    
    func toDomain() -> Smoothie {
        return Smoothie(
            title: title,
            url: url,
            thumbnail: thumbnail,
            rating: rating,
            tags: tags,
            description: description,
            prepTime: prepTime,
            skill: skill,
            servings: servings,
            ingredients: ingredients,
            nutrition: nutrition.toDomain(),
            steps: steps.map { $0.toDomain() },
            recommended: recommended.map { $0.toDomain() },
            tips: tips.map { $0.toDomain() }
        )
    }
    
}
