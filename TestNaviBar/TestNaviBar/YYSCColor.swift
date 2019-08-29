//
//  YYSCColor.swift
//  QJAutoFinance_Swift
//
//  Created by hsj on 16/8/12.
//  Copyright © 2016年 qjcf. All rights reserved.
//

import Foundation
//import SwiftColor

struct YYSCColor {
    
    static let Main = "#FF8276".color
    static let Action = "007AFF".color
    static let Black = "000000".color
    static let Separator = "E0E0E0".color
    static let Background = "F9F9F9".color
    static let NavigationBackground = "FFFFFF".color
    static let TabBackground = "FFFFFF".color
    
    // Tab Bar
    
    static let StatusOn = "FF5E3B".color
    static let StatusOff = "1E96E2".color
    static let StatusConnecting = "F5A623".color
    
    static let LightText = "999999".color
    static let DarkText = "333333".color
    static let LittleDarkText = "666666".color
    static let PositionDarkText = "4c4c4c".color
    
    // MARK: -
    
    static let White = UIColor.white
    static let Orange = "f25933".color
    static let Green = "5ea33b".color
    static let Gray = "5f6a7a".color
    static let LightGray = "f0f0f5".color
    
    static let NavigationBar = "FCFCFC".color
    static let NavigationTint = "333333".color
    static let LineBackground = "dedede".color
    static let CellGrayBackground = "fafafa".color
    
    static let TabItemSelected = "FF8276".color
    static let TabItemNormal = "8f9fb2".color
    static let ReportNoteColor = "FFAC12".color
    static let ButtonBackground = "4c64ff".color
    
    static let PieChart = ["718AE9".color,
                           "00B8D4".color,
                           "9475CC".color,
                           "70C1B3".color,
                           "e5c079".color]
    
    static func chartWithIndex(_ index: Int?) -> UIColor {
        guard let index = index else { return PieChart[0] }
        
        let n = index % PieChart.count
        return PieChart[n]
    }
    
}

#if os(iOS)
    import UIKit
    public typealias Colors = UIColor
#elseif os(OSX)
    import Cocoa
    public typealias Colors = NSColor
#endif

public func ==(lhs: Colors, rhs: Colors) -> Bool{
    let (lRed, lGreen, lBlue, lAlpha) = lhs.colorComponents()
    let (rRed, rGreen, rBlue, rAlpha) = rhs.colorComponents()
    return fabsf(Float(lRed - rRed)) < Float.ulpOfOne
        && fabsf(Float(lGreen - rGreen)) < Float.ulpOfOne
        && fabsf(Float(lBlue - rBlue)) < Float.ulpOfOne
        && fabsf(Float(lAlpha - rAlpha)) < Float.ulpOfOne
}

public extension Colors {
    
    convenience init(_ hexString: String) {
        self.init(hexString: hexString, alpha: 1.0)
    }
    
    convenience init(hexInt: Int, alpha: Float = 1.0) {
        var hexString = NSString(format: "%0X", hexInt)
        if hexInt <= 0xfff {
            hexString = NSString(format: "%03X", hexInt)
        }else if hexInt <= 0xffff {
            hexString = NSString(format: "%04X", hexInt)
        }else if hexInt <= 0xffffff {
            hexString = NSString(format: "%06X", hexInt)
        }
        self.init(hexString: hexString as String, alpha: alpha)
    }
    
    convenience init(hexString: String, alpha: Float = 1.0) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var mAlpha: CGFloat = CGFloat(alpha)
        var minusLength = 0
        
        let scanner = Scanner(string: hexString)
        
        if hexString.hasPrefix("#") {
            scanner.scanLocation = 1
            minusLength = 1
        }
        if hexString.hasPrefix("0x") {
            scanner.scanLocation = 2
            minusLength = 2
        }
        var hexValue: UInt64 = 0
        scanner.scanHexInt64(&hexValue)
        switch hexString.count - minusLength {
        case 3:
            red = CGFloat((hexValue & 0xF00) >> 8) / 15.0
            green = CGFloat((hexValue & 0x0F0) >> 4) / 15.0
            blue = CGFloat(hexValue & 0x00F) / 15.0
        case 4:
            red = CGFloat((hexValue & 0xF000) >> 12) / 15.0
            green = CGFloat((hexValue & 0x0F00) >> 8) / 15.0
            blue = CGFloat((hexValue & 0x00F0) >> 4) / 15.0
            mAlpha = CGFloat(hexValue & 0x00F) / 15.0
        case 6:
            red = CGFloat((hexValue & 0xFF0000) >> 16) / 255.0
            green = CGFloat((hexValue & 0x00FF00) >> 8) / 255.0
            blue = CGFloat(hexValue & 0x0000FF) / 255.0
        case 8:
            red = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
            green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
            blue = CGFloat((hexValue & 0x0000FF00) >> 8) / 255.0
            mAlpha = CGFloat(hexValue & 0x000000FF) / 255.0
        default:
            break
        }
        self.init(red: red, green: green, blue: blue, alpha: mAlpha)
    }
    
    /// color components value between 0 to 255
    convenience init(byteRed red: Int, green: Int, blue: Int, alpha: Float = 1.0) {
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: CGFloat(alpha))
    }
    
    func alpha(_ value: Float) -> Colors {
        let (red, green, blue, _) = colorComponents()
        return Colors(red: red, green: green, blue: blue, alpha: CGFloat(value))
    }
    
    func red(_ value: Int) -> Colors {
        let (_, green, blue, alpha) = colorComponents()
        return Colors(red: CGFloat(value)/255.0, green: green, blue: blue, alpha: alpha)
    }
    
    func green(_ value: Int) -> Colors {
        let (red, _, blue, alpha) = colorComponents()
        return Colors(red: red, green: CGFloat(value)/255.0, blue: blue, alpha: alpha)
    }
    
    func blue(_ value: Int) -> Colors {
        let (red, green, _, alpha) = colorComponents()
        return Colors(red: red, green: green, blue: CGFloat(value)/255.0, alpha: alpha)
    }
    
    func colorComponents() -> (CGFloat, CGFloat, CGFloat, CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        #if os(iOS)
            self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        #elseif os(OSX)
            self.colorUsingColorSpaceName(NSCalibratedRGBColorSpace)!.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        #endif
        return (red, green, blue, alpha)
    }
    
}

public extension String {
    
    var color: Colors {
        return Colors(self)
    }
    
}

public extension Int {
    
    var color: Colors {
        return Colors(hexInt: self)
    }
    
}

public extension Colors {
    
    func toImage(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage? {
        let rect = CGRect(x:0, y:0, width:size.width, height:size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        self.setFill()
        UIRectFill(rect)
        let image: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
}

