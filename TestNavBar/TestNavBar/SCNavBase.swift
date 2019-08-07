//
//  SCNavBase.swift
//  TestNavBar
//
//  Created by zero on 2019/8/5.
//  Copyright © 2019 hsj. All rights reserved.
//

import UIKit

struct SCNav<Base> {

    var base: Base

    init (_ base: Base) {
        self.base = base
    }
}

protocol SCNavCompatible {
    associatedtype SCNavBase

    var scnav: SCNav<SCNavBase> { get set }
}

