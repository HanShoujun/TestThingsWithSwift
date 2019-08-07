//
//  TestTwoViewController.swift
//  TestNavBar
//
//  Created by zero on 2019/8/5.
//  Copyright © 2019 hsj. All rights reserved.
//

import UIKit

class TestTwoViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "TestTwo"

        self.scnav.tintColor = .purple
        self.scnav.bgAlpha = 1
        self.scnav.statusBarStyle = .default
        self.scnav.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.cyan]
        
    }
    
    // MARK:
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return scnav.statusBarStyle
    }
    

}
