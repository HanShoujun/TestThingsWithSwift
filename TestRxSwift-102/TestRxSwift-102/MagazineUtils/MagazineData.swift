//
//  MagazineData.swift
//  MagazineLayoutExample
//
//  Created by hsj on 2019/6/11.
//  Copyright © 2019 Airbnb. All rights reserved.
//

import UIKit
import MagazineLayout

protocol MagazineSizeable {
    associatedtype Mode
    var sizeMode: Mode { get set }
}

struct MagazineSection
{
    var headerInfo: MagazineHeader
    var itemInfos: [MagazineItem]
    var footerInfo: MagazineFooter
    var backgroundInfo: MagazineBackground

    var insetsForSection: UIEdgeInsets
    var insetsForItems: UIEdgeInsets
    var verticalSpacing: CGFloat
    var horizontalSpacing: CGFloat

    init(headerInfo: MagazineHeader = MagazineHeader(),
          itemInfos: [MagazineItem],
          footerInfo: MagazineFooter = MagazineFooter(),
          backgroundInfo: MagazineBackground = MagazineBackground(),
          insetsForSection: UIEdgeInsets = .zero,
          insetsForItems: UIEdgeInsets = .zero,
          verticalSpacing: CGFloat = 0,
          horizontalSpacing: CGFloat = 0) {
        self.headerInfo = headerInfo
        self.itemInfos = itemInfos
        self.footerInfo = footerInfo
        self.backgroundInfo = backgroundInfo
        self.insetsForItems = insetsForItems
        self.insetsForSection = insetsForSection
        self.verticalSpacing = verticalSpacing
        self.horizontalSpacing = horizontalSpacing
    }
}

struct MagazineItem {
    var sizeMode: MagazineLayoutItemSizeMode
    var info: Any?
}
extension MagazineItem: MagazineSizeable {}

struct MagazineHeader {
    var sizeMode: MagazineLayoutHeaderVisibilityMode
    var info: Any?
    init(sizeMode: MagazineLayoutHeaderVisibilityMode = .hidden, info: Any? = nil) {
        self.sizeMode = sizeMode
        self.info = info
    }
}
extension MagazineHeader: MagazineSizeable {}

struct MagazineFooter {
    var sizeMode: MagazineLayoutFooterVisibilityMode
    var info: Any?
    init(sizeMode: MagazineLayoutFooterVisibilityMode = .hidden, info: Any? = nil) {
        self.sizeMode = sizeMode
        self.info = info
    }
}
extension MagazineFooter: MagazineSizeable {}

struct MagazineBackground {
    var sizeMode: MagazineLayoutBackgroundVisibilityMode
    var info: Any?
    init(sizeMode: MagazineLayoutBackgroundVisibilityMode = .hidden, info: Any? = nil) {
        self.sizeMode = sizeMode
        self.info = info
    }
}
extension MagazineBackground: MagazineSizeable {}
