//
//  caffeinateTests.swift
//  CalloutAlarmTests
//
//  Created by Shigeru Hagiwara on 2018/03/08.
//  Copyright © 2018年 Shigeru Hagiwara. All rights reserved.
//

import XCTest
@testable import CalloutAlarm

class caffeinateTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testExample() {
        let caffeinateResult = doCaffeinate()
        XCTAssert(caffeinateResult)
        let uncaffeinateResult = unCaffeinate()
        XCTAssert(uncaffeinateResult)
    }
}
