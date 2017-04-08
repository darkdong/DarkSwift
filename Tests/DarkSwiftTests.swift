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
        let container = UIView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 320, height: 320)))
        let insets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        let v1 = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 40))
        let v2 = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 100))
        let v3 = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        var views = [v1, v2, v3]
        container.layoutSubviews(views, alignment: .horizontal(.center), insets: insets)
        XCTAssert(v1.frame.center == CGPoint(x: 60, y: 160))
        XCTAssert(v2.frame.center == CGPoint(x: 160, y: 160))
        XCTAssert(v3.frame.center == CGPoint(x: 260, y: 160))

        container.layoutSubviews(views, alignment: .horizontal(.top), insets: insets)
        XCTAssert(v1.frame.center == CGPoint(x: 60, y: 40))
        XCTAssert(v2.frame.center == CGPoint(x: 160, y: 70))
        XCTAssert(v3.frame.center == CGPoint(x: 260, y: 60))

        container.layoutSubviews(views, alignment: .horizontal(.bottom), insets: insets)
        XCTAssert(v1.frame.center == CGPoint(x: 60, y: 280))
        XCTAssert(v2.frame.center == CGPoint(x: 160, y: 250))
        XCTAssert(v3.frame.center == CGPoint(x: 260, y: 260))

        container.layoutSubviews(views, alignment: .vertical(.center), insets: insets)
        XCTAssert(v1.frame.center == CGPoint(x: 160, y: 40))
        XCTAssert(v2.frame.center == CGPoint(x: 160, y: 140))
        XCTAssert(v3.frame.center == CGPoint(x: 160, y: 260))

        container.layoutSubviews(views, alignment: .vertical(.left), insets: insets)
        XCTAssert(v1.frame.center == CGPoint(x: 60, y: 40))
        XCTAssert(v2.frame.center == CGPoint(x: 60, y: 140))
        XCTAssert(v3.frame.center == CGPoint(x: 60, y: 260))

        container.layoutSubviews(views, alignment: .vertical(.right), insets: insets)
        XCTAssert(v1.frame.center == CGPoint(x: 260, y: 40))
        XCTAssert(v2.frame.center == CGPoint(x: 260, y: 140))
        XCTAssert(v3.frame.center == CGPoint(x: 260, y: 260))

        let v4 = v3.clone() as! UIView
        let v5 = v2.clone() as! UIView
        let v6 = v1.clone() as! UIView
        views = [v1, v2, v3, v4, v5, v6]
        container.layoutSubviews(views, alignment: .tabular(2, 3, CGSize(width: 80, height: 80)), insets: insets)
        XCTAssert(v1.frame.center == CGPoint(x: 60, y: 90))
        XCTAssert(v2.frame.center == CGPoint(x: 160, y: 90))
        XCTAssert(v3.frame.center == CGPoint(x: 260, y: 90))
        XCTAssert(v4.frame.center == CGPoint(x: 60, y: 230))
        XCTAssert(v5.frame.center == CGPoint(x: 160, y: 230))
        XCTAssert(v6.frame.center == CGPoint(x: 260, y: 230))
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
