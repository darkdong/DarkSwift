//
//  UIDeviceExtension.swift
//  Dong
//
//  Created by darkdong on 14/10/24.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

import UIKit

public extension UIDevice {
    static var isPhone: Bool {
        return rawModel.hasPrefix("iPhone")
    }
    
    static var isPad: Bool {
        return rawModel.hasPrefix("iPad")
    }
    
    static var isPod: Bool {
        return rawModel.hasPrefix("iPod")
    }
    
    static var model: String = {
        if isPhone {
            switch rawModel {
            case "iPhone10,3", "iPhone10,6":
                return "iPhone X"
            case "iPhone10,2", "iPhone10,5":
                return "iPhone 8 Plus"
            case "iPhone10,1", "iPhone10,4":
                return "iPhone 8"
            case "iPhone9,2", "iPhone9,4":
                return "iPhone 7 Plus"
            case "iPhone9,1", "iPhone9,3":
                return "iPhone 7"
            case "iPhone8,4":
                return "iPhone SE"
            case "iPhone8,2":
                return "iPhone 6s Plus"
            case "iPhone8,1":
                return "iPhone 6s"
            case "iPhone7,1":
                return "iPhone 6 Plus"
            case "iPhone7,2":
                return "iPhone 6"
            case "iPhone6,1", "iPhone6,2":
                return "iPhone 5s"
            case "iPhone5,3", "iPhone5,4":
                return "iPhone 5c"
            case "iPhone5,1", "iPhone5,2":
                return "iPhone 5"
            case "iPhone4,1":
                return "iPhone 4S"
            case "iPhone3,1", "iPhone3,2", "iPhone3,3":
                return "iPhone 4"
            case "iPhone2,1":
                return "iPhone 3GS"
            case "iPhone1,2":
                return "iPhone 3G"
            case "iPhone1,1":
                return "iPhone"
            default:
                break
            }
        } else if isPad {
            switch rawModel {
            case "iPad7,1", "iPad7,2", "iPad7,3", "iPad7,4":
                return "iPad Pro 2"
            case "iPad6,11", "iPad6,12":
                return "iPad 5"
            case "iPad6,3", "iPad6,4", "iPad6,7", "iPad6,8":
                return "iPad Pro"
            case "iPad5,3", "iPad5,4":
                return "iPad Air 2"
            case "iPad5,1", "iPad5,2":
                return "iPad mini 4"
            case "iPad4,7", "iPad4,8", "iPad4,9":
                return "iPad mini 3"
            case "iPad4,4", "iPad4,5", "iPad4,6":
                return "iPad mini 2"
            case "iPad4,1", "iPad4,2", "iPad4,3":
                return "iPad Air"
            case "iPad3,4", "iPad3,5", "iPad3,6":
                return "iPad 4"
            case "iPad3,1", "iPad3,2", "iPad3,3":
                return "iPad 3"
            case "iPad2,5", "iPad2,6", "iPad2,7":
                return "iPad mini"
            case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":
                return "iPad 2"
            case "iPad1,1":
                return "iPad"
            default:
                break
            }
        } else if isPod {
            switch rawModel {
            case "iPod7,1":
                return "iPod 6G"
            case "iPod5,1":
                return "iPod 5G"
            case "iPod4,1":
                return "iPod 4G"
            case "iPod3,1":
                return "iPod 3G"
            case "iPod2,1":
                return "iPod 2G"
            case "iPod1,1":
                return "iPod"
            default:
                break
            }
        } else if rawModel == "x86_64" || rawModel == "i386" {
            return "Simulator"
        }
        return rawModel
    }()
    
    static var rawModel: String = {
        let name = "hw.machine"
        var size = 0
        sysctlbyname(name, nil, &size, nil, 0)
        var machine = [CChar](repeating: 0,  count: size)
        sysctlbyname(name, &machine, &size, nil, 0)
        return String(cString: machine)
    }()
}
