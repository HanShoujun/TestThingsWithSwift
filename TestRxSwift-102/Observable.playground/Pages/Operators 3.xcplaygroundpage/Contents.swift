//: [Previous](@previous)

import Foundation
import UIKit
import RxSwift
import RxCocoa

let disposeBag = DisposeBag()

//test("Operator: connect") {
//
//    let interval = Observable<Int>.interval(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
//
//    interval.subscribe({ (event) in
//        print("订阅1,,,,,,,,,,,,,：\(event)")
//    }).disposed(by: disposeBag)
//
//    delay(5, closure: {
//        interval.subscribe({ (event) in
//            print("订阅2******：\(event)")
//        }).disposed(by: disposeBag)
//    })
//
//}

//test("Operator: publish") {
//
//    var bag: DisposeBag? = DisposeBag()
//    let interval = Observable<Int>.interval(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
//        .publish()
//
//    interval.subscribe({ (event) in
//        print("订阅1,,,,,,,,,,,,,：\(event)")
//    }).disposed(by: disposeBag)
//
//    delay(2, closure: {
//        interval.connect()
//    })
//
//    delay(5, closure: {
//        interval.subscribe({ (event) in
//            print("订阅2******：\(event)")
//        }).disposed(by: disposeBag)
//    })
//
//}

//test("Operator: replay") {
//
//    let interval = Observable<Int>.interval(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
//        .replay(2)
//
//    interval.subscribe({ (event) in
//        print("订阅1,,,,,,,,,,,,,：\(event)")
//    }).disposed(by: disposeBag)
//
//    delay(2, closure: {
//        interval.connect()
//    })
//
//    delay(8, closure: {
//        interval.subscribe({ (event) in
//            print("订阅2******：\(event)")
//        }).disposed(by: disposeBag)
//    })
//
//}

//test("Operator: multicast") {
//
//    let subject = PublishSubject<Int>()
//
//    subject.subscribe({ (event) in
//        print("Subject::::::::::::::\(event)")
//    })
//
//    let interval = Observable<Int>.interval(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
//        .multicast(subject)
//
//    interval.subscribe({ (event) in
//        print("订阅1,,,,,,,,,,,,,：\(event)")
//    }).disposed(by: disposeBag)
//
//    delay(2, closure: {
//        interval.connect()
//    })
//
//    delay(6, closure: {
//        interval.subscribe({ (event) in
//            print("订阅2******：\(event)")
//        }).disposed(by: disposeBag)
//    })
//
//}

test("Operator: refCount") {

    let interval = Observable<Int>.interval(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
        .publish()
        .refCount()

    interval.subscribe({ (event) in
        print("订阅1,,,,,,,,,,,,,：\(event)")
    }).disposed(by: disposeBag)

    delay(5, closure: {
        interval.subscribe({ (event) in
            print("订阅2******：\(event)")
        }).disposed(by: disposeBag)
    })

}

//test("Operator: share(replay:)") {
//
//    let interval = Observable<Int>.interval(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
//        .share(replay: 2)
//
//    interval.subscribe({ (event) in
//        print("订阅1,,,,,,,,,,,,,：\(event)")
//    }).disposed(by: disposeBag)
//
//    delay(5, closure: {
//        interval.subscribe({ (event) in
//            print("订阅2******：\(event)")
//        }).disposed(by: disposeBag)
//    })
//
//}
