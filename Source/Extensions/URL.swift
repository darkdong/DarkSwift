//
//  URL.swift
//  DarkSwift
//
//  Created by Dark Dong on 2017/4/8.
//  Copyright © 2017年 Dark Dong. All rights reserved.
//

import Foundation

public extension URL {
    static func directory(for directory: FileManager.SearchPathDirectory, in domainMask: FileManager.SearchPathDomainMask = .userDomainMask) -> URL {
        return FileManager.default.urls(for: directory, in: domainMask)[0]
    }
    
    static var documentDirectory: URL {
        return directory(for: .documentDirectory)
    }
    
    static var cachesDirectory: URL {
        return directory(for: .cachesDirectory)
    }
    
    func checkToCreateDirectory(withIntermediateDirectories: Bool = true, attributes: [String: Any]? = nil) {
        let manager = FileManager.default
        guard !manager.fileExists(atPath: path) else {
            return
        }
        do {
            try manager.createDirectory(at: self, withIntermediateDirectories: withIntermediateDirectories, attributes: attributes)
        }catch {
            
        }
    }
    
    func clearContents(_ options: FileManager.DirectoryEnumerationOptions = .skipsHiddenFiles) {
        let manager = FileManager.default
        var isDir: ObjCBool = false
        guard manager.fileExists(atPath: path, isDirectory: &isDir) && isDir.boolValue else {
            return
        }
        do {
            let urls = try manager.contentsOfDirectory(at: self, includingPropertiesForKeys: nil, options: options)
            for url in urls {
                try manager.removeItem(at: url)
            }
        }catch {
            
        }
    }
}
