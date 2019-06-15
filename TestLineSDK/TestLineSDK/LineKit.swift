//
//  LineKit.swift
//
//  Created by vsccw on 2017/4/28.
//  Copyright © 2017年 Qiun Cheng. All rights reserved.
//

import UIKit

public class LineKit: NSObject {
    
    public class var isLineInstalled: Bool {
        if let url = URL.init(string: "line://") {
            return UIApplication.shared.canOpenURL(url)
        }
        else {
            return false
        }
    }
    
    public class func sendMessage(message: String) {
        if let str = message.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) {
            let formattedMsg = String.init(format: "line://msg/text/%@", str)
            if let url = URL.init(string: formattedMsg) {
                UIApplication.shared.open(url)
            }
        }
    }
}
