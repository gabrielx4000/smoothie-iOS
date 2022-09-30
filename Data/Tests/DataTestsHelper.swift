import Data
import Domain
import Foundation

struct DataTestsHelper {
    
    static func makeApple() -> Fruit {
        let nutrition = FruitNutrition(carbohydrates: 11.4, protein: 0.3, fat: 0.4, calories: 52, sugar: 10.3)
        return Fruit(id: 6, name: "Apple", genus: "Malus", family: "Rosaceae", order: "Rosales", nutrition: nutrition)
    }
    
    static func makeBanana() -> Fruit {
        let nutrition = FruitNutrition(carbohydrates: 22, protein: 1, fat: 0.2, calories: 96, sugar: 17.2)
        return Fruit(id: 1, name: "Banana", genus: "Musa", family: "Musaceae", order: "Zingiberales", nutrition: nutrition)
    }
    
    static func makeBananaRO() -> FruitRO {
        return FruitRO(fruit: makeBanana())
    }
    
    static func makeAppleRO() -> FruitRO {
        return FruitRO(fruit: makeApple())
    }
    
    static func makeAppleDTO() -> FruitDTO {
        let apple = makeApple()
        let nutrition = FruitNutritionDTO(carbohydrates: apple.nutrition.carbohydrates, protein: apple.nutrition.protein, fat: apple.nutrition.fat, calories: apple.nutrition.calories, sugar: apple.nutrition.sugar)
        
        return FruitDTO(id: apple.id, name: apple.name, genus: apple.genus, family: apple.family, order: apple.order, nutrition: nutrition)
    }
    
    static func makeShortBananaSmoothieDTO() -> SmoothieShortDTO {
        return SmoothieShortDTO(
            title: "Banana smoothie",
            url: "https://www.bbcgoodfood.com/recipes/afternoon-pick-me-smoothie",
            thumbnail: "https://images.immediate.co.uk/production/volatile/sites/30/2020/08/afternoon-pick-me-up-smoothie-506a768.jpg",
            rating: "4.2",
            tags: [
                "freezable",
                "gluten-free"
            ]
        )
    }
    
    static func makeBananaSmoothieDTO() -> SmoothieCompleteDTO {
        return SmoothieCompleteDTO(
            title: "Banana smoothie",
            url: "https://www.bbcgoodfood.com/recipes/afternoon-pick-me-smoothie",
            description: "Quick and easy to make, this banana, prune, almond milk and nut butter smoothie is an ideal on-the-go energy boost",
            thumbnail: "https://images.immediate.co.uk/production/volatile/sites/30/2020/08/afternoon-pick-me-up-smoothie-506a768.jpg",
            prepTime: "5 mins",
            skill: "easy",
            servings: "2 (700ml)",
            rating: "4.2",
            tags: [
                "freezable",
                "gluten-free"
            ],
            ingredients: [
                "500ml unsweetened almond milk",
                "2 tbsp almond butter",
                "6 prunes",
                "1 tsp cinnamon",
                "1 small ripe banana"
            ],
            nutrition: SmoothieNutritionDTO(
                kcal: "250",
                fat: "11g",
                saturates: "1g",
                carbs: "29g",
                sugars: "22g",
                fibre: "5g",
                protein: "5g",
                salt: "0.3g"
            ),
            steps: [
                SmoothieStepDTO(
                    number: "1",
                    text: "In a blender, whizz the almond milk with the almond butter, prunes, cinnamon and banana."
                ),
                SmoothieStepDTO(
                    number: "2",
                    text: "Transfer to 2 bottles and chill until ready to drink, or pack for lunch on the go. The smoothies will keep in the fridge for 2 days."
                )
            ],
            recommended: [
                SmoothieRecommendedDTO(
                    title: "Coconut & banana smoothie",
                    url: "https://www.bbcgoodfood.com/recipes/immune-boosting-smoothie",
                    image: "https://images.immediate.co.uk/production/volatile/sites/30/2020/08/cropped-immune-boosting-smoothie-6c125e6.jpg"
                ),
                SmoothieRecommendedDTO(
                    title: "Blueberry & banana power smoothie",
                    url: "https://www.bbcgoodfood.com/recipes/blueberry-banana-power-smoothie",
                    image: "https://images.immediate.co.uk/production/volatile/sites/30/2020/08/blueberry-banana-power-smoothie-5c9475a.jpg"
                ),
                SmoothieRecommendedDTO(
                    title: "Peanut butter smoothie",
                    url: "https://www.bbcgoodfood.com/recipes/peanut-butter-smoothie",
                    image: "https://images.immediate.co.uk/production/volatile/sites/30/2021/05/Peanut-Butter-Smoothie-3430e32.jpg"
                ),
                SmoothieRecommendedDTO(
                    title: "Watermelon smoothie",
                    url: "https://www.bbcgoodfood.com/recipes/watermelon-smoothie",
                    image: "https://images.immediate.co.uk/production/volatile/sites/30/2021/04/Watermelon-Smoothie-99503bb.jpg"
                )
            ],
            tips: [SmoothieTipDTO]()
        )
    }
}
