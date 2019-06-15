//
//  ViewController.swift
//  TestLineSDK
//
//  Created by hsj on 2019/5/30.
//  Copyright © 2019年 hsj. All rights reserved.
//

import UIKit
import LineSDK

class ViewController: UIViewController, IndicatorDisplay {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let loginButton = LoginButton()

        loginButton.delegate = self
        loginButton.presentingViewController = self

        // You could set the permissions you need or use default permissions
        loginButton.permissions = [.profile, .friends, .groups, .messageWrite, .openID]

        view.addSubview(loginButton)

        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }


}

extension ViewController: LoginButtonDelegate {

    func loginButton(_ button: LoginButton, didSucceedLogin loginResult: LoginResult) {
        hideIndicator()
        UIAlertController.present(in: self, successResult: "\(loginResult)") {
//            NotificationCenter.default.post(name: .userDidLogin, object: loginResult)
        }
    }

    func loginButton(_ button: LoginButton, didFailLogin error: Error) {
        hideIndicator()
        UIAlertController.present(in: self, error: error)
    }

    func loginButtonDidStartLogin(_ button: LoginButton) {
        showIndicator()
    }

}

