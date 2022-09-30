import Domain
import Foundation

struct DomainTestsHelper {
    
    static func makeApple() -> Fruit {
        let nutrition = FruitNutrition(
            carbohydrates: 11.4,
            protein: 0.3, fat: 0.4,
            calories: 52,
            sugar: 10.3
        )
        
        return Fruit(
            id: 6,
            name: "Apple",
            genus: "Malus",
            family: "Rosaceae",
            order: "Rosales",
            nutrition: nutrition
        )
    }
    
    static func makeBanana() -> Fruit {
        let nutrition = FruitNutrition(
            carbohydrates: 22,
            protein: 1,
            fat: 0.2,
            calories: 96,
            sugar: 17.2
        )
        
        return Fruit(
            id: 1,
            name: "Banana",
            genus: "Musa",
            family: "Musaceae",
            order: "Zingiberales",
            nutrition: nutrition
        )
    }
    
    static func makeBananaSmoothie() -> Smoothie {
        return Smoothie(
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
    
}
