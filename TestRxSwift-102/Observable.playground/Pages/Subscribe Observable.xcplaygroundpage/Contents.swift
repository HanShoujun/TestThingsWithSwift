//: [Previous](@previous)

import Foundation
import RxSwift
import RxCocoa

let disposeBag = DisposeBag()

test("Subscribe Observable") {
    let observable = Observable.of(1,2,3,4,5)

    observable.subscribe({ (event) in
        print(event)
    })

    observable.subscribe(onNext: { (element) in
        print(element)
    })
}

test("live circle ") {
    let observable = Observable.of(1,2,3,4,5)

    let dispose = observable.do(onNext: { (element) in
        print("Intercepted next:\(element)")
    }, afterNext: { (element) in
        print("Intercepted after:\(element)")
    }, onError: { (error) in
        print("Intercepted onerror:\(error)")
    }, afterError: { (error) in
        print("Intercepted aftererror:\(error)")
    }, onCompleted: {
        print("Intercepted oncompleted")
    }, afterCompleted: {
        print("Intercepted aftercompleted")
    }, onSubscribe: {
        print("Intercepted onsubscribe")
    }, onSubscribed: {
        print("Intercepted onsubscribed")
    }, onDispose: {
        print("Intercepted ondispose")
    }).subscribe(onNext: { (element) in
        print(element)
    }, onError: { (error) in
        print(error)
    }, onCompleted: {
        print("completed")
    }, onDisposed: {
        print("disposed")
    })
    dispose.dispose()

}

test("dispose") {
    let observable = Observable.of(1,2,3,4,5)
    let dispose = observable.subscribe({ (event) in
        print(event)
    })
    dispose.dispose()
}

test("DisposeBag") {
    let disposeBag = DisposeBag()
    let observable = Observable.of(1,2,3)
    observable.subscribe({ (event) in
        print(event)
    }).disposed(by: disposeBag)
}
