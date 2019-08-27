//
//  ViewController.swift
//  TestCocoaLumberjack
//
//  Created by zero on 2019/8/14.
//  Copyright © 2019 hsj. All rights reserved.
//

import UIKit
import CocoaLumberjack

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

    }

    @IBAction func click(_ sender: Any) {
        DDLogVerbose("Verbose")
        DDLogDebug("Debug")
        DDLogInfo("Info")
        DDLogWarn("Warn")
        DDLogError("Error")

        print(LoggerManager.shared.logPaths)
    }
    
    @IBAction func roll(_ sender: Any) {
        guard let path = LoggerManager.shared.logPaths.first else {
            return
        }
        LoggerManager.shared.deleteLog(path)
    }

}

