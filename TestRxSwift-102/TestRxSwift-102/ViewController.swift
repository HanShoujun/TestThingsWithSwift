//
//  ViewController.swift
//  TestRxSwift-102
//
//  Created by hsj on 2019/6/23.
//  Copyright © 2019 hsj. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var textField: UITextField!

    let disposeBag = DisposeBag()

    var sum = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        /// Error : 直接发送一个Error
        enum MyError: Error {
            case oneError
        }

        class AnyDisposable: Disposable {
            let _dispose: () -> Void

            init(_ disposable: Disposable) {
                _dispose = disposable.dispose
            }

            func dispose() {
                _dispose()
            }
        }

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
            //        source.onError(MyError.oneError)
            other.onNext(7)
        })

        delay(5, closure: {
            print("****before dispose*****")
            dispose.dispose()
        })
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    @IBAction func click(_ sender: Any) {
        configTimeDown()
    }

    func configTimeDown() {
        var dispose: Disposable?
        dispose = Observable<Int>.interval(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
            .subscribe {[weak self] (_) in
                guard let self = self else { return }
                self.sum += 1

                if self.sum >= 8 {
                    self.sum = 0
                    dispose?.dispose()
                }
        }
    }

}

