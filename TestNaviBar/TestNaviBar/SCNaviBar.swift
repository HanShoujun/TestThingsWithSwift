//
//  SCNaviBar.swift
//  TestNaviBar
//
//  Created by zero on 2019/8/28.
//  Copyright © 2019 hsj. All rights reserved.
//

import UIKit
import SnapKit

class SCNaviBar: UIView {

    /// 按钮颜色
    @objc dynamic override var tintColor: UIColor? {
        didSet {
            leftItems.forEach { (view) in
                view.tintColor = tintColor
            }
            rightItems.forEach { (view) in
                view.tintColor = tintColor
            }
        }
    }
    /// 背景透明度
    @objc dynamic var bgAlpha: CGFloat = 1 {
        didSet {
            backgroundView.alpha = bgAlpha
        }
    }
    /// 背景颜色
    @objc dynamic var bgColor: UIColor = .white {
        didSet {
            backgroundImageView.image = bgColor.toImage()
        }
    }
    /// 阴影线颜色
    @objc dynamic var lineColor: UIColor = "F9F9F9".color {
        didSet {
            lineImageView.image = lineColor.toImage()
        }
    }
    /// 返回图片
    @objc dynamic var backImage: UIImage? {
        didSet {
            backButton.setImage(backImage, for: .normal)
            backButton.setImage(backImage, for: .highlighted)
        }
    }
    /// 标题颜色
    @objc dynamic var titleColor: UIColor = .black {
        didSet {
            titleLabel.textColor = titleColor
        }
    }
    /// 标题字体
    @objc dynamic var titleFont: UIFont = UIFont.systemFont(ofSize: 18) {
        didSet {
            titleLabel.font = titleFont
        }
    }
    /// 是否隐藏返回按钮
    var hiddenBackButton: Bool {
        get {
            return leftItems.contains(backButton)
        }
        set {
            if newValue {
                backButton.removeFromSuperview()
            }else {
                leftStackView.insertArrangedSubview(backButton, at: 0)
            }
        }
    }
    /// 返回闭包
    var backHandler: (()->Void)?
    /// 标题
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    /// 左边视图
    var leftItems: [UIView] {
        get {
            return leftStackView.arrangedSubviews
        }
        set {
            let subs = leftStackView.arrangedSubviews
            subs.forEach { $0.removeFromSuperview() }
            newValue.forEach {
                leftStackView.addArrangedSubview($0)
                $0.tintColor = tintColor
            }
        }
    }
    /// 右边视图
    var rightItems: [UIView] {
        get {
            return rightStackView.arrangedSubviews
        }
        set {
            let subs = rightStackView.arrangedSubviews
            subs.forEach { $0.removeFromSuperview() }
            newValue.forEach {
                rightStackView.addArrangedSubview($0)
                $0.tintColor = tintColor
            }
        }
    }
    /// 标题视图
    var titleView: UIView? {
        get {
            return middleStackView.subviews.first ?? titleLabel
        }
        set {
            guard let view = newValue else {
                return
            }
            let subs = middleStackView.arrangedSubviews
            subs.forEach { $0.removeFromSuperview() }
            middleStackView.addArrangedSubview(view)
        }
    }

    // MARK: - 子视图
    /// 背景视图
    lazy private var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.alpha = self.bgAlpha
        view.addSubview(self.backgroundImageView)
        view.addSubview(self.lineImageView)
        return view
    }()

    /// 背景图片
    lazy private var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = self.bgColor.toImage()
        return imageView
    }()

    /// 阴影线
    lazy private var lineImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = UIView.ContentMode.scaleToFill
        imageView.image = self.lineColor.toImage()
        return imageView
    }()

    /// 状态栏视图
    lazy private var statusView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()

    /// 内容视图
    lazy private var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.addSubview(self.leftStackView)
        view.addSubview(self.middleStackView)
        view.addSubview(self.rightStackView)
        return view
    }()

    /// 左按钮列表
    lazy private var leftStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.addArrangedSubview(self.backButton)
        return stackView
    }()

    /// 返回按钮
    lazy private var backButton: UIButton = {
        let button = UIButton()
        button.setImage(self.backImage, for: .normal)
        button.setImage(self.backImage, for: .highlighted)
        button.addTarget(self, action: #selector(SCNaviBar.backButtonClick), for: .touchUpInside)
        button.tintColor = self.tintColor
        return button
    }()

    /// 左按钮列表
    lazy private var middleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.addArrangedSubview(self.titleLabel)
        return stackView
    }()

    /// 标题
    lazy private var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = self.titleColor
        label.font = self.titleFont
        return label
    }()

    /// 右按钮列表
    lazy private var rightStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 5
        return stackView
    }()

    // MARK: - 生命周期
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    private func setupView() {
        addSubview(backgroundView)
        addSubview(statusView)
        addSubview(contentView)

        setupLayout()
    }

    private func setupLayout() {

        self.snp.makeConstraints { (maker) in
            maker.height.equalTo(SCScreen.statusBarHeight + SCScreen.naviBarHeight)
        }
        /// 背景约束
        backgroundView.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview()
        }
        backgroundImageView.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview()
        }
        lineImageView.snp.makeConstraints { (maker) in
            maker.leading.equalToSuperview()
            maker.trailing.equalToSuperview()
            maker.height.equalTo(0.5)
            maker.bottom.equalToSuperview()
        }

        /// 状态栏
        statusView.snp.makeConstraints { (maker) in
            maker.top.equalToSuperview()
            maker.leading.equalToSuperview()
            maker.trailing.equalToSuperview()
            maker.height.equalTo(SCScreen.statusBarHeight)
        }

        /// 导航栏
        contentView.snp.makeConstraints { (maker) in
            maker.leading.equalToSuperview()
            maker.trailing.equalToSuperview()
            maker.bottom.equalToSuperview()
            maker.height.equalTo(SCScreen.naviBarHeight)
        }
        /// 左边
        leftStackView.snp.makeConstraints { (maker) in
            maker.leading.equalToSuperview()
            maker.centerY.equalToSuperview()
            maker.height.equalToSuperview()
        }
        backButton.snp.makeConstraints { (maker) in
            maker.width.equalTo(SCScreen.naviBarHeight)
        }
        /// 中间
        middleStackView.snp.makeConstraints { (maker) in
            maker.centerY.equalToSuperview()
            maker.centerX.equalToSuperview()
            maker.height.equalToSuperview()
        }
        /// 右边
        rightStackView.snp.makeConstraints { (maker) in
            maker.trailing.equalToSuperview()
            maker.centerY.equalToSuperview()
            maker.height.equalToSuperview()
        }
    }

    // MARK: - Action
    @objc func backButtonClick() {
        backHandler?()
    }
}
