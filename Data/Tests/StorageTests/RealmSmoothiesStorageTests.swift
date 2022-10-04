@testable import Data
import Domain
import RealmSwift
import XCTest

final class RealmSmoothiesStorageTests: XCTestCase {

    var sut: RealmSmoothiesStorage!
    
    override func setUp() {
        sut = RealmSmoothiesStorage()
    }

    override func tearDown() {
        let realm = try! Realm()
        
        try! realm.write {
            realm.deleteAll()
        }
    }

    func testFetchSmoothie() {
        let realm = try! Realm()
        
        let bananaSmoothie = makeBananaSmoothie()
        
        try! realm.write {
            realm.add(bananaSmoothie)
        }
        
        let smoothies = sut.fetchSmoothies()
        
        XCTAssertEqual(smoothies.count, 1)
    }
    
    func testSave() {
        let realm = try! Realm()
        
        let bananaSmoothie = makeBananaSmoothie()
        
        try! sut.save(smoothie: bananaSmoothie.toDomain())
        
        let smoothies = realm.objects(SmoothieRO.self)
        
        XCTAssertEqual(smoothies.count, 1)
        
        XCTAssertEqual(smoothies.first?.title, "Banana smoothie")
        
        XCTAssertEqual(smoothies.first?.url, "https://www.bbcgoodfood.com/recipes/afternoon-pick-me-smoothie")
        
        XCTAssertEqual(smoothies.first?.thumbnail, "https://images.immediate.co.uk/production/volatile/sites/30/2020/08/afternoon-pick-me-up-smoothie-506a768.jpg")
        
        XCTAssertEqual(smoothies.first?.rating, "4.2")
        
        XCTAssertEqual(Array(smoothies.first!.tags), ["freezable", "gluten-free"])
    }
    
    func testUpdate() {
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(makeBananaSmoothie())
        }
        
        try! sut.update(smoothie: makeCompleteBananaSmoothie().toDomain())
        
        let smoothies = realm.objects(SmoothieRO.self)
        
        XCTAssertEqual(smoothies.count, 1)
        
        let smoothie = smoothies.first!
        
        XCTAssertEqual(smoothie.title, "Banana smoothie")
        
        XCTAssertEqual(smoothie.url, "https://www.bbcgoodfood.com/recipes/afternoon-pick-me-smoothie")
        
        XCTAssertEqual(smoothie.thumbnail, "https://images.immediate.co.uk/production/volatile/sites/30/2020/08/afternoon-pick-me-up-smoothie-506a768.jpg")
        
        XCTAssertEqual(smoothie.rating, "4.2")
        
        XCTAssertEqual(Array(smoothie.tags), ["freezable", "gluten-free"])
        
        XCTAssertEqual(smoothie.text, "Quick and easy to make, this banana, prune, almond milk and nut butter smoothie is an ideal on-the-go energy boost")
        
        XCTAssertEqual(smoothie.prepTime, "5 mins")
        
        XCTAssertEqual(smoothie.skill, "easy")
        
        XCTAssertEqual(smoothie.servings, "2 (700ml)")
        
        let nutrition = smoothie.nutrition!
        
        XCTAssertEqual(nutrition.kcal, "250")
        
        XCTAssertEqual(nutrition.fat, "11g")
        
        XCTAssertEqual(nutrition.saturates, "1g")
        
        XCTAssertEqual(nutrition.carbs, "29g")
        
        XCTAssertEqual(nutrition.sugars, "22g")
        
        XCTAssertEqual(nutrition.fibre, "5g")
        
        XCTAssertEqual(nutrition.protein, "5g")
        
        XCTAssertEqual(nutrition.salt, "0.3g")
        
        let stepOne = smoothie.steps[0]
        
        XCTAssertEqual(stepOne.number, "1")
        
        XCTAssertEqual(stepOne.text, "In a blender, whizz the almond milk with the almond butter, prunes, cinnamon and banana.")
        
        let stepTwo = smoothie.steps[1]
        
        XCTAssertEqual(stepTwo.number, "2")
        
        XCTAssertEqual(stepTwo.text, "Transfer to 2 bottles and chill until ready to drink, or pack for lunch on the go. The smoothies will keep in the fridge for 2 days.")

        let ingredients = [
            "500ml unsweetened almond milk",
            "2 tbsp almond butter",
            "6 prunes",
            "1 tsp cinnamon",
            "1 small ripe banana"
        ]
        
        XCTAssertEqual(Array(smoothie.ingredients), ingredients)
        
        let recommendedOne = smoothie.recommended[0]
        
        XCTAssertEqual(recommendedOne.title, "Coconut & banana smoothie")
        
        XCTAssertEqual(recommendedOne.url, "https://www.bbcgoodfood.com/recipes/immune-boosting-smoothie")
        
        XCTAssertEqual(recommendedOne.image, "https://images.immediate.co.uk/production/volatile/sites/30/2020/08/cropped-immune-boosting-smoothie-6c125e6.jpg")
        
        let recommendedTwo = smoothie.recommended[1]
        
        XCTAssertEqual(recommendedTwo.title, "Banana smoothie")
        
        XCTAssertEqual(recommendedTwo.url, "https://www.bbcgoodfood.com/recipes/afternoon-pick-me-smoothie")
        
        XCTAssertEqual(recommendedTwo.image, "https://images.immediate.co.uk/production/volatile/sites/30/2020/08/afternoon-pick-me-up-smoothie-506a768.jpg")
        
        let recommendedThree = smoothie.recommended[2]
        
        XCTAssertEqual(recommendedThree.title, "Blueberry & banana power smoothie")
        
        XCTAssertEqual(recommendedThree.url, "https://www.bbcgoodfood.com/recipes/blueberry-banana-power-smoothie")
        
        XCTAssertEqual(recommendedThree.image, "https://images.immediate.co.uk/production/volatile/sites/30/2020/08/blueberry-banana-power-smoothie-5c9475a.jpg")
        
        let recommendedFour = smoothie.recommended[3]
        
        XCTAssertEqual(recommendedFour.title, "Peanut butter smoothie")
        
        XCTAssertEqual(recommendedFour.url, "https://www.bbcgoodfood.com/recipes/peanut-butter-smoothie")
        
        XCTAssertEqual(recommendedFour.image, "https://images.immediate.co.uk/production/volatile/sites/30/2021/05/Peanut-Butter-Smoothie-3430e32.jpg")
        
        let recommendedFive = smoothie.recommended[4]
        
        XCTAssertEqual(recommendedFive.title, "Watermelon smoothie")
        
        XCTAssertEqual(recommendedFive.url, "https://www.bbcgoodfood.com/recipes/watermelon-smoothie")
        
        XCTAssertEqual(recommendedFive.image, "https://images.immediate.co.uk/production/volatile/sites/30/2021/04/Watermelon-Smoothie-99503bb.jpg")

    }
    
    func makeBananaSmoothie() -> SmoothieRO {
        let tags = [
            "freezable",
            "gluten-free"
        ]
        
        let smoothie = Smoothie(title: "Banana smoothie", url: "https://www.bbcgoodfood.com/recipes/afternoon-pick-me-smoothie", thumbnail: "https://images.immediate.co.uk/production/volatile/sites/30/2020/08/afternoon-pick-me-up-smoothie-506a768.jpg", rating: 4.2, tags: tags)
        
        return SmoothieRO(smoothie: smoothie)
    }
    
    func makeCompleteBananaSmoothie() -> SmoothieRO {
        let tags = [
            "freezable",
            "gluten-free"
        ]
        
        let ingredients = [
            "500ml unsweetened almond milk",
            "2 tbsp almond butter",
            "6 prunes",
            "1 tsp cinnamon",
            "1 small ripe banana"
        ]
        
        let nutrition = SmoothieNutrition (
            kcal: "250",
            fat: "11g",
            saturates: "1g",
            carbs: "29g",
            sugars: "22g",
            fibre: "5g",
            protein: "5g",
            salt: "0.3g"
        )
        
        let steps = [
            [
               "number": "1",
               "text": "In a blender, whizz the almond milk with the almond butter, prunes, cinnamon and banana."
            ], [
               "number":"2",
               "text":"Transfer to 2 bottles and chill until ready to drink, or pack for lunch on the go. The smoothies will keep in the fridge for 2 days."
            ]
        ].compactMap {
            return SmoothieStep (
                number: $0["number"] ?? "0",
                text: $0["text"] ?? "test"
            )
        }
        
        let recommended = [
            [
               "title":"Coconut & banana smoothie",
               "url":"https://www.bbcgoodfood.com/recipes/immune-boosting-smoothie",
               "image":"https://images.immediate.co.uk/production/volatile/sites/30/2020/08/cropped-immune-boosting-smoothie-6c125e6.jpg"
            ], [
               "title":"Banana smoothie",
               "url":"https://www.bbcgoodfood.com/recipes/afternoon-pick-me-smoothie",
               "image":"https://images.immediate.co.uk/production/volatile/sites/30/2020/08/afternoon-pick-me-up-smoothie-506a768.jpg"
            ], [
               "title":"Blueberry & banana power smoothie",
               "url":"https://www.bbcgoodfood.com/recipes/blueberry-banana-power-smoothie",
               "image":"https://images.immediate.co.uk/production/volatile/sites/30/2020/08/blueberry-banana-power-smoothie-5c9475a.jpg"
            ], [
               "title":"Peanut butter smoothie",
               "url":"https://www.bbcgoodfood.com/recipes/peanut-butter-smoothie",
               "image":"https://images.immediate.co.uk/production/volatile/sites/30/2021/05/Peanut-Butter-Smoothie-3430e32.jpg"
            ], [
               "title":"Watermelon smoothie",
               "url":"https://www.bbcgoodfood.com/recipes/watermelon-smoothie",
               "image":"https://images.immediate.co.uk/production/volatile/sites/30/2021/04/Watermelon-Smoothie-99503bb.jpg"
            ]
        ].compactMap {
            return SmoothieRecommended (
                title: $0["title"] ?? "test",
                url: $0["url"] ?? "test",
                image: $0["image"] ?? "test"
            )
        }
        
        let smoothie = Smoothie (
            title: "Banana smoothie",
            url: "https://www.bbcgoodfood.com/recipes/afternoon-pick-me-smoothie",
            thumbnail: "https://images.immediate.co.uk/production/volatile/sites/30/2020/08/afternoon-pick-me-up-smoothie-506a768.jpg",
            rating: 4.2,
            tags: tags,
            description: "Quick and easy to make, this banana, prune, almond milk and nut butter smoothie is an ideal on-the-go energy boost",
            prepTime: "5 mins",
            skill: "easy",
            servings: "2 (700ml)",
            ingredients: ingredients,
            nutrition: nutrition,
            steps: steps,
            recommended: recommended,
            tips: [SmoothieTip]()
        )
        
        return SmoothieRO(smoothie: smoothie)
    }
    
}
