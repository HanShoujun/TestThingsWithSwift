//
//  MagazineLayout+Rx.swift
//  TestRxSwift-102
//
//  Created by zero on 2019/7/9.
//  Copyright © 2019 hsj. All rights reserved.
//

import RxSwift
import RxCocoa
import MagazineLayout

extension Reactive where Base: UICollectionView {

    public var itemSelected: ControlEvent<IndexPath> {
        let source = delegate.methodInvoked(#selector(UICollectionViewDelegate.collectionView(_:didSelectItemAt:)))
            .map { a in
                return try castOrThrow(IndexPath.self, a[1])
        }

        return ControlEvent(events: source)
    }

}
