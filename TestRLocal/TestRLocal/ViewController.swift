//
//  ViewController.swift
//  TestRLocal
//
//  Created by hsj on 2019/6/13.
//  Copyright © 2019 hsj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print(R.string.testlocalizable.bookshelf.localized("en"))
    }

    @IBAction func toEnglish(_ sender: Any) {
        label.text = R.string.testlocalizable.bookshelf.localized("en")
    }

    @IBAction func toSimple(_ sender: Any) {
        label.text = R.string.testlocalizable.bookshelf.localized("zh-Hans")
    }

    @IBAction func toTrantion(_ sender: Any) {
        label.text = R.string.testlocalizable.bookshelf.localized("zh-HK")
    }



}

import Foundation
import Rswift

extension StringResource {
    public func localized(_ language: String) -> String {
        guard
            let basePath = bundle.path(forResource: "Base", ofType: "lproj"),
            let baseBundle = Bundle(path: basePath)
            else {
                return self.key
        }

        let fallback = baseBundle.localizedString(forKey: key, value: key, table: tableName)

        guard
            let localizedPath = bundle.path(forResource: language, ofType: "lproj"),
            let localizedBundle = Bundle(path: localizedPath)
            else {
                return fallback
        }

        return localizedBundle.localizedString(forKey: key, value: fallback, table: tableName)
    }
}
