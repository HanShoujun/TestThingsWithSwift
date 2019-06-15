//
//  MarketViewController.swift
//  TestCollection
//
//  Created by hsj on 2019/5/11.
//  Copyright © 2019年 hsj. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import MagazineLayout

class MarketViewController: UIViewController, IndicatorInfoProvider {

    var itemInfo: IndicatorInfo = "View"

    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }

    init(itemInfo: IndicatorInfo) {
        self.itemInfo = itemInfo
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        view.addSubview(collectionView)

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ])
    }

    private lazy var collectionView: UICollectionView = {
        let layout = MagazineLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.register(UINib(nibName: "MarketCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: MarketCollectionViewCell.description())
        collectionView.register(UINib(nibName: "MarketHeaderCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: MagazineLayout.SupplementaryViewKind.sectionHeader, withReuseIdentifier: MarketHeaderCollectionReusableView.description())
        return collectionView
    }()

}

extension MarketViewController: UICollectionViewDelegate {

}

// MARK: UICollectionViewDataSource

extension MarketViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int)
        -> Int
    {
        return 3
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath)
        -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MarketCollectionViewCell.description(),
            for: indexPath) as! MarketCollectionViewCell
        return cell
    }

    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath)
        -> UICollectionReusableView
    {
        let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: MagazineLayout.SupplementaryViewKind.sectionHeader,
            withReuseIdentifier: MarketHeaderCollectionReusableView.description(),
            for: indexPath) as! MarketHeaderCollectionReusableView
        return header
    }

}

// MARK: UICollectionViewDelegateMagazineLayout

extension MarketViewController: UICollectionViewDelegateMagazineLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, visibilityModeForFooterInSectionAtIndex index: Int) -> MagazineLayoutFooterVisibilityMode {
        return .hidden
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, visibilityModeForBackgroundInSectionAtIndex index: Int) -> MagazineLayoutBackgroundVisibilityMode {
        return .hidden
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeModeForItemAt indexPath: IndexPath)
        -> MagazineLayoutItemSizeMode
    {
        return MagazineLayoutItemSizeMode(widthMode: .thirdWidth, heightMode: .dynamic)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        visibilityModeForHeaderInSectionAtIndex index: Int)
        -> MagazineLayoutHeaderVisibilityMode
    {
        return .visible(heightMode: .dynamic)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        horizontalSpacingForItemsInSectionAtIndex index: Int)
        -> CGFloat
    {
        return 12
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        verticalSpacingForElementsInSectionAtIndex index: Int)
        -> CGFloat
    {
        return 12
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetsForSectionAtIndex index: Int)
        -> UIEdgeInsets
    {
        return UIEdgeInsets(top: 24, left: 4, bottom: 24, right: 4)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetsForItemsInSectionAtIndex index: Int)
        -> UIEdgeInsets
    {
        return UIEdgeInsets(top: 24, left: 4, bottom: 24, right: 4)
    }

}
