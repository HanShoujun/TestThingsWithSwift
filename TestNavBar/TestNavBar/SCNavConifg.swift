//
//  SCNavConifg.swift
//  TestNavBar
//
//  Created by zero on 2019/8/5.
//  Copyright © 2019 hsj. All rights reserved.
//

import Foundation
import UIKit

// MARK: - 导航栏配置
struct SCNavConfig {

    /// default config for scnav
    public static var `default` = SCNavConfig()

    /// 导航条是否隐藏
    public var hidden: Bool

    /// 导航条背景透明度
    public var bgAlpha: CGFloat

    /// 状态栏风格
    public var statusBarStyle: UIStatusBarStyle

    /// 导航栏按钮颜色
    public var tintColor: UIColor

    /// 导航栏标题格式
    public var titleTextAttributes: [NSAttributedString.Key : Any]?

    init(hidden: Bool = false,
         bgAlpha: CGFloat = 1,
         statusBarStyle: UIStatusBarStyle = UIApplication.shared.statusBarStyle,
         tintColor: UIColor = UIColor(red: 50/255.0, green: 50/255.0, blue: 50/255.0, alpha: 1),
         titleTextAttributes: [NSAttributedString.Key : Any]? = UINavigationBar.appearance().titleTextAttributes) {
        self.hidden = hidden
        self.bgAlpha = bgAlpha
        self.statusBarStyle = statusBarStyle
        self.tintColor = tintColor
        self.titleTextAttributes = titleTextAttributes
    }
    
}
