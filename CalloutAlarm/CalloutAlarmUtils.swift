//
//  CalloutAlarmUtils.swift
//  CalloutAlarm
//
//  Created by Shigeru Hagiwara on 2018/03/05.
//  Copyright © 2018年 Shigeru Hagiwara. All rights reserved.
//

import Cocoa

extension String {
    func matches(for regex: String) -> [String]? {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let nsString = self as NSString
            let results = regex.matches(in: self, range: NSRange(location: 0, length: nsString.length))
            var matchedStrings = [String]()
            for i in 0 ..< results.count {
                for j in 0 ..< results[i].numberOfRanges {
                    let range = results[i].range(at: j)
                    matchedStrings.append(nsString.substring(with: range))
                }
            }
            if matchedStrings.count > 0 {
                return matchedStrings
            } else {
                return nil
            }
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return nil
        }
    }
    
    var strip: String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
}

extension Array {
    // https://stackoverflow.com/a/25330930
    // Safely lookup an index that might be out of bounds,
    // returning nil if it does not exist
    func get(_ index: Int) -> Element? {
        if 0 <= index && index < count {
            return self[index]
        } else {
            return nil
        }
    }
}

class CalloutAlarmUtils {

    // MARK: - Callout Alarm Data Accessor: UserDefaults wrappers
    
    let calendar = Calendar(identifier: .gregorian)
    
    var currentYmd: [Int] {
        get {
            let now = Date()
            let year = calendar.component(.year, from: now)
            let month = calendar.component(.month, from: now)
            let day = calendar.component(.day, from: now)
            return [year, month, day]
        }
    }

    var startTime: Date? {
        get {
            let startTimeStr: String = UserDefaults.standard.string(forKey: CalloutAlarmKeys.startTimeStr) ??
                CalloutAlarmDefaults.startTimeStr
            
            guard let matches = startTimeStr.matches(for: "([0-9]+):([0-9]+)") else {
                return nil
            }
            let hour = Int(matches[1])
            let minute = Int(matches[2])
            let ymd = self.currentYmd
            let startTime = calendar.date(from: DateComponents(year: ymd[0], month: ymd[1], day: ymd[2],
                                                               hour: hour, minute: minute))
            
            return startTime
        }
    }
    
    var finishTime: Date? {
        get {
            let finishTimeStr: String = UserDefaults.standard.string(forKey: CalloutAlarmKeys.finishTimeStr) ??
                CalloutAlarmDefaults.finishTimeStr
            
            guard let matches = finishTimeStr.matches(for: "([0-9]+):([0-9]+)") else {
                return nil
            }
            let hour = Int(matches[1])
            let minute = Int(matches[2])
            let ymd = self.currentYmd
            let finishTime = calendar.date(from: DateComponents(year: ymd[0], month: ymd[1], day: ymd[2],
                                                               hour: hour, minute: minute))
            
            return finishTime
        }
    }
    
    var speechIntervalSec: Int? {
        get {
            let intervalStr = UserDefaults.standard.string(forKey: CalloutAlarmKeys.speechIntervalStr) ??
                CalloutAlarmDefaults.speechIntervalStr
            return Int(intervalStr)
        }
    }
    
    var speechVolume: Float {
        get {
            let volumeInt = UserDefaults.standard.integer(forKey: CalloutAlarmKeys.volume)
            return (Float(volumeInt) / 100.0)
        }
    }
    
    var speechTextAtTheStart: String {
        get {
            return UserDefaults.standard.string(forKey: CalloutAlarmKeys.speechTextAtTheStart) ??
            CalloutAlarmDefaults.speechTextAtTheStart
        }
    }
    
    // MARK: - Validation
    
    func parseTimeStr(_ text: String) -> [Int]? {
        if let matches = text.strip.matches(for: "^([0-9]+):([0-9]+)$"),
            matches.count == 3,
            let hourStr = matches.get(1),
            let minuteStr = matches.get(2),
            let hour = Int(hourStr),
            let minute = Int(minuteStr),
            hour >= 0 && hour <= 23 &&
                minute >= 0 && minute <= 59 {
            NSLog("### parseTimeStr: %@ -> %d:%d", text, hour, minute)
            return [hour, minute]
        }
        NSLog("### parseTimeStr: %@ -> nil", text)
        return nil
    }
    
    func validTimeFormat(_ text: String) -> Bool {
        if let _ = parseTimeStr(text) {
            return true
        } else {
            return false
        }
    }
    
    // MARK: - Alert Message Dialog
    
    func alert(_ message: String) {
        let alert = NSAlert()
        alert.messageText = message
        alert.runModal()
    }
}
