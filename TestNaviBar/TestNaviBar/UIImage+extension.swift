//
//  UIImage+extension.swift
//  TestNaviBar
//
//  Created by zero on 2019/8/28.
//  Copyright © 2019 hsj. All rights reserved.
//

import UIKit

public extension UIImage {

    convenience init(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        UIGraphicsBeginImageContextWithOptions(size, false, 1)

        defer {
            UIGraphicsEndImageContext()
        }

        color.setFill()
        UIRectFill(CGRect(origin: .zero, size: size))

        guard let aCgImage = UIGraphicsGetImageFromCurrentImageContext()?.cgImage else {
            self.init()
            return
        }

        self.init(cgImage: aCgImage)
    }

}
