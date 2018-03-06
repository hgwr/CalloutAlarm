//
//  AppDelegate.swift
//  CalloutAlarm
//
//  Created by Shigeru Hagiwara on 2018/03/02.
//  Copyright © 2018年 Shigeru Hagiwara. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        NSLog("### applicationDidFinishLaunching called")
        
        let userDefaults = UserDefaults.standard
        let defaults: [String:Any] =
            [CalloutAlarmKeys.startTimeStr: CalloutAlarmDefaults.startTimeStr,
             CalloutAlarmKeys.finishTimeStr: CalloutAlarmDefaults.finishTimeStr,
             CalloutAlarmKeys.speechIntervalStr: CalloutAlarmDefaults.speechIntervalStr,
             CalloutAlarmKeys.speechTextAtTheStart: CalloutAlarmDefaults.speechTextAtTheStart,
             CalloutAlarmKeys.timeSpeechFormat: CalloutAlarmDefaults.timeSpeechFormat,
             CalloutAlarmKeys.volume: CalloutAlarmDefaults.volume]
        userDefaults.register(defaults: defaults)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

