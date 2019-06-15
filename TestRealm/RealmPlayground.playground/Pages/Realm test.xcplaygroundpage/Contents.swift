import UIKit
import Foundation
import RealmSwift

var str = "Hello, playground"

class Dog: Object {
    @objc dynamic var id = 0
    @objc dynamic var name: String?
    @objc dynamic var age: String?
    @objc dynamic var otherId = 0

    override static func primaryKey() -> String? {
        return "otherId"
    }
}

let config = Realm.Configuration(
    schemaVersion: 1,
    migrationBlock: { (migration, oldSchemaVersion) in
        if (oldSchemaVersion < 1) {

        }
    },
    deleteRealmIfMigrationNeeded: true)
Realm.Configuration.defaultConfiguration = config

let realm = try! Realm()

let dogs = realm.objects(Dog.self)

dogs.observe { (change) in
    switch change {
    case .update(let list, let deletions, let insertions, let modifications):
        print(list)
        print(deletions)
        print(insertions)
    default:
        break
    }
}

//try! realm.write {
//    if let dog3 = dogs.first {
//        realm.delete(dog3)
//        print("delete")
//    }
//}

//try! realm.write {
//    realm.deleteAll()
//    print("deleteAll")
//}

let dog = Dog()
dog.otherId = 1
dog.id = 1
dog.name = "Peater"
dog.age = "2"

try! realm.write {
    realm.add(dog, update: true)
    print("add")
}

let dog2 = Dog()
dog2.name = "Peater"
dog2.age = "4"
dog2.id = 2
dog2.otherId = 2

try! realm.write {
    realm.add(dog2, update: true)
    print("add2")
}

try! realm.write {
    realm.delete(dog)
    print("delete")
}

print(dogs.count)

let dog4 = dogs.first(where: { (dog) -> Bool in
    Int(dog.age ?? "0") == 4
})
try! realm.write {
    if let dog4 = dog4 {
        dog4.age = "8"
        print("update")
    }
}

let doggy = realm.object(ofType: Dog.self, forPrimaryKey: 10)

print(doggy?.otherId ?? "null")

doggy?.observe({ (change) in
    print(change)
})

let dog10 = Dog()
dog10.name = "num10"
dog10.age = "10"
dog10.id = 10
dog10.otherId = 10

try! realm.write {
    realm.add(dog10)
    print("add dog10")
}










