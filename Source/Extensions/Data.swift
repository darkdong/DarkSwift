//
//  Data.swift
//  DarkSwift
//
//  Created by Dark Dong on 2017/3/28.
//  Copyright © 2017年 Dark Dong. All rights reserved.
//

import Foundation
import CommonCrypto

public extension Data {
    enum DigestAlgorithm {
        case md5, sha1, sha224, sha256, sha384, sha512
        
        var hmacAlgorithm: CCHmacAlgorithm {
            let result: Int
            switch self {
            case .md5:
                result = kCCHmacAlgMD5
            case .sha1:
                result = kCCHmacAlgSHA1
            case .sha224:
                result = kCCHmacAlgSHA224
            case .sha256:
                result = kCCHmacAlgSHA256
            case .sha384:
                result = kCCHmacAlgSHA384
            case .sha512:
                result = kCCHmacAlgSHA512
            }
            return CCHmacAlgorithm(result)
        }
        
        var digestLength: Int {
            let result: CInt
            switch self {
            case .md5:
                result = CC_MD5_DIGEST_LENGTH
            case .sha1:
                result = CC_SHA1_DIGEST_LENGTH
            case .sha224:
                result = CC_SHA224_DIGEST_LENGTH
            case .sha256:
                result = CC_SHA256_DIGEST_LENGTH
            case .sha384:
                result = CC_SHA384_DIGEST_LENGTH
            case .sha512:
                result = CC_SHA512_DIGEST_LENGTH
            }
            return Int(result)
        }
        
        func hash(dataPointer: UnsafeRawPointer, dataLength: Int, outputPointer: UnsafeMutablePointer<UInt8>) {
            let length = CC_LONG(dataLength)
            switch self {
            case .md5:
                CC_MD5(dataPointer, length, outputPointer)
            case .sha1:
                CC_SHA1(dataPointer, length, outputPointer)
            case .sha224:
                CC_SHA224(dataPointer, length, outputPointer)
            case .sha256:
                CC_SHA256(dataPointer, length, outputPointer)
            case .sha384:
                CC_SHA384(dataPointer, length, outputPointer)
            case .sha512:
                CC_SHA512(dataPointer, length, outputPointer)
            }
        }
    }

    func hexString(lowercase: Bool = true) -> String {
        var string = ""
        let format = lowercase ? "%02x" : "%02X"
        enumerateBytes { (bytes, _, _) in
            for byte in bytes {
                string.append(String(format: format, byte))
            }
        }
        return string
    }
    
    func hash(algorithm: DigestAlgorithm, lowercase: Bool = true) -> String {
        let outputString = withUnsafeBytes { (pointer: UnsafePointer<UInt8>) -> String in
            let dataPtr = UnsafeRawPointer(pointer)
            var outputData = Data(count: algorithm.digestLength)
            outputData.withUnsafeMutableBytes { (outputPtr: UnsafeMutablePointer<UInt8>) in
                algorithm.hash(dataPointer: dataPtr, dataLength: count, outputPointer: outputPtr)
            }
            return outputData.hexString(lowercase: lowercase)
        }
        return outputString
    }

    func hmac(algorithm: DigestAlgorithm, keyData: Data, lowercase: Bool = true) -> String {
        let outputString = withUnsafeBytes { (pointer: UnsafePointer<UInt8>) -> String in
            let dataPtr = UnsafeRawPointer(pointer)
            let outputString = keyData.withUnsafeBytes { (pointer: UnsafePointer<UInt8>) -> String in
                let keyDataPtr = UnsafeRawPointer(pointer)
                var outputData = Data(count: algorithm.digestLength)
                outputData.withUnsafeMutableBytes { (outputPtr: UnsafeMutablePointer<UInt8>) in
                    CCHmac(algorithm.hmacAlgorithm, keyDataPtr, keyData.count, dataPtr, count, outputPtr)
                }
                return outputData.hexString(lowercase: lowercase)
            }
            return outputString
        }
        return outputString
    }
}
