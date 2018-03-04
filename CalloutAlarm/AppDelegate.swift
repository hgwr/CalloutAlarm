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
        userDefaults.register(defaults: ["startTimeStr": "07:00",
                                         "finishTimeStr": "08:01",
                                         "speechTextAtTheStart": "おはようございます",
                                         "timeSpeechFormat": "時刻は %h 時 %m 分です。",
                                         "volumeStr": "50"])
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

