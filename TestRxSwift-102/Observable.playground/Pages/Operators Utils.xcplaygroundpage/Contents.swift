//: [Previous](@previous)

import Foundation
import PlaygroundSupport
import RxSwift
import RxCocoa

class AnyDisposable: Disposable {
    let _dispose: () -> Void

    init(_ disposable: Disposable) {
        _dispose = disposable.dispose
    }

    func dispose() {
        _dispose()
    }
}

enum MyError: Error {
    case oneError
}

let disposeBag = DisposeBag()

test("Operator: using") {

    let source = PublishSubject<Int>()
    let other = PublishSubject<Int>()

    let observable = Observable.using({
        return AnyDisposable(source.debug("source").subscribe { print($0) })
    }, observableFactory: { _ in
        return other.debug("other")
    }).debug("using")

    source.onNext(4)
    print("****before subscribe*****")
    let dispose = observable
        .subscribe(onNext: { print($0) })

    source.onNext(5)
    //    source.onError(MyError.oneError)
    delay(2, closure: {
//        source.onNext(5)

        other.onNext(7)
//        other.onError(MyError.oneError)
        other.onCompleted()
    })

    delay(5, closure: {
        print("****before dispose*****")
        dispose.dispose()
    })

}

test("Operator: timeout") {

    let source = PublishSubject<Int>()
    let other = PublishSubject<Int>()

    let observable = source.debug("source")
        .timeout(RxTimeInterval.seconds(1), other: other.debug("other"), scheduler: MainScheduler.instance)
        .debug("timeout")

    source.onNext(4)
    print("****before subscribe*****")
    let dispose = observable
        .subscribe(onNext: { print($0) })

    source.onNext(5)
//    source.onError(MyError.oneError)
    delay(2, closure: {
        //        source.onNext(5)
//        source.onError(MyError.oneError)
        other.onNext(7)
    })

    delay(4, closure: {
        print("****before dispose*****")
        dispose.dispose()
    })

}

test("Operator: subscribeOn observeOn") {

    let source = PublishSubject<Int>()

    let observable = source
        .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .userInitiated))
        .observeOn(MainScheduler.instance)
        .debug()

    source.onNext(4)
    print("****before subscribe*****")
    let dispose = observable
        .subscribe(onNext: { print($0) })

    source.onNext(5)
    delay(2, closure: {
        source.onNext(6)
    })

    print("****before dispose*****")
    dispose.dispose()

}

test("Operator: delaySubscription") {

    let source = PublishSubject<Int>()

    let observable = source
        .delaySubscription(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
        .debug()

    source.onNext(4)
    print("****before subscribe*****")
    let dispose = observable
        .subscribe(onNext: { print($0) })

    source.onNext(5)
    delay(2, closure: {
        //        source.onNext(5)
        source.onNext(6)
    })

    print("****before dispose*****")
    //    dispose.dispose()

}

test("Operator: delay") {

    let source = PublishSubject<Int>()

    let observable = source
        .delay(RxTimeInterval.milliseconds(1000), scheduler: MainScheduler.instance)
        .debug()

    source.onNext(4)
    print("****before subscribe*****")
    let dispose = observable
        .subscribe(onNext: { print($0) })

    source.onNext(5)
    delay(2, closure: {
//        source.onNext(5)
        source.onNext(6)
    })

    print("****before dispose*****")
//    dispose.dispose()

}
