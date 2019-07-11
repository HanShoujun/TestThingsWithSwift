//: [Previous](@previous)

import UIKit
import RxSwift
import RxCocoa

let disposeBag = DisposeBag()

enum MyError: Error {
    case oneError
}

test("AsyncSubject") {

    var observer: AnyObserver<Int>?
    let ofObservable = Observable<Int>.create({ (ob) -> Disposable in
        observer = ob
        return Disposables.create()
    })

    let asyncSubject = AsyncSubject<Int>()


    observer?.onNext(1)

    ofObservable
        .subscribe(asyncSubject)
        .disposed(by: disposeBag)

    observer?.onNext(2)

    //observer?.onCompleted()

    asyncSubject.subscribe({ (event) in
        print(event)
    }).disposed(by: disposeBag)


    observer?.onNext(3)
    observer?.onCompleted()
}

test("PublishSubject") {
    var observer: AnyObserver<Int>?
    let observable = Observable<Int>.create({ (ob) -> Disposable in
        observer = ob
        return Disposables.create()
    })

    let publishSubject = PublishSubject<Int>()

    observable
        .subscribe(publishSubject)
        .disposed(by: disposeBag)

    observer?.onNext(1)
    observer?.onNext(2)

    publishSubject.subscribe({ (event) in
        print(event)
    }).disposed(by: disposeBag)


    observer?.onNext(3)
    observer?.onNext(4)
    observer?.onCompleted()
}

test("ReplaySubject") {
    var observer: AnyObserver<Int>?
    let observable = Observable<Int>.create({ (ob) -> Disposable in
        observer = ob
        return Disposables.create()
    })

    let replaySubject = ReplaySubject<Int>.createUnbounded()

    observable
        .subscribe(replaySubject)
        .disposed(by: disposeBag)

    observer?.onNext(1)
    observer?.onNext(2)

    replaySubject.subscribe({ (event) in
        print(event)
    }).disposed(by: disposeBag)


    observer?.onNext(3)
    observer?.onNext(4)
    observer?.onCompleted()
}

test("BehaviorSubject") {
    var observer: AnyObserver<Int>?
    let observable = Observable<Int>.create({ (ob) -> Disposable in
        observer = ob
        return Disposables.create()
    })

    let behaviorSubject = BehaviorSubject<Int>(value: 0)

    observable
        .subscribe(behaviorSubject)
        .disposed(by: disposeBag)

    observer?.onNext(1)
    observer?.onNext(2)

    behaviorSubject.subscribe({ (event) in
        print(event)
    }).disposed(by: disposeBag)

    observer?.onNext(3)
    observer?.onNext(4)
    observer?.onError(MyError.oneError)
    observer?.onCompleted()
}

test("BehaviorRelay") {

    let behaviorRelay = BehaviorRelay(value: 0)

    behaviorRelay.accept(1)
    behaviorRelay.accept(2)

    behaviorRelay.subscribe({ (event) in
        print(event)
    }).disposed(by: disposeBag)

    behaviorRelay.accept(3)
    behaviorRelay.accept(4)

}
