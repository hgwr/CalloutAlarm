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

    func testSay() {
        let player = SpeechPlayer()
        
        let speechFinishExpectation = self.expectation(description: "speech finished")
        player.speechFinishCallback = { player in
            speechFinishExpectation.fulfill()
            XCTAssert(true)
        }
        player.rate = 160
        player.volume = 0.9
        player.say("おはようございます。これはテストです。")
        waitForExpectations(timeout: 15) { error in
            if let error = error {
                XCTFail(error.localizedDescription)
            }
        }
    }
}
