//
//  func testSpeechPlayer() {              } SpeechPlayerTests.swift
//  CalloutAlarmTests
//
//  Created by Shigeru Hagiwara on 2018/03/07.
//  Copyright © 2018年 Shigeru Hagiwara. All rights reserved.
//

import XCTest
@testable import CalloutAlarm

class SpeechPlayerTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testExample() {
        let player = SpeechPlayer()
        
        player.play("テスト")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
