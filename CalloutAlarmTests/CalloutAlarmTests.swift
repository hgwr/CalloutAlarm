//
//  CalloutAlarmTests.swift
//  CalloutAlarmTests
//
//  Created by Shigeru Hagiwara on 2018/03/02.
//  Copyright © 2018年 Shigeru Hagiwara. All rights reserved.
//

import XCTest
@testable import CalloutAlarm

class CalloutAlarmTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testUtilsValidTimeFormat() {
        let util = CalloutAlarmUtils()
        
        XCTAssert(util.validTimeFormat("23:59"))
        XCTAssert(util.validTimeFormat("00:00"))
        XCTAssert(util.validTimeFormat("02:34"))

        XCTAssert(util.validTimeFormat("  12:34"))
        XCTAssert(util.validTimeFormat("2:34  "))
        XCTAssert(util.validTimeFormat(" 02:34 "))
        
        XCTAssert(!util.validTimeFormat("a"))
        XCTAssert(!util.validTimeFormat("a2:34"))
        XCTAssert(!util.validTimeFormat("0234"))
        XCTAssert(!util.validTimeFormat("34:34"))
        XCTAssert(!util.validTimeFormat("12:62"))
    }
    
    func testStartTime() {
        let util = CalloutAlarmUtils()
        
        UserDefaults.standard.set("07:31", forKey: CalloutAlarmKeys.startTimeStr)
        guard let startTime = util.startTime else {
            fatalError("startTime must not be nil")
        }
        let calendar = Calendar(identifier: .gregorian)
        let hour = calendar.component(.hour, from: startTime)
        XCTAssertEqual(hour, 7)
        let minute = calendar.component(.minute, from: startTime)
        XCTAssertEqual(minute, 31)
    }

    func testFinishTime() {
        let util = CalloutAlarmUtils()
        
        UserDefaults.standard.set("08:32", forKey: CalloutAlarmKeys.finishTimeStr)
        guard let finishTime = util.finishTime else {
            fatalError("finishTime must not be nil")
        }
        let calendar = Calendar(identifier: .gregorian)
        let hour = calendar.component(.hour, from: finishTime)
        XCTAssertEqual(hour, 8)
        let minute = calendar.component(.minute, from: finishTime)
        XCTAssertEqual(minute, 32)
    }
    
    func testSpeechIntervalSec() {
        let util = CalloutAlarmUtils()
        UserDefaults.standard.set("123", forKey: CalloutAlarmKeys.speechIntervalStr)
        guard let interval = util.speechIntervalSec else {
            fatalError("interval must not be nil")
        }
        XCTAssertEqual(interval, 123)
    }
}
