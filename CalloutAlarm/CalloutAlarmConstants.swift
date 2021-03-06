//
//  CalloutAlarmConstants.swift
//  CalloutAlarm
//
//  Created by Shigeru Hagiwara on 2018/03/05.
//  Copyright © 2018年 Shigeru Hagiwara. All rights reserved.
//

import Foundation

struct CalloutAlarmKeys {
    static let shouldSpeech = "shouldSpeech"
    static let startTimeStr = "startTimeStr"
    static let finishTimeStr = "finishTimeStr"
    static let speechIntervalStr = "speechIntervalStr"
    static let speechTextAtTheStart = "speechTextAtTheStart"
    static let timeSpeechFormat = "timeSpeechFormat"
    static let volume = "volume"
}

struct CalloutAlarmDefaults {
    static let shouldSpeech = true
    static let startTimeStr = "07:00"
    static let finishTimeStr = "08:01"
    static let speechIntervalStr = "180"
    static let speechTextAtTheStart = NSLocalizedString("Good morning", comment: "")
    static let timeSpeechFormat = NSLocalizedString("It's ... o'clock", comment: "")
    static let volume: Int = 90
}
