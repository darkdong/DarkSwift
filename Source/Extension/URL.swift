//
//  URL.swift
//  DarkSwift
//
//  Created by Dark Dong on 2017/4/8.
//  Copyright © 2017年 Dark Dong. All rights reserved.
//

import Foundation
import MobileCoreServices

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
    
    static var temporaryDirectory: URL {
        return URL(fileURLWithPath: NSTemporaryDirectory())
    }

    static func temporaryFile(pathExtension: String? = nil) -> URL {
        let filename = UUID().uuidString
        let extname: String
        if let ext = pathExtension, !ext.isEmpty {
            extname = "." + ext
        } else {
            extname = ""
        }
        return URL.temporaryDirectory.appendingPathComponent(filename + extname)
    }
    
    var fileSize: UInt64 {
        do {
            let attributes = try FileManager.default.attributesOfItem(atPath: path)
            return attributes[FileAttributeKey.size] as! UInt64
        } catch {
            print(error)
            return 0
        }
    }
    
    //uniform type identifier (UTI)
    func conformToUTI(_ uti: String) -> Bool {
        if let values = try? resourceValues(forKeys: [.typeIdentifierKey]), let type = values.typeIdentifier {
            return UTTypeConformsTo(type as CFString, uti as CFString)
        }
        return false
    }
    
    //assume url as base URL, return path = self.path - base
    func pathComponentRelativeTo(_ url: URL) -> String? {
        let stdPath = standardizedFileURL.path
        let relativeStdPath = url.standardizedFileURL.path
        if stdPath.hasPrefix(relativeStdPath) {
            let index = relativeStdPath.index(relativeStdPath.startIndex, offsetBy: relativeStdPath.characters.count)
            return stdPath.substring(from: index)
        }
        return nil
    }
    
    func createDirectory(withIntermediateDirectories: Bool = true, attributes: [String: Any]? = nil) {
        let manager = FileManager.default
        guard !manager.fileExists(atPath: path) else {
            return
        }
        do {
            try manager.createDirectory(at: self, withIntermediateDirectories: withIntermediateDirectories, attributes: attributes)
        } catch {
            print(error)
        }
    }
    
    func replacingPathExtension(_ pathExtension: String) -> URL {
        return deletingPathExtension().appendingPathExtension(pathExtension)
    }
    
    func removeItems(_ options: FileManager.DirectoryEnumerationOptions = .skipsHiddenFiles) {
        let manager = FileManager.default
        var isDirectory: ObjCBool = false
        guard manager.fileExists(atPath: path, isDirectory: &isDirectory) && isDirectory.boolValue else {
            return
        }
        do {
            let urls = try manager.contentsOfDirectory(at: self, includingPropertiesForKeys: nil, options: options)
            for url in urls {
                try manager.removeItem(at: url)
            }
        } catch {
            print(error)
        }
    }
}
