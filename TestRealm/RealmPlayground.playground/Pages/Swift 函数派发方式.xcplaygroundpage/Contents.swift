//: [Previous](@previous)

import Foundation

let array = [1,2,3,4,5]
let list = [2,3,6]

let set1 = Set(array)
let set2 = Set(list)

let set = set1.intersection(set2)

let delete = list.filter { !set.contains($0) }
let add = array.filter { !set.contains($0) }
print(add)
print(delete)

var str = "Hello, playground"

protocol ProtocolA {
    func funcA()
}

extension ProtocolA {
    func funcA() {
        print("ProtocolA.self")
    }
}

class ClassA: ProtocolA {
    //    func funcA() {
    //        print("ClassA.self")
    //    }
}

class SubClass: ClassA {
    func funcA() {
        print("SubClass.self")
    }
}

print("let classa: ProtocolA = ClassA()")
let classa: ProtocolA = ClassA()
classa.funcA()

print("let classa: ClassA = ClassA()")
let classb: ClassA = ClassA()
classb.funcA()

print("let classa: ProtocolA = SubClass()")
let classc: ClassA = SubClass()
classc.funcA()

func testArg(_ with: ProtocolA) {
    with.funcA()
}

testArg(classa)

testArg(classb)
testArg(classc)
