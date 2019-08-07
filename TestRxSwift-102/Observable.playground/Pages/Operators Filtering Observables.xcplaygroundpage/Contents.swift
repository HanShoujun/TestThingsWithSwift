//: [Previous](@previous)

import Foundation
import RxSwift
import RxCocoa

enum MyError: Error {
    case oneError
}
let disposeBag = DisposeBag()

test("Operator: throttle") {

    let source = PublishSubject<Int>()

    let debounceOb = source
        .throttle(RxTimeInterval.seconds(1), latest: false, scheduler: MainScheduler.instance)
        .debug()

    print("****before subscribe*****")
    let dispose = debounceOb
        .subscribe(onNext: { print($0) })

    delay(0.1, closure: {
        source.onNext(1)
    })
    delay(2.1, closure: {
        source.onNext(2)
    })
    delay(2.2, closure: {
        source.onNext(3)
    })
    delay(3.1, closure: {
        source.onNext(4)
    })
    delay(3.4, closure: {
        source.onNext(5)
    })
    delay(4, closure: {
        source.onCompleted()
    })

    print("****before dispose*****")
    delay(5, closure: {
        dispose.dispose()
    })

}

test("Operator: takeUntil") {
    let source = PublishSubject<Int>()
    let notifier = PublishSubject<Bool>()

    let observable = source.debug("source")
        .takeUntil(notifier.debug("notifier"))
        .debug("takeUntil")

    print("****before subscribe*****")
    let dispose = observable.subscribe { print($0) }

    source.onNext(2)
    source.onNext(4)
    //    notifier.onNext(false)

    //    notifier.onCompleted()
    notifier.onError(MyError.oneError)
//        notifier.onCompleted()
    notifier.onNext(false)

    source.onNext(5)

    print("****before dispose*****")
    dispose.dispose()
}

test("Operator: takeWhile") {
    let source = PublishSubject<Int>()

    let observable = source
        .takeWhile({ (item) -> Bool in
            item < 5
        })
        .debug()

    print("****before subscribe*****")
    let dispose = observable.subscribe { print($0) }

    source.onNext(2)
    source.onNext(4)
    source.onNext(5)
    //    source.onError(MyError.oneError)
    source.onCompleted()

    source.onNext(6)

    print("****before dispose*****")
    dispose.dispose()
}

test("Operator: take") {
    let source = PublishSubject<Int>()

    let observable = source
        .take(2)
        .debug()

    print("****before subscribe*****")
    let dispose = observable.subscribe { print($0) }

    source.onNext(2)
    source.onError(MyError.oneError)
    source.onNext(4)
    source.onNext(5)
    //    source.onCompleted()

    print("****before dispose*****")
    dispose.dispose()
}

test("Operator: skipWhile") {
    let source = PublishSubject<Int>()

    let observable = source
        .skipWhile({ (item) -> Bool in
            item < 4
        })
        .debug()

    print("****before subscribe*****")
    let dispose = observable.subscribe { print($0) }

    source.onNext(2)
    source.onNext(4)
    source.onNext(5)
//    source.onError(MyError.oneError)
    source.onCompleted()

    source.onNext(6)

    print("****before dispose*****")
    dispose.dispose()
}

test("Operator: skipUntil") {
    let source = PublishSubject<Int>()
    let notifier = PublishSubject<Bool>()

    let observable = source.debug("source")
        .skipUntil(notifier.debug("notifier"))
        .debug("skipUntil")

    print("****before subscribe*****")
    let dispose = observable.subscribe { print($0) }

    source.onNext(2)
    source.onNext(4)
//    notifier.onNext(false)

//    notifier.onCompleted()
    source.onError(MyError.oneError)
//    source.onCompleted()
    notifier.onNext(false)

    source.onNext(5)

    print("****before dispose*****")
    dispose.dispose()
}

test("Operator: skip") {
    let source = PublishSubject<Int>()

    let observable = source
        .skip(2)
        .debug()

    print("****before subscribe*****")
    let dispose = observable.subscribe { print($0) }

    source.onNext(2)
    source.onNext(4)
    source.onNext(5)
//    source.onCompleted()
    source.onError(MyError.oneError)

    print("****before dispose*****")
    dispose.dispose()
}

test("Operator: sample") {

    let source = PublishSubject<Int>()
    let notifier = PublishSubject<Bool>()

    let observable = source.debug("source")
        .sample(notifier.debug("notifier"))
        .debug("sample")

    print("****before subscribe*****")
    let dispose = observable.subscribe { print($0) }

    let dispose2 = observable.subscribe { print($0) }

    source.onNext(2)
    notifier.onNext(false)
//    source.onNext(3)
    source.onNext(4)

    notifier.onNext(true)
//    source.onCompleted()
    notifier.onError(MyError.oneError)
    notifier.onNext(true)
    source.onNext(5)

    print("****before dispose*****")
    dispose.dispose()
    dispose2.dispose()

}

test("Operator: ignoreElements") {

    let originalOb = Observable.of(1,2,3,3,2,2)

    let observable = originalOb
        .ignoreElements()
        .debug()

    print("****before subscribe*****")
    let dispose = observable.subscribe { print($0) }

    print("****before dispose*****")
    dispose.dispose()

}

test("Operator: first") {

    let originalOb = Observable.of(1,2,3,3,2,2)

    let observable = originalOb
        .first()
        .debug()

    print("****before subscribe*****")
    let dispose = observable.subscribe { print($0) }

    print("****before dispose*****")
    dispose.dispose()

}

test("Operator: filter") {

    let originalOb = Observable.of(1,2,3,3,2,2)

    let observable = originalOb
        .filter({ (item) -> Bool in
            item % 2 == 0
        })
        .debug()

    print("****before subscribe*****")
    let dispose = observable
        .subscribe(onNext: { print($0) })

    print("****before dispose*****")
    dispose.dispose()

}

test("Operator: elementAt") {

    let originalOb = Observable.of(1,2,3,3,2,2)

    let observable = originalOb
        .elementAt(2)
        .debug()

    print("****before subscribe*****")
    let dispose = observable
        .subscribe(onNext: { print($0) })

    print("****before dispose*****")
    dispose.dispose()

}

test("Operator: distinctUntilChanged") {

    let ob = Observable.of(1,2,3,3,2,2)

    let distinctUntilChangedOb = ob
        .distinctUntilChanged()
        .debug()

    print("****before subscribe*****")
    let dispose = distinctUntilChangedOb
        .subscribe(onNext: { print($0) })

    print("****before dispose*****")
    delay(7, closure: {
        dispose.dispose()
    })

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

test("Operator: debounce") {

    let times = [
        [ "value": 1, "time": 0.1 ],
        [ "value": 2, "time": 1.1 ],
        [ "value": 3, "time": 1.2 ],
        [ "value": 4, "time": 1.2 ],
        [ "value": 5, "time": 1.4 ],
        [ "value": 6, "time": 2.1 ]
    ]

    let debounceOb = Observable.from(times)
        .flatMap { item in
            return Observable.of(Int(item["value"]!))
                .delaySubscription(Double(item["time"]!),
                                   scheduler: MainScheduler.instance)
        }
        .debounce(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance)
        .debug()
    
    print("****before subscribe*****")
    let dispose = debounceOb
        .subscribe(onNext: { print($0) })

    print("****before dispose*****")
    delay(7, closure: {
        dispose.dispose()
    })

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

