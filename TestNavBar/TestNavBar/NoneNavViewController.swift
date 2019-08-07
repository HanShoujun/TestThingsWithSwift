//
//  NoneNavViewController.swift
//  TestNavBar
//
//  Created by zero on 2019/8/5.
//  Copyright © 2019 hsj. All rights reserved.
//

import UIKit

class NoneNavViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    @IBAction func click(_ sender: Any) {
        setNeedsStatusBarAppearanceUpdate()
    }
}
