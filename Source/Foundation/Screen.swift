//
//  Screen.swift
//  DarkSwift
//
//  Created by Dark Dong on 2017/3/28.
//  Copyright © 2017年 Dark Dong. All rights reserved.
//

import UIKit

public struct Screen {
    public struct Height {
        public static let statusBar: CGFloat = 20
        public static let navigationBar: CGFloat = 44
        public static let tabBar: CGFloat  = 49
        public static let toolBar: CGFloat = 44
        public static let textField: CGFloat = 31
        public static var topBar: CGFloat {
            return statusBar + navigationBar
        }
    }
    
    public struct DevicePortraitSize {
        public static let phone4 = CGSize(width: 320, height: 480) // @2x:  640 x  960
        public static let phone5 = CGSize(width: 320, height: 568) // @2x:  640 x 1136
        public static let phone6 = CGSize(width: 375, height: 667) // @2x:  750 x 1334
        public static let phone6Plus = CGSize(width: 414, height: 736) // @3x: 1242 x 2208
        
        public static let pad = CGSize(width: 768, height: 1024) // @2x: 1536 x 2048
        public static let padPro = CGSize(width: 1024, height: 1366) // @2x: 2048 x 2732
    }
    
    public struct DesignPortraitWidth {
        public static var phone = DevicePortraitSize.phone6.width
        public static var pad = DevicePortraitSize.pad.width
        public static var universal = DevicePortraitSize.pad.width
    }
    
    public static var devicePortraitSize: CGSize {
        return CGSize(width: UIScreen.main.nativeBounds.width / UIScreen.main.nativeScale, height: UIScreen.main.nativeBounds.height / UIScreen.main.nativeScale)
    }
    
    //use scale if we have two layouts: phone and pad
    public static var scale: CGFloat = {
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            switch devicePortraitSize.height {
            case DevicePortraitSize.phone4.height:
                return DevicePortraitSize.phone4.width / DesignPortraitWidth.phone
            case DevicePortraitSize.phone5.height:
                return DevicePortraitSize.phone5.width / DesignPortraitWidth.phone
            case DevicePortraitSize.phone6.height:
                return DevicePortraitSize.phone6.width / DesignPortraitWidth.phone
            case DevicePortraitSize.phone6Plus.height:
                return DevicePortraitSize.phone6Plus.width / DesignPortraitWidth.phone
            default:
                return 1
            }
        case .pad:
            switch devicePortraitSize.height {
            case DevicePortraitSize.pad.height:
                return DevicePortraitSize.pad.width / DesignPortraitWidth.pad
            case DevicePortraitSize.padPro.height:
                return DevicePortraitSize.padPro.width / DesignPortraitWidth.pad
            default:
                return 1
            }
        default:
            return 1
        }
    }()
    
    //use universalScale if we have a universal layout
    public static var universalScale: CGFloat = {
        switch devicePortraitSize.height {
        case DevicePortraitSize.phone4.height:
            return DevicePortraitSize.phone4.width / DesignPortraitWidth.universal
        case DevicePortraitSize.phone5.height:
            return DevicePortraitSize.phone5.width / DesignPortraitWidth.universal
        case DevicePortraitSize.phone6.height:
            return DevicePortraitSize.phone6.width / DesignPortraitWidth.universal
        case DevicePortraitSize.phone6Plus.height:
            return DevicePortraitSize.phone6Plus.width / DesignPortraitWidth.universal
        case DevicePortraitSize.pad.height:
            return DevicePortraitSize.pad.width / DesignPortraitWidth.universal
        case DevicePortraitSize.padPro.height:
            return DevicePortraitSize.padPro.width / DesignPortraitWidth.universal
        default:
            return 1
        }
    }()
}
