//
//  LibrettoTests.swift
//  CalloutAlarmTests
//
//  Created by Shigeru Hagiwara on 2018/03/07.
//  Copyright © 2018年 Shigeru Hagiwara. All rights reserved.
//

import XCTest
@testable import CalloutAlarm

class LibrettoTests: XCTestCase {

    override func setUp() {
        super.setUp()
        
        UserDefaults.standard.set("07:00", forKey: CalloutAlarmKeys.startTimeStr)
        UserDefaults.standard.set("07:21", forKey: CalloutAlarmKeys.finishTimeStr)
        UserDefaults.standard.set("120", forKey: CalloutAlarmKeys.speechIntervalStr)
        UserDefaults.standard.set("ただいま時刻は%h時%m分です。", forKey: CalloutAlarmKeys.timeSpeechFormat)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testReset() {
        let utils = CalloutAlarmUtils()
        
        let libretto = Libretto()
        libretto.reset()
        
        XCTAssertEqual(libretto.prelude, utils.speechTextAtTheStart)
        XCTAssertEqual(libretto.queue.count, 11)
        XCTAssertEqual(libretto.queue["07:00"], "ただいま時刻は7時0分です。")
        XCTAssertEqual(libretto.queue["07:20"], "ただいま時刻は7時20分です。")
        XCTAssertEqual(libretto.queue["07:01"], nil)
    }

}
