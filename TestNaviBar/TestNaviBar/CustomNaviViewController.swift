//
//  CustomNaviViewController.swift
//  TestNaviBar
//
//  Created by zero on 2019/8/27.
//  Copyright © 2019 hsj. All rights reserved.
//

import UIKit

class CustomNaviViewController: UIViewController {

    lazy var naviBar: SCNaviBar = {
        let bar = SCNaviBar()
        bar.backHandler = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        return bar
    }()

    lazy var rightButton: UIButton = {
        let button = UIButton()
        let image = #imageLiteral(resourceName: "底部_标签_书架").withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(CustomNaviViewController.moreClick), for: .touchUpInside)
        return button
    }()

    lazy var removeButton: UIButton = {
        let button = UIButton()
        let image = #imageLiteral(resourceName: "底部_标签_书架").withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(CustomNaviViewController.removeClick), for: .touchUpInside)
        return button
    }()

    lazy var addButton: UIButton = {
        let button = UIButton()
        button.setTitle("添加更多", for: .normal)
        button.addTarget(self, action: #selector(CustomNaviViewController.addMore), for: .touchUpInside)
        return button
    }()

    lazy var addTitleButton: UIButton = {
        let button = UIButton()
        button.setTitle("添加标题", for: .normal)
        button.addTarget(self, action: #selector(CustomNaviViewController.addTitleView), for: .touchUpInside)
        return button
    }()

    lazy var switchView: UISwitch = {
        let view = UISwitch()
        view.isOn = true
        return view
    }()

    lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [self.addButton, self.addTitleButton])
        stack.axis = .vertical
        stack.spacing = 10
        return stack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = ""
        naviBar.title = "自定义"

        view.backgroundColor = .purple
        view.addSubview(naviBar)
        view.addSubview(stackView)

        stackView.snp.makeConstraints { (maker) in
            maker.center.equalToSuperview()
        }

        naviBar.snp.makeConstraints { (maker) in
            maker.top.equalToSuperview()
            maker.leading.equalToSuperview()
            maker.trailing.equalToSuperview()
        }
        rightButton.snp.makeConstraints({ (maker) in
            maker.width.equalTo(44)
        })
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    @objc func moreClick() {
//        let vc = NormalViewController()
//        navigationController?.pushViewController(vc, animated: true)
        naviBar.hiddenBackButton = true
    }

    @objc func removeClick() {
        naviBar.hiddenBackButton = false
    }

    @objc func addTitleView() {
        naviBar.titleView = switchView
    }

    @objc func addMore() {
        naviBar.rightItems = [removeButton, rightButton]
    }

}
