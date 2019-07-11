//: [Previous](@previous)

import UIKit
import RxSwift
import RxCocoa

let disposeBag = DisposeBag()

test("Operator: buffer") {
    let publishSubject = PublishSubject<Int>()

    publishSubject
        .asObservable()
        .buffer(timeSpan: RxTimeInterval.seconds(1), count: 3, scheduler: MainScheduler.instance)
        .subscribe({ (event) in
            print(event)
        }).disposed(by: disposeBag)
    publishSubject.onNext(1)
    publishSubject.onNext(2)
    publishSubject.onNext(1)
    publishSubject.onNext(2)

    publishSubject.onNext(1)
    publishSubject.onNext(2)
    publishSubject.onNext(1)
    publishSubject.onNext(2)

    publishSubject.onCompleted()
    
}

test("Operator: window") {
    let publishSubject = PublishSubject<Int>()

    publishSubject
        .asObservable()
        .window(timeSpan: RxTimeInterval.seconds(1), count: 3, scheduler: MainScheduler.instance)
        .subscribe({ (event) in
            print(event)
            event.element?.subscribe({ (item) in
                print(item)
            }).disposed(by: disposeBag)
        })
        .disposed(by: disposeBag)
    publishSubject.onNext(1)
    publishSubject.onNext(2)
    publishSubject.onNext(1)
    publishSubject.onNext(2)

    publishSubject.onNext(1)
    publishSubject.onNext(2)
    publishSubject.onNext(1)
    publishSubject.onNext(2)

    publishSubject.onCompleted()
}

test("Operator: flatmap") {
    let subject1 = BehaviorSubject(value: "a")
    let subject2 = BehaviorSubject(value: 0)
    let relay = BehaviorRelay(value: subject1)

    subject1.onNext("A")
    subject2.onNext(1)
    subject1.onNext("B")
    subject2.onNext(2)

    subject1
        .asObservable()
        .flatMapLatest({ (_)  in
            return subject2
        }).subscribe({ (event) in
            print(event)
        }).disposed(by: disposeBag)

//    subject1.onNext("C")
    subject2.onNext(3)

//    relay.accept(subject2)

    subject1.onNext("D")
    subject2.onNext(4)

//    subject2.onNext(5)
//    subject1.onNext("E")

}

test("Operator: flatMapLatest") {
    let subject1 = BehaviorSubject(value: "a")
    let subject2 = BehaviorSubject(value: "0")

    let relay = BehaviorRelay(value: subject1)

    subject1.onNext("A")
    subject2.onNext("1")
    subject1.onNext("B")
    subject2.onNext("2")

    relay
        .asObservable()
        .flatMapLatest({ (subject)  in
            return subject
        }).subscribe({ (event) in
            print(event)
        }).disposed(by: disposeBag)

    subject1.onNext("C")
    subject2.onNext("3")

    relay.accept(subject2)

    subject1.onNext("D")
    subject2.onNext("4")

    subject2.onNext("5")
    subject1.onNext("E")
}

test("Operator: flatMapFirst") {
    let subject1 = BehaviorSubject(value: "a")
    let subject2 = BehaviorSubject(value: "0")
    let relay = BehaviorRelay(value: subject1)

    subject1.onNext("A")
    subject2.onNext("1")
    subject1.onNext("B")
    subject2.onNext("2")

    relay
        .asObservable()
        .flatMapFirst({ (subject)  in
            return subject
        }).subscribe({ (event) in
            print(event)
        }).disposed(by: disposeBag)

    subject1.onNext("C")
    subject2.onNext("3")

    relay.accept(subject2)

    subject1.onNext("D")
    subject2.onNext("4")

    subject2.onNext("5")
    subject1.onNext("E")
}

test("Operator: concatMap") {
    let subject1 = BehaviorSubject(value: "A")
    let subject2 = BehaviorSubject(value: "1")
    let relay = BehaviorRelay(value: subject1)

    subject1.onNext("B")
    subject2.onNext("2")

    relay
        .asObservable()
        .concatMap({ (subject) in
            return subject
        })
        .subscribe({ (event) in
            print(event)
        }).disposed(by: disposeBag)

    subject1.onNext("C")
    subject2.onNext("3")

    relay.accept(subject2)

    subject1.onNext("D")
    subject2.onNext("4")

    subject1.onCompleted()

    subject2.onNext("5")
    subject1.onNext("E")
}

test("Operator: scan") {
    let ob = Observable.of(1,2,3,4,5,6,7,8)

    ob
        .scan(1, accumulator: { (acum, elem) in
            acum + elem
        })
        .subscribe({ (event) in
            print(event)
        }).disposed(by: disposeBag)

    let relay = BehaviorRelay(value: "1")

    relay.asObservable().scan("S:", accumulator: { (acum, elem) in
        acum + elem
    }).subscribe({ (event) in
        print(event)
    }).disposed(by: disposeBag)

    relay.accept("2")
    relay.accept("2")
    relay.accept("2")
    relay.accept("2")
}

