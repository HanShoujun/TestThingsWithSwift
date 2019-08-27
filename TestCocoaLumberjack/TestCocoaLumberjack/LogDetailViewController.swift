//
//  LogDetailViewController.swift
//  TestCocoaLumberjack
//
//  Created by zero on 2019/8/14.
//  Copyright © 2019 hsj. All rights reserved.
//

import UIKit
import CocoaLumberjack

class LogDetailViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!

    var info: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        if let info = info {
            do{
                let content = try String(contentsOfFile: info)
                textView.text = content
            }catch {
                print(error)
            }
        }

    }

}
