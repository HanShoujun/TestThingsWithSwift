//: [Previous](@previous)

import UIKit
import RxSwift
import RxCocoa
import PlaygroundSupport

let disposeBag = DisposeBag()

test("create Observer: subscribe") {
    let observable = Observable.of(1,2,3,4,5)

    observable.subscribe(onNext: { (element) in
        print(element)
    }, onError: { (error) in
        print(error)
    }, onCompleted: {
        print("completed")
    }, onDisposed: {
        print("disposed")
    }).disposed(by: disposeBag)


}

test("create observer: bind") {
    let observable = Observable.of(1,2,3,4,5)

    observable.bind(onNext: { (element) in
        print(element)
    }).disposed(by: disposeBag)

    let varInt = BehaviorRelay(value: 0)
    observable.bind(to: varInt).disposed(by: disposeBag)

    varInt.subscribe({ (event) in
        print(event)
    })
}

test("create observer: AnyObserver") {

    let observer: AnyObserver<Int> = AnyObserver(eventHandler: { (event) in
        switch event {
        case .next(let data):
            print(data)
        case .error(let error):
            print(error)
        case .completed:
            print("completed")
        }
    })

    let observable = Observable.of(1,2,3,4,5)

    observable.subscribe(observer).disposed(by: disposeBag)

}

test("create observer: Binder") {
    let observable = Observable.of(1,2,3,4,5)

    let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
    label.backgroundColor = .white

    let binder = Binder<String>(label, binding: { (label, text) in
        label.text = text
    })

    observable
        .map { "\($0)" }
        .subscribe(binder)
        .disposed(by: disposeBag)

    PlaygroundPage.current.liveView = label

    let boolObservable = Observable.just(true)

    let button = UIButton(type: .system)

    boolObservable
        .bind(to: button.rx.isEnabled)
        .disposed(by: disposeBag)
}
