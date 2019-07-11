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

