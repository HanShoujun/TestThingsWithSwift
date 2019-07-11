//
//  MagazinDataProvider.swift
//  MagazineLayoutExample
//
//  Created by hsj on 2019/6/11.
//  Copyright © 2019 Airbnb. All rights reserved.
//

import UIKit
import MagazineLayout

class MagazineDataProvider: NSObject {

    weak var delegate: UICollectionViewDelegate?
    var sections = [MagazineSection]()

    func insert(_ section: MagazineSection, atSectionIndex sectionIndex: Int) {
        sections.insert(section, at: sectionIndex)
    }

    func insert(
        _ itemInfo: MagazineItem,
        atItemIndex itemIndex: Int,
        inSectionAtIndex sectionIndex: Int)
    {
        sections[sectionIndex].itemInfos.insert(itemInfo, at: itemIndex)
    }

    func removeSection(atSectionIndex sectionIndex: Int) {
        sections.remove(at: sectionIndex)
    }

    func removeItem(atItemIndex itemIndex: Int, inSectionAtIndex sectionIndex: Int) {
        sections[sectionIndex].itemInfos.remove(at: itemIndex)
    }

    func setHeaderInfo(_ headerInfo: MagazineHeader, forSectionAtIndex sectionIndex: Int) {
        sections[sectionIndex].headerInfo = headerInfo
    }

    func setFooterInfo(_ footerInfo: MagazineFooter, forSectionAtIndex sectionIndex: Int) {
        sections[sectionIndex].footerInfo = footerInfo
    }

    func getItemInfo(_ indexPath: IndexPath) -> Any? {
        return sections[indexPath.section].itemInfos[indexPath.item].info
    }
}

// MARK: UICollectionViewDataSource

extension MagazineDataProvider: UICollectionViewDelegate, UICollectionViewDelegateMagazineLayout {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.collectionView?(collectionView, didSelectItemAt: indexPath)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeModeForItemAt indexPath: IndexPath)
        -> MagazineLayoutItemSizeMode
    {
        return sections[indexPath.section].itemInfos[indexPath.item].sizeMode
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        visibilityModeForHeaderInSectionAtIndex index: Int)
        -> MagazineLayoutHeaderVisibilityMode
    {
        return sections[index].headerInfo.sizeMode
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        visibilityModeForFooterInSectionAtIndex index: Int)
        -> MagazineLayoutFooterVisibilityMode
    {
        return sections[index].footerInfo.sizeMode
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        visibilityModeForBackgroundInSectionAtIndex index: Int)
        -> MagazineLayoutBackgroundVisibilityMode
    {
        return sections[index].backgroundInfo.sizeMode
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        horizontalSpacingForItemsInSectionAtIndex index: Int)
        -> CGFloat
    {
        return sections[index].horizontalSpacing
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        verticalSpacingForElementsInSectionAtIndex index: Int)
        -> CGFloat
    {
        return sections[index].verticalSpacing
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetsForSectionAtIndex index: Int)
        -> UIEdgeInsets
    {
        return sections[index].insetsForSection
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetsForItemsInSectionAtIndex index: Int)
        -> UIEdgeInsets
    {
        return sections[index].insetsForItems
    }

}
