//
//  Foundation.swift
//  DarkSwift
//
//  Created by Dark Dong on 2017/4/3.
//  Copyright © 2017年 Dark Dong. All rights reserved.
//

import AVFoundation

//public protocol Cloneable {
//    func clone<T>() -> T?
//}
//
//public extension Cloneable {
//    func clone<T>() -> T? {
//        return NSKeyedUnarchiver.unarchiveObject(with: NSKeyedArchiver.archivedData(withRootObject: self)) as? T
//    }
//}

public class System: NSObject {
    public static var currentQueueName: String? {
        let name = __dispatch_queue_get_label(nil)
        return String(cString: name, encoding: .utf8)
    }
    
    public static func captureDevice(mediaType: String, position: AVCaptureDevicePosition) -> AVCaptureDevice? {
        if let devices = AVCaptureDevice.devices(withMediaType: mediaType) as? [AVCaptureDevice] {
            for device in devices {
                if device.position == position {
                    return device
                }
            }
        }
        return nil
    }
}
