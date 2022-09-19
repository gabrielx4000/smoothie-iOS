public struct SmoothieStep {
    
    public var number: String
    
    public var text: String
    
    public init(number: String, text: String) {
        self.number = number
        self.text = text
    }
    
}

public struct SmoothieRecommended {
    
    public var title: String
    
    public var url: String
    
    public var image: String
    
    public init(title: String, url: String, image: String) {
        self.title = title
        self.url = url
        self.image = image
    }
    
}

public struct SmoothieNutrition {
    
    public var kcal: String
    
    public var fat: String
    
    public var saturates: String
    
    public var carbs: String
    
    public var sugars: String
    
    public var fibre: String
    
    public var protein: String
    
    public var salt: String
    
    public init(kcal: String, fat: String, saturates: String, carbs: String, sugars: String, fibre: String, protein: String, salt: String) {
        self.kcal = kcal
        self.fat = fat
        self.saturates = saturates
        self.carbs = carbs
        self.sugars = sugars
        self.fibre = fibre
        self.protein = protein
        self.salt = salt
    }
    
}

public struct SmoothieTips {
    
    public var title: String
    
    public var text: String
    
    public init(title: String, text: String) {
        self.title = title
        self.text = text
    }
    
}

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
    
    public var tips: [SmoothieTips]
    
    public init(title: String, url: String, description: String, thumbnail: String, prepTime: String, skill: String, servings: String, rating: String, tags: [String], ingredients: [String], nutrition: SmoothieNutrition, steps: [SmoothieStep], recommended: [SmoothieRecommended], tips: [SmoothieTips]) {
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
