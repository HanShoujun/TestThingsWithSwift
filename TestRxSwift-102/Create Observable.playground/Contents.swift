//: A UIKit based Playground for presenting user interface
  
import UIKit
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
    let justObservable = Observable.just(5)
    justObservable.subscribe(handler).disposed(by: disposeBag)

    /// Of
    let ofObservable = Observable.of(1,2,3,4,5)
    ofObservable.subscribe(handler).disposed(by: disposeBag)

    /// From
    let fromObservable = Observable.from([1,2,3,4,5])
    let dic = ["a" : 123, "b" : 234 ]
    let fromObservable2 = Observable.from(dic)
    fromObservable.subscribe(handler).disposed(by: disposeBag)
    fromObservable2.subscribe(handler).disposed(by: disposeBag)

    /// Empty ：空内容的序列，只发送一个completed事件
    let emptyObservable = Observable<Any>.empty()
    emptyObservable.subscribe(handler).disposed(by: disposeBag)

    /// Never ： 什么都不发送，也不会终止
    let neverObservable = Observable<Any>.never()
    neverObservable.subscribe(handler).disposed(by: disposeBag)

    /// Error : 直接发送一个Error
    enum MyError: Error {
        case oneError
    }
    let errorObservable = Observable<Any>.error(MyError.oneError)
    errorObservable.subscribe(handler).disposed(by: disposeBag)

    /// Range : 包含指定起始位置的元素序列
    let rangeObservable = Observable.range(start: 1, count: 5)
    rangeObservable.subscribe(handler).disposed(by: disposeBag)

    /// Repeat : 会一直重复发送指定元素
    let _ = Observable.repeatElement(8)

    /// Generate: 按照初始化值，终止条件函数，元素之间关系函数，确定的序列
    let generateObservable = Observable.generate(
        initialState: 0,
        condition: { $0 < 10 },
        iterate: { $0 + 3 }
    )
    generateObservable.subscribe(handler).disposed(by: disposeBag)

    /// create：闭包形式，创建的序列
    let createObservable = Observable<Any>.create({ (observer) -> Disposable in
        observer.onNext("hello")
        observer.onCompleted()
        return Disposables.create()
    })
    createObservable.subscribe(handler).disposed(by: disposeBag)

    /// Deferred: 每次订阅，是订阅了指定闭包创建的序列。闭包为创建序列工厂方法，达到延迟创建的目的
    var isOdd = true
    let deferredObservable = Observable.deferred({ () -> Observable<Int> in
        isOdd.toggle()
        if isOdd {
            return Observable.of(1, 3, 5 ,7)
        }else {
            return Observable.of(2, 4, 6, 8)
        }
    })
    deferredObservable.subscribe(handler).disposed(by: disposeBag)
    deferredObservable.subscribe(handler).disposed(by: disposeBag)

    /// interval：
    let interval = RxTimeInterval.seconds(2)
    let scheduler = MainScheduler.instance
//    let intervalObservable = Observable.interval(interval, scheduler: scheduler)

    /// timer
//    let timerObservable = Observable.timer(interval, scheduler: scheduler)
    

}


