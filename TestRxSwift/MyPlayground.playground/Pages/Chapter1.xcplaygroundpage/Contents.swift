//: [Previous](@previous)
import UIKit
import RxSwift
import RxCocoa

example("Create Observable") {

    let one = 1
    let two = 2

    let justObservable = Observable<Int>.just(one)
    let ofObservable = Observable<Int>.of(one, two)

}
//: ["Next"](@next)
