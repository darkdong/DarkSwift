//
//  DarkSwiftTests.swift
//  DarkSwiftTests
//
//  Created by Dark Dong on 2017/3/31.
//  Copyright © 2017年 Dark Dong. All rights reserved.
//

import XCTest
@testable import DarkSwift

class DarkSwiftTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testLayout() {
        let container = UIView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        let v1 = UIView(frame: CGRect(x: 0, y: 0, width: 4, height: 4))
        container.layout(views: [v1], alignment: .horizontal(.center))
        XCTAssert(v1.frame.center == CGPoint(x: 12, y: 12))

        container.layout(views: [v1], alignment: .horizontal(.top))
        XCTAssert(v1.frame.center == CGPoint(x: 12, y: 2))

        container.layout(views: [v1], alignment: .horizontal(.bottom))
        XCTAssert(v1.frame.center == CGPoint(x: 12, y: 22))

        container.layout(views: [v1], alignment: .vertical(.left))
        XCTAssert(v1.frame.center == CGPoint(x: 2, y: 12))

        container.layout(views: [v1], alignment: .vertical(.right))
        XCTAssert(v1.frame.center == CGPoint(x: 22, y: 12))

        let v2 = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 8))

        container.layout(views: [v1, v2], alignment: .horizontal(.center))
        XCTAssert(v1.frame.center == CGPoint(x: 2, y: 12))
        XCTAssert(v2.frame.center == CGPoint(x: 20, y: 12))
        
        container.layout(views: [v1, v2], alignment: .horizontal(.top))
        XCTAssert(v1.frame.center == CGPoint(x: 2, y: 2))
        XCTAssert(v2.frame.center == CGPoint(x: 20, y: 4))
        
        container.layout(views: [v1, v2], alignment: .horizontal(.bottom))
        XCTAssert(v1.frame.center == CGPoint(x: 2, y: 22))
        XCTAssert(v2.frame.center == CGPoint(x: 20, y: 20))

        container.layout(views: [v1, v2], alignment: .vertical(.center))
        XCTAssert(v1.frame.center == CGPoint(x: 12, y: 2))
        XCTAssert(v2.frame.center == CGPoint(x: 12, y: 20))

        container.layout(views: [v1, v2], alignment: .vertical(.left))
        XCTAssert(v1.frame.center == CGPoint(x: 2, y: 2))
        XCTAssert(v2.frame.center == CGPoint(x: 4, y: 20))

        container.layout(views: [v1, v2], alignment: .vertical(.right))
        XCTAssert(v1.frame.center == CGPoint(x: 22, y: 2))
        XCTAssert(v2.frame.center == CGPoint(x: 20, y: 20))
    }
    
    func testDigest() {
        XCTAssert("".hash(algorithm: .md5) == "d41d8cd98f00b204e9800998ecf8427e")
        XCTAssert("".hash(algorithm: .sha1) == "da39a3ee5e6b4b0d3255bfef95601890afd80709")
        XCTAssert("".hash(algorithm: .sha224) == "d14a028c2a3a2bc9476102bb288234c415a2b01f828ea62ac5b3e42f")
        XCTAssert("".hash(algorithm: .sha256) == "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855")
        XCTAssert("".hash(algorithm: .sha384) == "38b060a751ac96384cd9327eb1b1e36a21fdb71114be07434c0cc7bf63f6e1da274edebfe76f65fbd51ad2f14898b95b")
        XCTAssert("".hash(algorithm: .sha512) == "cf83e1357eefb8bdf1542850d66d8007d620e4050b5715dc83f4a921d36ce9ce47d0d13c5d85f2b0ff8318d2877eec2f63b931bd47417a81a538327af927da3e")
        XCTAssert("".hmac(algorithm: .md5, key: "") == "74e6f7298a9c2d168935f58c001bad88")
        XCTAssert("".hmac(algorithm: .sha1, key: "") == "fbdb1d1b18aa6c08324b7d64b71fb76370690e1d")
        XCTAssert("".hmac(algorithm: .sha256, key: "") == "b613679a0814d9ec772f95d778c35fc5ff1697c493715653c6c712144292c5ad")
        
        let string = "The quick brown fox jumps over the lazy dog"
        XCTAssert(string.hash(algorithm: .sha1) == "2fd4e1c67a2d28fced849ee1bb76e7391b93eb12")
        XCTAssert(string.hmac(algorithm: .md5, key: "key") == "80070713463e7749b90c2dc24911e275")
        XCTAssert(string.hmac(algorithm: .sha1, key: "key") == "de7c9b85b8b78aa6bc8a7a36f70a90701c9db4d9")
        XCTAssert(string.hmac(algorithm: .sha256, key: "key") == "f7bc83f430538424b13298e6aa6fb143ef4d59a14946175997479dbc2d1a3cd8")
    }
}
