@testable import Data
import Domain
import RealmSwift
import XCTest

final class RealmFruitsStorageTests: XCTestCase {
    
    var sut: RealmFruitsStorage!
    
    let realm = try! Realm()
    
    override func setUp() {
        try! realm.write {
            realm.deleteAll()
        }
        
        sut = RealmFruitsStorage()
    }
    
    override func tearDown() {
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    func testFetchFruits() {
        let realm = try! Realm()
        
        let banana = DataTestsHelper.makeBananaRO()
        
        try! realm.write {
            realm.add(banana)
        }
        
        let fruits = sut.fetchFruits()
        
        XCTAssertEqual(fruits.count, 1)
    }
    
    func testSaveFruits() {
        let realm = try! Realm()
        
        XCTAssertEqual(realm.objects(FruitRO.self).count, 0)
        
        try! sut.saveFruits(fruits: [DataTestsHelper.makeBananaRO().toDomain()])
        
        XCTAssertEqual(realm.objects(FruitRO.self).count, 1)
    }
    
}
