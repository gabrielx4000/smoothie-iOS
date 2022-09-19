@testable import Data
import Domain
import RealmSwift
import XCTest

final class RealmFruitsStorageTests: XCTestCase {

    var sut: RealmFruitsStorage!
    
    override func setUp() {
        sut = RealmFruitsStorage()
    }

    override func tearDown() {
        let realm = try! Realm()
        
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    func testFetchFruits() {
        let realm = try! Realm()
        
        let banana = makeBanana()
        
        try! realm.write {
            realm.add(banana)
        }
        
        let fruits = sut.fetchFruits()
        
        XCTAssertEqual(fruits.count, 1)
    }
    
    func testSaveFruits() {
        let realm = try! Realm()
        
        XCTAssertEqual(realm.objects(FruitRO.self).count, 0)

        try! sut.saveFruits(fruits: [makeBanana().toDomain()])
        
        XCTAssertEqual(realm.objects(FruitRO.self).count, 1)
    }
    
    func makeBanana() -> FruitRO {
        let nutrition = Nutrition(carbohydrates: 22, protein: 1, fat: 0.2, calories: 96, sugar: 17.2)
        let banana = Fruit(id: 1, name: "Banana", genus: "Musa", family: "Musaceae", order: "Zingiberales", nutrition: nutrition)
        
        return FruitRO(fruit: banana)
    }
    
}
