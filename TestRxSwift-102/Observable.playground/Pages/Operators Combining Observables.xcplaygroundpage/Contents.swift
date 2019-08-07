//: [Previous](@previous)

import Foundation
import PlaygroundSupport
import RxSwift
import RxCocoa

enum MyError: Error {
    case oneError
}

let disposeBag = DisposeBag()

test("Operator: withLatestFrom") {

    let source = PublishSubject<Int>()
    let notifier = PublishSubject<Bool>()

    let observable = notifier.debug("notifier")
        .withLatestFrom(source.debug("source"))
        .debug("withLatestFrom")

    print("****before subscribe*****")
    let dispose = observable.subscribe { print($0) }

//    source.onNext(2)
    notifier.onNext(false)
    //    source.onNext(3)
    source.onNext(4)

    notifier.onNext(true)
//    source.onCompleted()
//    source.onError(MyError.oneError)
    notifier.onNext(true)
    source.onNext(5)

    print("****before dispose*****")
    dispose.dispose()

}

test("Operator: zip") {
    let source1 = PublishSubject<Int>()
    let source2 = PublishSubject<Bool>()

    let observable = Observable.zip(source1.debug("sourceAAAAA"), source2.debug("sourceBBBB"), resultSelector: { "\($0)---\($1)" })
        .debug("zip")

    print("****before subscribe*****")
    let dispose = observable.subscribe { print($0) }

    source1.onNext(2)
    source1.onNext(4)
    source1.onNext(5)

    source2.onNext(false)
    source2.onNext(true)
    source1.onCompleted()
//    source2.onCompleted()
    //    source2.onError(MyError.oneError)

    source2.onNext(true)

    print("****before dispose*****")
    dispose.dispose()
}

test("Operator: switchLatest") {
    let source1 = PublishSubject<Int>()
    let source2 = PublishSubject<Int>()

    let subject = BehaviorSubject(value: source1.debug("sourceAAAAA"))

    let observable = subject
        .switchLatest()
        .debug("switchLatest")

    print("****before subscribe*****")
    let dispose = observable.subscribe { print($0) }

    source1.onNext(2)
    source1.onNext(4)

    source2.onNext(12)

    subject.onNext(source2.debug("sourceBBBBB"))
    source2.onNext(23)
    //    source1.onCompleted()
//        source2.onCompleted()
    source2.onError(MyError.oneError)
    source2.onCompleted()

    source2.onNext(34)

    print("****before dispose*****")
    dispose.dispose()
}

test("Operator: startWith") {
    let source1 = PublishSubject<Int>()

    let observable = source1
        .startWith(0)
        .debug("merge")

    print("****before subscribe*****")
    let dispose = observable.subscribe { print($0) }

    source1.onNext(2)
    source1.onCompleted()
//    source1.onError(MyError.oneError)
//
//    source1.onNext(34)

    print("****before dispose*****")
    dispose.dispose()
}

test("Operator: merge") {
    let source1 = PublishSubject<Int>()
    let source2 = PublishSubject<Int>()

    let observable = Observable.of(source1.debug("sourceAAAAA"), source2.debug("sourceBBBB"))
        .merge()
        .debug("merge")

    print("****before subscribe*****")
    let dispose = observable.subscribe { print($0) }

    source1.onNext(2)
    source1.onNext(4)

    source2.onNext(12)
    source2.onNext(23)
//    source1.onCompleted()
//    source2.onCompleted()
        source2.onError(MyError.oneError)

    source2.onNext(34)

    print("****before dispose*****")
    dispose.dispose()
}

test("Operator: combineLatest") {
    let source1 = PublishSubject<Int>()
    let source2 = PublishSubject<Bool>()

    let observable = Observable.combineLatest(source1.debug("sourceAAAAA"), source2.debug("sourceBBBB"), resultSelector: { "\($0)---\($1)" })
        .debug("combineLatest")

    print("****before subscribe*****")
    let dispose = observable.subscribe { print($0) }

    source1.onNext(2)
    source1.onNext(4)

    source2.onNext(false)
    source2.onNext(true)
    source1.onCompleted()
    source2.onCompleted()
//    source2.onError(MyError.oneError)

    source2.onNext(true)

    print("****before dispose*****")
    dispose.dispose()
}
