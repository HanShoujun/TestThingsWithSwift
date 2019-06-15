//
//  ViewController.swift
//  TestCollection
//
//  Created by hsj on 2019/5/10.
//  Copyright © 2019年 hsj. All rights reserved.
//

import UIKit
import MagazineLayout

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.addSubview(collectionView)

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ])

        loadDefaultData()

        title = "View"
    }

    // MARK: Private

    private lazy var collectionView: UICollectionView = {
        let layout = MagazineLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(Cell.self, forCellWithReuseIdentifier: Cell.description())
        collectionView.register(
            Header.self,
            forSupplementaryViewOfKind: MagazineLayout.SupplementaryViewKind.sectionHeader,
            withReuseIdentifier: Header.description())
        collectionView.register(
            Footer.self,
            forSupplementaryViewOfKind: MagazineLayout.SupplementaryViewKind.sectionFooter,
            withReuseIdentifier: Footer.description())
        collectionView.register(
            Background.self,
            forSupplementaryViewOfKind: MagazineLayout.SupplementaryViewKind.sectionBackground,
            withReuseIdentifier: Background.description())
        collectionView.isPrefetchingEnabled = false
        collectionView.dataSource = dataSource
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.contentInsetAdjustmentBehavior = .always
        return collectionView
    }()

    private lazy var dataSource = DataSource()

    private var lastItemCreationPanelViewState: ItemCreationPanelViewState?

    private func removeAllData() {
        for sectionIndex in (0..<dataSource.numberOfSections).reversed() {
            dataSource.removeSection(atSectionIndex: sectionIndex)
        }

        collectionView.reloadData()
    }

    private func loadDefaultData() {
        removeAllData()

        let section0 = SectionInfo(
            headerInfo: HeaderInfo(
                visibilityMode: .visible(heightMode: .dynamic),
                title: "Welcome!"),
            itemInfos: [
                ItemInfo(
                    sizeMode: MagazineLayoutItemSizeMode(
                        widthMode: .fullWidth(respectsHorizontalInsets: true),
                        heightMode: .dynamic),
                    text: "MagazineLayout lets you layout items in vertically scrolling grids and lists.",
                    color: Colors.red),
                ItemInfo(
                    sizeMode: MagazineLayoutItemSizeMode(
                        widthMode: .fullWidth(respectsHorizontalInsets: true),
                        heightMode: .dynamic),
                    text: "As you can see...",
                    color: Colors.red),
                ItemInfo(
                    sizeMode: MagazineLayoutItemSizeMode(
                        widthMode: .halfWidth,
                        heightMode: .dynamic),
                    text: "items can be vertically self-sized",
                    color: Colors.orange),
                ItemInfo(
                    sizeMode: MagazineLayoutItemSizeMode(
                        widthMode: .halfWidth,
                        heightMode: .dynamic),
                    text: "based on their contents.",
                    color: Colors.orange),
                ItemInfo(
                    sizeMode: MagazineLayoutItemSizeMode(
                        widthMode: .halfWidth,
                        heightMode: .dynamic),
                    text: "Widths are determined",
                    color: Colors.green),
                ItemInfo(
                    sizeMode: MagazineLayoutItemSizeMode(
                        widthMode: .halfWidth,
                        heightMode: .dynamic),
                    text: "by item width modes",
                    color: Colors.green),
                ItemInfo(
                    sizeMode: MagazineLayoutItemSizeMode(
                        widthMode: .thirdWidth,
                        heightMode: .dynamic),
                    text: "3 across",
                    color: Colors.green),
                ItemInfo(
                    sizeMode: MagazineLayoutItemSizeMode(
                        widthMode: .thirdWidth,
                        heightMode: .dynamic),
                    text: "3 across",
                    color: Colors.green),
                ItemInfo(
                    sizeMode: MagazineLayoutItemSizeMode(
                        widthMode: .thirdWidth,
                        heightMode: .dynamic),
                    text: "3 across",
                    color: Colors.green),
                ItemInfo(
                    sizeMode: MagazineLayoutItemSizeMode(
                        widthMode: .fractionalWidth(divisor: 10),
                        heightMode: .dynamic),
                    text: "1",
                    color: Colors.blue),
                ItemInfo(
                    sizeMode: MagazineLayoutItemSizeMode(
                        widthMode: .fractionalWidth(divisor: 10),
                        heightMode: .dynamic),
                    text: "0",
                    color: Colors.blue),
                ItemInfo(
                    sizeMode: MagazineLayoutItemSizeMode(
                        widthMode: .fractionalWidth(divisor: 10),
                        heightMode: .dynamic),
                    text: " ",
                    color: Colors.blue),
                ItemInfo(
                    sizeMode: MagazineLayoutItemSizeMode(
                        widthMode: .fractionalWidth(divisor: 10),
                        heightMode: .dynamic),
                    text: "a",
                    color: Colors.blue),
                ItemInfo(
                    sizeMode: MagazineLayoutItemSizeMode(
                        widthMode: .fractionalWidth(divisor: 10),
                        heightMode: .dynamic),
                    text: "c",
                    color: Colors.blue),
                ItemInfo(
                    sizeMode: MagazineLayoutItemSizeMode(
                        widthMode: .fractionalWidth(divisor: 10),
                        heightMode: .dynamic),
                    text: "r",
                    color: Colors.blue),
                ItemInfo(
                    sizeMode: MagazineLayoutItemSizeMode(
                        widthMode: .fractionalWidth(divisor: 10),
                        heightMode: .dynamic),
                    text: "o",
                    color: Colors.blue),
                ItemInfo(
                    sizeMode: MagazineLayoutItemSizeMode(
                        widthMode: .fractionalWidth(divisor: 10),
                        heightMode: .dynamic),
                    text: "s",
                    color: Colors.blue),
                ItemInfo(
                    sizeMode: MagazineLayoutItemSizeMode(
                        widthMode: .fractionalWidth(divisor: 10),
                        heightMode: .dynamic),
                    text: "s",
                    color: Colors.blue),
                ItemInfo(
                    sizeMode: MagazineLayoutItemSizeMode(
                        widthMode: .fractionalWidth(divisor: 10),
                        heightMode: .dynamic),
                    text: ":)",
                    color: Colors.blue),
                ],
            footerInfo: FooterInfo(
                visibilityMode: .hidden,
                title: ""),
            backgroundInfo: BackgroundInfo(visibilityMode: .hidden)
        )

        let section1 = SectionInfo(
            headerInfo: HeaderInfo(
                visibilityMode: .visible(heightMode: .dynamic),
                title: "Self-sizing supplementary views (headers and footers) are also supported."),
            itemInfos: [
                ItemInfo(
                    sizeMode: MagazineLayoutItemSizeMode(
                        widthMode: .fullWidth(respectsHorizontalInsets: true),
                        heightMode: .dynamic),
                    text: "If you really want to turn off self-sizing for a particular item...",
                    color: Colors.red),
                ItemInfo(
                    sizeMode: MagazineLayoutItemSizeMode(
                        widthMode: .fullWidth(respectsHorizontalInsets: true),
                        heightMode: .static(height: 200)),
                    text: "you can, but any dynamic content could get truncated or have too much padding.",
                    color: Colors.red),
                ItemInfo(
                    sizeMode: MagazineLayoutItemSizeMode(
                        widthMode: .fullWidth(respectsHorizontalInsets: true),
                        heightMode: .dynamic),
                    text: "You can also ask items to size dynamically first, but ultimately stretch to match the tallest item in the same row of items.",
                    color: Colors.orange),
                ItemInfo(
                    sizeMode: MagazineLayoutItemSizeMode(
                        widthMode: .halfWidth,
                        heightMode: .dynamic),
                    text: "I'm the tallest item because I have so much text...",
                    color: Colors.orange),
                ItemInfo(
                    sizeMode: MagazineLayoutItemSizeMode(
                        widthMode: .halfWidth,
                        heightMode: .dynamicAndStretchToTallestItemInRow),
                    text: "and I'll stretch to match your height.",
                    color: Colors.orange),
                ],
            footerInfo: FooterInfo(
                visibilityMode: .hidden,
                title: ""),
            backgroundInfo: BackgroundInfo(visibilityMode: .visible)
        )

        let section2 = SectionInfo(
            headerInfo: HeaderInfo(
                visibilityMode: .visible(heightMode: .dynamic),
                title: "Using this app:"),
            itemInfos: [
                ItemInfo(
                    sizeMode: MagazineLayoutItemSizeMode(
                        widthMode: .fullWidth(respectsHorizontalInsets: true),
                        heightMode: .dynamic),
                    text: "Add new items by tapping the + in the top right.",
                    color: Colors.green),
                ItemInfo(
                    sizeMode: MagazineLayoutItemSizeMode(
                        widthMode: .fullWidth(respectsHorizontalInsets: true),
                        heightMode: .dynamic),
                    text: "Delete items by tapping them in the collection view.",
                    color: Colors.green),
                ItemInfo(
                    sizeMode: MagazineLayoutItemSizeMode(
                        widthMode: .fullWidth(respectsHorizontalInsets: true),
                        heightMode: .dynamic),
                    text: "Tap the reload icon in the top left to...",
                    color: Colors.green),
                ItemInfo(
                    sizeMode: MagazineLayoutItemSizeMode(
                        widthMode: .thirdWidth,
                        heightMode: .dynamicAndStretchToTallestItemInRow),
                    text: "delete all data,",
                    color: Colors.green),
                ItemInfo(
                    sizeMode: MagazineLayoutItemSizeMode(
                        widthMode: .thirdWidth,
                        heightMode: .dynamicAndStretchToTallestItemInRow),
                    text: "reset to default data,",
                    color: Colors.green),
                ItemInfo(
                    sizeMode: MagazineLayoutItemSizeMode(
                        widthMode: .thirdWidth,
                        heightMode: .dynamicAndStretchToTallestItemInRow),
                    text: "or invoke reloadData().",
                    color: Colors.green),
                ],
            footerInfo: FooterInfo(
                visibilityMode: .visible(heightMode: .dynamic),
                title: "Enjoy using MagazineLayout!"),
            backgroundInfo: BackgroundInfo(visibilityMode: .hidden)
        )

        dataSource.insert(section0, atSectionIndex: 0)
        dataSource.insert(section1, atSectionIndex: 1)
        dataSource.insert(section2, atSectionIndex: 2)

        collectionView.reloadData()
    }

}

extension ViewController: UICollectionViewDelegate {

}

// MARK: UICollectionViewDelegateMagazineLayout

extension ViewController: UICollectionViewDelegateMagazineLayout {

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeModeForItemAt indexPath: IndexPath)
        -> MagazineLayoutItemSizeMode
    {
        return dataSource.sectionInfos[indexPath.section].itemInfos[indexPath.item].sizeMode
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        visibilityModeForHeaderInSectionAtIndex index: Int)
        -> MagazineLayoutHeaderVisibilityMode
    {
        return dataSource.sectionInfos[index].headerInfo.visibilityMode
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        visibilityModeForFooterInSectionAtIndex index: Int)
        -> MagazineLayoutFooterVisibilityMode
    {
        return dataSource.sectionInfos[index].footerInfo.visibilityMode
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        visibilityModeForBackgroundInSectionAtIndex index: Int)
        -> MagazineLayoutBackgroundVisibilityMode
    {
        return dataSource.sectionInfos[index].backgroundInfo.visibilityMode
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
