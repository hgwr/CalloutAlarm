//
//  Libretto.swift
//  CalloutAlarm
//
//  Created by Shigeru Hagiwara on 2018/03/07.
//  Copyright © 2018年 Shigeru Hagiwara. All rights reserved.
//

import Foundation

// 時刻読み上げの台詞を管理するクラス (Libretto == 歌劇などの台本)
class Libretto {
    let utils = CalloutAlarmUtils()
    let calendar = Calendar(identifier: .gregorian)
    
    var queue: [String: String] = [:]
    var prelude: String? = nil
    
    func reset() {
        prelude = utils.speechTextAtTheStart
        
        self.queue = [:]
        
        guard let startTime = utils.startTime,
            let finishTime = utils.finishTime,
            let intervalSec = utils.speechIntervalSec else {
            fatalError("couldn't get startTime or finishTime or intervalSec")
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm"
        
        var t = startTime
        while t <= finishTime {
            let timeStr = formatter.string(from: t)
            let hour = calendar.component(.hour, from: t)
            let minute = calendar.component(.minute, from: t)
            let speechLine = utils.timeSpeechText(hour: hour, minute: minute)
            self.queue[timeStr] = speechLine
            t = calendar.date(byAdding: .second, value: intervalSec, to: t)!
        }
    }
}
