//
//  MusicModel.swift
//  TestRxSwift-101
//
//  Created by hsj on 2019/6/23.
//  Copyright © 2019 hsj. All rights reserved.
//

import Foundation

struct Music {
    /// 名字
    let name: String
    /// 歌手
    let singer: String
}

extension Music: CustomStringConvertible {
    var description: String {
        return "Name: \(name)    Singer: \(singer)"
    }
}
