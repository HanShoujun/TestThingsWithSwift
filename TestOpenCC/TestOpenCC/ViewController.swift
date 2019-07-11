//
//  ViewController.swift
//  TestOpenCC
//
//  Created by zero on 2019/7/11.
//  Copyright © 2019 hsj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let openccService = OpenCCService(converterType: OpenCCServiceConverterType.S2T)

    @IBOutlet weak var original: UILabel!
    @IBOutlet weak var convert: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        original.text = "燕燕于飞差池其羽之子于归远送于野"
        convert.text = openccService?.convert("燕燕于飞差池其羽之子于归远送于野")

    }


}

