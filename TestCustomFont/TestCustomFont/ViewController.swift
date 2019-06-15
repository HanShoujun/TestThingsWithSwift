//
//  ViewController.swift
//  TestCustomFont
//
//  Created by hsj on 2019/6/14.
//  Copyright © 2019 hsj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var stackView: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        UIFont.familyNames.map { (family) in
            UIFont.fontNames(forFamilyName: family)
        }.flatMap{ $0 }.sorted().forEach { print($0) }

        let str = "汉字 下载 首测"

        let fontNames = ["FZFSFW--GB1-0",
                         "FZFSJW--GB1-0",
                         "FZKTFW--GB1-0",
                         "FZKTJW--GB1-0",
                         "FZSSFW--GB1-0",
                         "FZSSJW--GB1-0"]
        fontNames.compactMap { (name) in
                UIFont(name: name, size: 20)
            }.compactMap { (font) -> UILabel in
                    let label = UILabel(frame: .zero)
                    label.text = str
                    label.font = font
                return label
            }.forEach { (label) in
                stackView.addArrangedSubview(label)
            }

    }

}

