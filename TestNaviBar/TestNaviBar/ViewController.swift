//
//  ViewController.swift
//  TestNaviBar
//
//  Created by zero on 2019/8/27.
//  Copyright © 2019 hsj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    let titles = ["正常导航栏",
                        "自定义导航栏"]

    var testColor: UIColor = .white {
        didSet {
            print(testColor)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "主页"

        testColor = .blue

        print("status H:\(SCScreen.statusBarHeight)")
        print("status:\(UIApplication.shared.statusBarFrame.height)")
        print("navi bar H:\(SCScreen.naviBarHeight)")
        print("navi bar:\(navigationController?.navigationBar.frame.height ?? 0)")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(false, animated: true)
    }

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = titles[indexPath.row]
        return cell
    }

}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        if indexPath.row == 0 {
//            let nav = YYSCNavigationController(rootViewController: NormalViewController())
//            self.navigationController?.present(nav, animated: true, completion: nil)
            let vc = NormalViewController()
            navigationController?.pushViewController(vc, animated: true)
        } else {
//            let nav = YYSCNavigationController(rootViewController: CustomNaviViewController())
//            self.navigationController?.present(nav, animated: true, completion: nil)
            let vc = CustomNaviViewController()
            navigationController?.pushViewController(vc, animated: true)
        }

    }
}

