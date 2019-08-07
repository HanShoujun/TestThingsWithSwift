//
//  TestDelayViewController.swift
//  TestRxSwift-102
//
//  Created by zero on 2019/7/15.
//  Copyright © 2019 hsj. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TestDelayViewController: UIViewController {

    let source = PublishSubject<Double>()

    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let delayOb = source.delay(RxTimeInterval.seconds(2), scheduler: MainScheduler.instance).debug()

        delayOb.subscribe{ print($0) }
            .disposed(by: disposeBag)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func buttonClick(_ sender: Any) {
        let time = Date().timeIntervalSince1970
        source.onNext(time)
    }

}
