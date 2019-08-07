//: [Previous](@previous)

import Foundation
import PlaygroundSupport
import RxSwift
import RxCocoa

enum MyError: Error {
    case oneError
}

let disposeBag = DisposeBag()

test("Operator: retry") {

    var count = 1
    let source = Observable<String>.create { observer in
        observer.onNext("a")
        observer.onNext("b")

        //让第一个订阅时发生错误
        if count == 1 {
            observer.onError(MyError.oneError)
            print("Error encountered")
            count += 1
        }

        observer.onNext("c")
        observer.onNext("d")
        observer.onError(MyError.oneError)
        return Disposables.create()
    }

    let observable = source.debug("source")
        .retry(1)
        .debug("using")

//    source.onNext(4)
    print("****before subscribe*****")
    let dispose = observable
        .subscribe(onNext: { print($0) })

//    source.onNext(5)
//    delay(2, closure: {
//        source.onNext(7)
//        source.onError(MyError.oneError)
//        source.onNext(8)
//    })

    delay(5, closure: {
        print("****before dispose*****")
        dispose.dispose()
    })

}

test("Operator: catchError") {

    let source = PublishSubject<Int>()
    let other = PublishSubject<Int>()

    let observable = source.debug("source")
        .catchError({ (_) -> Observable<Int> in
            return other.debug("other")
        })
        .debug("using")

    source.onNext(4)
    print("****before subscribe*****")
    let dispose = observable
        .subscribe(onNext: { print($0) })

    source.onNext(5)
    delay(2, closure: {
        source.onNext(7)
        source.onError(MyError.oneError)
//        source.onCompleted()
    })

    delay(3, closure: {
        other.onNext(8)
        other.onError(MyError.oneError)
//        source.onCompleted()
    })

    delay(5, closure: {
        print("****before dispose*****")
        dispose.dispose()
    })

}

test("Operator: catchErrorJustReturn") {

    let source = PublishSubject<Int>()
    let other = PublishSubject<Int>()

    let observable = source
        .catchErrorJustReturn(9)
        .debug("using")

    source.onNext(4)
    print("****before subscribe*****")
    let dispose = observable
        .subscribe(onNext: { print($0) })

    source.onNext(5)
    delay(2, closure: {
        source.onNext(7)
        source.onError(MyError.oneError)
        source.onCompleted()
    })

    delay(5, closure: {
        print("****before dispose*****")
        dispose.dispose()
    })

}

//: [Next](@next)
