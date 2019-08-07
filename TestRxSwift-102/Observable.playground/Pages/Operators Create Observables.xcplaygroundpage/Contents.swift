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

test("Operators: create") {
    /// create：闭包形式，创建的序列
    var observer: AnyObserver<Int>?
    let createObservable = Observable<Int>.create({ (ob) -> Disposable in
        observer = ob
        return Disposables.create()
    }).debug()
    print(observer)
    observer?.onNext(1)

    print("****before subscribe*****")
    let dispose = createObservable.subscribe(handler)

    observer?.onNext(3)

    print("****before dispose*****")
    dispose.dispose()
}

test("Operators: just") {
    /// Just
    let justObservable = Observable.just(5).debug()

    print("****before subscribe*****")
    let dispose = justObservable.subscribe(handler)

    print("****before dispose*****")
    dispose.dispose()
}

test("Operators: of") {
    /// Of
    let ofObservable = Observable.of(1,2,3,4,5).debug()

    print("****before subscribe*****")
    let dispose = ofObservable.subscribe(handler)

    print("****before dispose*****")
    dispose.dispose()
}

test("Operators: from") {
    /// From
    let fromObservable = Observable.from([1,2,3,4,5]).debug()

    print("****before subscribe*****")
    let dispose = fromObservable.subscribe(handler)

    print("****before dispose*****")
    dispose.dispose()
}

test("Operators: empty") {
    /// Empty ：空内容的序列，只发送一个completed事件
    let emptyObservable = Observable<Any>.empty().debug()

    print("****before subscribe*****")
    let dispose = emptyObservable.subscribe(handler)

    print("****before dispose*****")
    dispose.dispose()
}

test("Operators: never") {
    /// Empty ：空内容的序列，只发送一个completed事件
    let neverObservable = Observable<Any>.never().debug()

    print("****before subscribe*****")
    let dispose = neverObservable.subscribe(handler)

    print("****before dispose*****")
    dispose.dispose()
}

test("Operators: error") {
    /// Error : 直接发送一个Error
    enum MyError: Error {
        case oneError
    }
    let errorObservable = Observable<Any>.error(MyError.oneError).debug()

    print("****before subscribe*****")
    let dispose = errorObservable.subscribe(handler)

    print("****before dispose*****")
    dispose.dispose()
}

test("Operators: deferred") {
    /// Deferred: 每次订阅，是订阅了指定闭包创建的序列。闭包为创建序列工厂方法，达到延迟创建的目的
    var isOdd = true
    let deferredObservable = Observable.deferred({ () -> Observable<Int> in
        isOdd.toggle()
        if isOdd {
            return Observable.of(1, 3 ).debug("关联数据源AAAAA")
        }else {
            return Observable.of(2, 4 ).debug("关联数据源BBBBB")
        }
    }).debug("原数据源")

    print("****before subscribe*****")
    let dispose1 = deferredObservable.subscribe(handler)
    let dispose2 = deferredObservable.subscribe(handler)

    print("****before dispose*****")
    dispose1.dispose()
    dispose2.dispose()
}

//test("Operators: interval") {
//    /// interval：
//    let interval = RxTimeInterval.seconds(1)
//    let scheduler = MainScheduler.instance
//    let intervalObservable = Observable<Int>.interval(interval, scheduler: scheduler).debug()
//
//    print("****before subscribe*****")
//    let dispose = intervalObservable.subscribe(handler)
//
//    print("****before dispose*****")
//    delay(3, closure: {
//        dispose.dispose()
//    })
//}

test("Operators: timer") {
    /// interval：
    let interval = RxTimeInterval.seconds(1)
    let scheduler = MainScheduler.instance
    let intervalObservable = Observable<Int>.timer(interval, period: interval, scheduler: scheduler)

    print("****before subscribe*****")
    let dispose = intervalObservable.subscribe(handler)

    print("****before dispose*****")
    delay(3, closure: {
        dispose.dispose()
    })
}

test("Create Observable") {

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

}


