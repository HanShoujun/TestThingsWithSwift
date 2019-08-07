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

test("ControlProperty") {

    let behavior = BehaviorRelay(value: "124")
    let field = UITextField(frame: CGRect(x: 50, y: 50, width: 200, height: 50))
    field.backgroundColor = .white
    let controlProperty = field.rx.text.distinctUntilChanged({ (<#String?#>, <#String?#>) -> Bool in
        <#code#>
    })

    print("****before subscribe*****")
    let dispose = controlProperty.subscribe({ (event) in
        print(event)
    })

    let dispose2 = behavior.bind(to: controlProperty)
    behavior.accept("234")
    field.sendActions(for: .valueChanged)

    print("****before dispose*****")
    dispose.dispose()
    dispose2.dispose()

    PlaygroundPage.current.liveView = field
}

test("Driver") {

    let source = PublishSubject<Int>()
    let driver = source.debug("source")
        .asDriver(onErrorJustReturn: 9).debug("driver")

    print("****before subscribe*****")
    let dispose = driver.drive(onNext: { (element) in
        print(element)
    })

    source.onNext(2)
     source.onNext(3)
    source.onError(MyError.oneError)
    source.onCompleted()

    print("****before dispose*****")
    dispose.dispose()
}

test("Single") {

    let source = PublishSubject<Int>()
    let single = source.debug("source")
        .asSingle().debug("single")

    print("****before subscribe*****")
    let dispose = single.subscribe({ (event) in
        print(event)
    })

//    source.onNext(2)
//    source.onNext(3)
//    source.onError(MyError.oneError)
    source.onCompleted()

    print("****before dispose*****")
    dispose.dispose()
}

test("Single: create") {
    /// create：闭包形式，创建的序列
        let single = Single<Int>.create(subscribe: { (handler) -> Disposable in
            handler(.success(2))
//            handler(.error(MyError.oneError))
            return Disposables.create()
        })

//    let source = PublishSubject<Int>()
//    let single = source.debug("source")
//        .asSingle().debug("single")

    print("****before subscribe*****")
    let dispose = single.debug()
        .subscribe({ (event) in
            print(event)
        })

    //    source.onNext(2)
    //    source.onNext(3)
//    source.onError(MyError.oneError)
    //    source.onCompleted()

    print("****before dispose*****")
    dispose.dispose()
}


//: [Next](@next)
