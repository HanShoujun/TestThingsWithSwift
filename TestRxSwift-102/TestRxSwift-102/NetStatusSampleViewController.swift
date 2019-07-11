//
//  NetStatusSampleViewController.swift
//  TestRxSwift-102
//
//  Created by zero on 2019/7/7.
//  Copyright © 2019 hsj. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class NetStatusSampleViewController: UIViewController {

    @IBOutlet weak var netStatusLabel: UILabel!
    @IBOutlet weak var netSwitch: UISwitch!
    @IBOutlet weak var sendButton1: UIButton!
    @IBOutlet weak var sendStatusLabel: UILabel!
    @IBOutlet weak var sendActivityView: UIActivityIndicatorView!

    let disposeBag = DisposeBag()
    let online = BehaviorRelay(value: false)

    let request = Observable<String>.create { (observer) in
        print("create")
        delay(2, closure: {
            observer.onNext("ok")
        })
        return Disposables.create()
        }.debug("请求状态：")

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        _ = netSwitch.rx.isOn <-> online

        sendButton1.rx.tap
            .flatMapLatest {[weak self] (_) -> Observable<String> in
                guard let self = self else { return Observable.just("") }
                return self.send()
            }
            .bind(to: sendStatusLabel.rx.text)
            .disposed(by: disposeBag)

    }

    func send() -> Observable<String> {
        let source = online
            .debug("网络状态：")
            .filter { $0 }
            .take(1)
            .flatMapLatest {[weak self] (_) -> Observable<String> in
                guard let self = self else { return Observable.just("") }
                return self.request
            }
        return source
    }

}

public func delay(_ delay: Double, closure: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
        closure()
    }
}

enum MyError: Error {
    case testError
}
