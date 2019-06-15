//
//  BarViewController.swift
//  TestCollection
//
//  Created by hsj on 2019/5/11.
//  Copyright © 2019年 hsj. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class BarViewController: ButtonBarPagerTabStripViewController {

    override func viewDidLoad() {

        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Bar"

        buttonBarView.selectedBar.backgroundColor = .orange
        buttonBarView.backgroundColor = UIColor(red: 7/255, green: 185/255, blue: 155/255, alpha: 1)

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let vc = MarketViewController(itemInfo: "男生")
        let vc2 = MarketViewController(itemInfo: "女生")

        return [vc, vc2]
    }

    override func reloadPagerTabStripView() {

        super.reloadPagerTabStripView()
    }

}
