//
//  LoginViewController.swift
//  TestLineSDK
//
//  Created by hsj on 2019/5/31.
//  Copyright © 2019年 hsj. All rights reserved.
//

import UIKit
import LineSDK

class LoginViewController: UIViewController, IndicatorDisplay {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

    }

    @IBAction func share(_ sender: Any) {
        guard LineKit.isLineInstalled else {
            UIAlertController.present(in: self, successResult: "还未安装Line")
            return
        }
        LineKit.sendMessage(message: "http://www.ireaderbook.com/shareinfo.html")
    }

    @IBAction func click(_ sender: Any) {
        if LoginManager.shared.isAuthorizing {
            return
        }
        LoginManager.shared.login(permissions: [.profile, .gender, .openID], in: self) {[weak self] result in
            switch result {
            case .success(let loginResult):
                print(loginResult)
            case .failure(let error):
                print(error)
            }
            self?.hideIndicator()
        }
        showIndicator()
    }

}
