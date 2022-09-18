public struct SmoothieStepDTO: Decodable {
    
    public var number: String
    
    public var text: String
    
}

public struct SmoothieRecommendedDTO: Decodable {
    
    public var title: String
    
    public var url: String
    
    public var image: String
    
}

public struct SmoothieNutritionDTO: Decodable {
    
    public var kcal: String
    
    public var fat: String
    
    public var saturates: String
    
    public var carbs: String
    
    public var sugars: String
    
    public var fibre: String
    
    public var protein: String
    
    public var salt: String
    
}

public struct SmoothieTipsDTO: Decodable {
    
    public var title: String
    
    public var text: String
    
}

public struct SmoothieDTO: Decodable {
 
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
    
    public var tips: [SmoothieTipsDTO]
    
}
