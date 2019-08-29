//
//  YYSCNavigationController.swift
//  QJAutoFinance_Swift
//
//  Created by hsj on 2019/5/17.
//  Copyright © 2019年 hsjperson. All rights reserved.
//

import Foundation
import UIKit

class YYSCNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        interactivePopGestureRecognizer?.delegate = self
    }
}

extension YYSCNavigationController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        otherGestureRecognizer.require(toFail: gestureRecognizer)
        return false
    }
}
