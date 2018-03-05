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
        
        XCTAssert(util.validTimeFormat("12:34"))
        XCTAssert(util.validTimeFormat("2:34"))
        XCTAssert(util.validTimeFormat("02:34"))

        XCTAssert(!util.validTimeFormat("a"))
        XCTAssert(!util.validTimeFormat("a2:34"))
        XCTAssert(!util.validTimeFormat("0234"))
        XCTAssert(!util.validTimeFormat("34:34"))
        XCTAssert(!util.validTimeFormat("12:62"))
    }
}
