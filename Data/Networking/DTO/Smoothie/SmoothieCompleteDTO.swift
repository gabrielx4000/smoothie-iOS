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
    
}
