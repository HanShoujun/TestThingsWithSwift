//
//  MusicViewModel.swift
//  TestRxSwift-101
//
//  Created by hsj on 2019/6/23.
//  Copyright © 2019 hsj. All rights reserved.
//

import Foundation
import RxSwift

struct MusicViewModel {
    let data = [
        Music(name: "无条件", singer: "陈奕迅"),
        Music(name: "你曾是少年", singer: "S.H.E"),
        Music(name: "从前的我", singer: "陈洁仪"),
        Music(name: "在木星", singer: "朴树"),
    ]

    let dataStream = Observable.just([
        Music(name: "无条件", singer: "陈奕迅"),
        Music(name: "你曾是少年", singer: "S.H.E"),
        Music(name: "从前的我", singer: "陈洁仪"),
        Music(name: "在木星", singer: "朴树"),
        ])
}
