//
//  NormalViewController.swift
//  TestNaviBar
//
//  Created by zero on 2019/8/27.
//  Copyright © 2019 hsj. All rights reserved.
//

import UIKit

class NormalViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        title = "普通"

        view.backgroundColor = .white
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(false, animated: true)
    }

}
