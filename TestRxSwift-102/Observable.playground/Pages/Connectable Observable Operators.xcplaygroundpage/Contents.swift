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

test("Operator: share") {

    let source = PublishSubject<Int>()

    let observable = source.debug("source")
        .share(replay: 2, scope: SubjectLifetimeScope.whileConnected)
        .debug("share")

    print("****before subscribe*****")
    let dispose = observable
        .subscribe(onNext: { print($0) })

    //    source.onError(MyError.oneError)
    source.onNext(7)
    source.onNext(4)

    source.onCompleted()

    let dispose3 = observable
        .subscribe(onNext: { print($0) })

    source.onNext(5)
//    source.onCompleted()

    delay(3, closure: {
        print("****before dispose*****")
        dispose.dispose()
        dispose3.dispose()
    })

}

test("Operator: refCount") {

    let source = PublishSubject<Int>()

    let observable = source
        .debug("source")
        .publish()
        .refCount()
        .debug("refCount")

    print("****before subscribe*****")
    let dispose = observable
        .subscribe(onNext: { print($0) })

    //    source.onError(MyError.oneError)
    source.onNext(7)
    source.onNext(4)

    source.onCompleted()

    let dispose2 = observable
        .subscribe(onNext: { print($0) })

    source.onNext(5)

    delay(3, closure: {
        print("****before dispose*****")
        dispose.dispose()
        dispose2.dispose()
    })

}

test("Operator: multicast") {

    let source = PublishSubject<Int>()
    let other = PublishSubject<Int>()

    let dispose3 = other.debug("other")
        .subscribe(onNext: { print($0) })

    let observable = source
        .debug("multicast")
        .multicast(other)

    source.onNext(7)
    print("****before subscribe*****")
    let dispose = observable
        .subscribe(onNext: { print($0) })

    //    source.onError(MyError.oneError)
    print("****before connect*****")
    let dispose4 = observable.connect()
    source.onNext(4)

    source.onCompleted()

    let dispose2 = observable
        .subscribe(onNext: { print($0) })

    source.onNext(5)
    other.onNext(19)
    //    other.onCompleted()
//    other.onError(MyError.oneError)

    delay(3, closure: {
        print("****before dispose*****")
        dispose.dispose()
        dispose2.dispose()
        dispose3.dispose()
        dispose4.dispose()
    })

}

test("Operator: replay") {

    let source = PublishSubject<Int>()

    let observable = source
        .debug("replay")
        .replay(1)

    print("****before subscribe*****")
    let dispose = observable
        .subscribe(onNext: { print($0) })

    //    source.onError(MyError.oneError)
    source.onNext(5)
    print("****before connect*****")
    let dispose4 = observable.connect()
    source.onNext(7)
    source.onNext(4)

    source.onCompleted()
    
    let dispose2 = observable
        .subscribe(onNext: { print($0) })

    source.onNext(5)
//    source.onCompleted()

    delay(3, closure: {
        print("****before dispose*****")
        dispose.dispose()
        dispose2.dispose()
        dispose4.dispose()
    })

}

test("Operator: publish") {

    let source = PublishSubject<Int>()

    let observable = source
        .debug("publish")
        .publish()

    print("****before subscribe*****")
    let dispose = observable
        .subscribe(onNext: { print($0) })

    //    source.onError(MyError.oneError)
    print("****before connect*****")
    let dispose4 = observable.connect()
    source.onNext(7)
    source.onNext(4)

    let dispose2 = observable
        .subscribe(onNext: { print($0) })

    source.onNext(5)
//    source.onCompleted()

    delay(3, closure: {
        print("****before dispose*****")
        dispose.dispose()
        dispose2.dispose()
        dispose4.dispose()
    })

}


//: [Next](@next)
