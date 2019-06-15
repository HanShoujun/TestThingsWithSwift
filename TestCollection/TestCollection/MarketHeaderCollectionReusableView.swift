//
//  MarketHeaderCollectionReusableView.swift
//  TestCollection
//
//  Created by hsj on 2019/5/11.
//  Copyright © 2019年 hsj. All rights reserved.
//

import UIKit
import MagazineLayout

class MarketHeaderCollectionReusableView: MagazineLayoutCollectionReusableView {

    class func loadFromNib() -> MarketHeaderCollectionReusableView {
        return Bundle.main.loadNibNamed("MarketHeaderCollectionReusableView", owner: nil, options: nil)?.first as! MarketHeaderCollectionReusableView
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
