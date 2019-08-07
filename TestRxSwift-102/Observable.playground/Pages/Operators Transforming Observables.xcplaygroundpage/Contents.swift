//: [Previous](@previous)

import UIKit
import RxSwift
import RxCocoa

func handler<T>(_ event: Event<T>) {
    switch event {
    case .next(let v):
        print(v)
    default:
        print(event)
    }
}
enum MyError: Error {
    case oneError
}
let disposeBag = DisposeBag()

test("Operator: buffer") {
    let publishSubject = PublishSubject<Int>()

    let bufferOb = publishSubject
        .asObservable()
        .buffer(timeSpan: RxTimeInterval.seconds(1), count: 3, scheduler: MainScheduler.instance)
        .debug()

    print("****before subscribe*****")
    let dispose = bufferOb.subscribe(handler)
    publishSubject.onNext(1)
    publishSubject.onNext(2)
    publishSubject.onNext(1)
    publishSubject.onNext(1)
    publishSubject.onNext(2)
    publishSubject.onError(MyError.oneError)
    publishSubject.onCompleted()

    print("****before dispose*****")
    dispose.dispose()
    
}

test("Operator: window") {
    let publishSubject = PublishSubject<Int>()

    let windowOb = publishSubject
        .asObservable()
        .window(timeSpan: RxTimeInterval.seconds(1), count: 3, scheduler: MainScheduler.instance)
        .debug()

    print("****before subscribe*****")
    let dispose = windowOb
        .subscribe({ (event) in
            print(event)
            event.element?.subscribe({ (item) in
                print(item)
            }).disposed(by: disposeBag)
        })

    publishSubject.onNext(1)
    publishSubject.onNext(2)
    publishSubject.onNext(1)
    publishSubject.onNext(2)
    publishSubject.onNext(2)

    publishSubject.onCompleted()
    print("****before dispose*****")
    dispose.dispose()
}

test("Operator: flatmap") {
    let subject1 = PublishSubject<String>()
    let subject2 = PublishSubject<Int>()

    let flatMapOb = subject1.debug("subjectAAAAA")
        .asObservable()
        .flatMapFirst({ (_) -> Observable<Int> in
            print("block factory")
            return subject2.debug("subjectBBBBB")
        }).debug("flatMapOb")

    print("****before subscribe*****")
    let dispose = flatMapOb.subscribe(handler)

    subject1.onNext("C")
    subject2.onNext(3)

    let dispose2 = flatMapOb.subscribe(handler)
    subject1.onNext("D")
    subject2.onNext(4)
//
//    subject2.onError(MyError.oneError)
//    subject1.onError(MyError.oneError)
    subject2.onCompleted()
    subject2.onNext(4)
    subject1.onNext("D")
    subject2.onNext(4)

    print("****before dispose*****")
    dispose.dispose()
    dispose2.dispose()
}

test("Operator: flatMapFirst") {
    let subject1 = PublishSubject<String>()
    let subject2 = PublishSubject<Int>()

    let flatMapOb = subject1.debug("subjectAAAAA")
        .asObservable()
        .flatMapFirst({ (_) -> Observable<Int> in
            print("block factory")
            return subject2.debug("subjectBBBBB")
        }).debug("flatMapOb")

    print("****before subscribe*****")
    let dispose = flatMapOb.subscribe(handler)

    subject1.onNext("C")
    subject2.onNext(3)

    let dispose2 = flatMapOb.subscribe(handler)
    subject1.onNext("D")
    subject2.onNext(4)
    //
    //    subject2.onError(MyError.oneError)
    //    subject1.onError(MyError.oneError)
    subject2.onCompleted()
    subject2.onNext(4)
    subject1.onNext("D")
    subject2.onNext(4)

    print("****before dispose*****")
    dispose.dispose()
    dispose2.dispose()
}


test("Operator: flatMapLatest") {
    let subject1 = PublishSubject<String>()
    let subject2 = PublishSubject<Int>()

    let flatMapOb = subject1.debug("subjectAAAAA")
        .asObservable()
        .flatMapLatest({ (_) -> Observable<Int> in
            print("block factory")
            return subject2.debug("subjectBBBBB")
        }).debug("flatMapOb")

    print("****before subscribe*****")
    let dispose = flatMapOb.subscribe(handler)

    subject1.onNext("C")
    subject2.onNext(3)

    let dispose2 = flatMapOb.subscribe(handler)
    subject1.onNext("D")
    subject2.onNext(4)
    //
    //    subject2.onError(MyError.oneError)
    //    subject1.onError(MyError.oneError)
    subject2.onCompleted()
    subject2.onNext(4)
    subject1.onNext("D")
    subject2.onNext(4)

    print("****before dispose*****")
    dispose.dispose()
    dispose2.dispose()
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

    let publishSubject = PublishSubject<Int>()

    let ob = publishSubject.scan(1, accumulator: { (acum, elem) in
        acum + elem
    }).debug()

    print("****before subscribe*****")
    let dispose = ob.subscribe({ (event) in
            print(event)
        })

    publishSubject.onNext(1)
    publishSubject.onNext(2)
    publishSubject.onNext(1)
    publishSubject.onNext(1)
    publishSubject.onNext(2)
    publishSubject.onError(MyError.oneError)

    print("****before dispose*****")
    dispose.dispose()
}

