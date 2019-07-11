//: [Previous](@previous)

import Foundation
import RxSwift
import RxCocoa

let disposeBag = DisposeBag()

test("Operator: distinctUntilChanged") {
    let ob = Observable.of(1,2,3,4,4,4,5,6)

    ob
        .distinctUntilChanged()
        .subscribe({ (event) in
            print(event)
        })
        .disposed(by: disposeBag)
}

test("Operator: single") {
    let ob = Observable.of(1,2,3)

    ob
        .single()
        .subscribe({ (event) in
            print(event)
        })
        .disposed(by: disposeBag)
}

test("Operator: ignoreElements") {
    let ob = Observable.of(1,2,3)

    ob
        .ignoreElements()
        .subscribe({ (event) in
            print(event)
        })
        .disposed(by: disposeBag)
}

test("Operator: take") {
    let ob = Observable.of(1,2,3,4)
    ob
        .take(1)
        .subscribe({ (event) in
            print(event)
        })
        .disposed(by: disposeBag)
}

test("Operator: skip") {
    let relay = BehaviorRelay(value: 1)

    relay
        .skip(2)
        .subscribe({ (event) in
            print(event)
        })
        .disposed(by: disposeBag)

    relay.accept(2)
    relay.accept(4)
}

test("Operator: sample") {
    let source = PublishSubject<Int>()
    let notifier = PublishSubject<Bool>()

    source
        .sample(notifier)
        .subscribe({ (event) in
            print(event)
        })
        .disposed(by: disposeBag)

    source.onNext(1)

    notifier.onNext(true)

    source.onNext(2)

    notifier.onNext(false)
    notifier.onNext(true)

    source.onNext(3)
    source.onNext(4)

    notifier.onCompleted()

}

test("Operator: debounce") {

    let times = [
        [ "value": 1, "time": 0.1 ],
        [ "value": 2, "time": 1.1 ],
        [ "value": 3, "time": 1.2 ],
        [ "value": 4, "time": 1.2 ],
        [ "value": 5, "time": 1.4 ],
        [ "value": 6, "time": 2.1 ]
    ]

    Observable.from(times)
        .flatMap { item in
            return Observable.of(Int(item["value"]!))
                .delaySubscription(Double(item["time"]!),
                                   scheduler: MainScheduler.instance)
        }
        .debounce(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance)
        .subscribe(onNext: { print($0) })
        .disposed(by: disposeBag)

}

test("Operators: withLastFrom") {
    let firstSubject = PublishSubject<String>()
    let secondSubject = PublishSubject<String>()

    firstSubject
        .withLatestFrom(secondSubject)
        .subscribe(onNext: { print($0) })
        .disposed(by: disposeBag)

    firstSubject.onNext("🅰️")
    secondSubject.onNext("1")
    firstSubject.onNext("🅱️")
    secondSubject.onNext("2")
    firstSubject.onNext("🆎")
    firstSubject.onNext("🆎")
}

