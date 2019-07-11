//: [Previous](@previous)

import Foundation
import PlaygroundSupport
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

let disposeBag = DisposeBag()

test("Create Observable") {
    /// Just
//    let observable = Observable.just(5).debug()
    /// Of
//    let observable = Observable.of(1,2,3,4,5).debug()
    /// from
//    let observable = Observable.from([1,2,3,4,5]).debug()
    /// Generate
//    let observable = Observable.generate(
//        initialState: 0,
//        condition: { $0 < 10 },
//        iterate: { $0 + 3 }
//    ).debug()
    /// create：闭包形式，创建的序列
//    let observable = Observable<Any>.create({ (observer) -> Disposable in
//        print("start")
//        observer.onNext("hello")
//        observer.onCompleted()
//        return Disposables.create()
//    }).debug()

    /// Deferred: 每次订阅，是订阅了指定闭包创建的序列。闭包为创建序列工厂方法，达到延迟创建的目的
//    var isOdd = true
//    let observable = Observable.deferred({ () -> Observable<Int> in
//        isOdd.toggle()
//        print("start")
//        if isOdd {
//            return Observable.of(1, 3, 5 ,7)
//        }else {
//            return Observable.of(2, 4, 6, 8)
//        }
//    }).debug()

    /// interval：
//    let observable = Observable<Int>
//        .interval(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
//        .debug()

//    let subject = PublishSubject<Int>()
//    let observable = subject.debug()
//    subject.onNext(1)
//
//    observable.subscribe(handler).disposed(by: disposeBag)
//    subject.onNext(2)
//
//    delay(2, closure: {
//         observable.subscribe(handler).disposed(by: disposeBag)
//    })
//    delay(3, closure: {
//        subject.onNext(3)
//    })

//    let publishSubject = PublishSubject<Int>()
//
//    let observable = publishSubject
//        .asObservable()
//        .buffer(timeSpan: RxTimeInterval.seconds(1), count: 3, scheduler: MainScheduler.instance)
//        .debug("buffer")
//
//    publishSubject.onNext(1)
//    publishSubject.onNext(2)
//
//    observable.subscribe(handler).disposed(by: disposeBag)
//    publishSubject.onNext(3)
//    publishSubject.onNext(4)
//
//    delay(2, closure: {
//        publishSubject.onNext(5)
//        observable.subscribe(handler).disposed(by: disposeBag)
//        publishSubject.onNext(6)
//        publishSubject.onNext(7)
//        publishSubject.onNext(8)
//        publishSubject.onCompleted()
//    })

    let ofObservable = Observable.of(9)
    let publishSubject = PublishSubject<Int>()

    let observable = publishSubject.asObserver()
        .flatMapLatest({ (_) in
            return ofObservable
        }).debug()

    publishSubject.onNext(1)
    publishSubject.onNext(2)

    observable.subscribe(handler).disposed(by: disposeBag)

    delay(2, closure: {
        publishSubject.onNext(5)
        observable.subscribe(handler).disposed(by: disposeBag)
        publishSubject.onNext(6)
        publishSubject.onNext(6)
        publishSubject.onNext(6)
        publishSubject.onCompleted()
    })

}
