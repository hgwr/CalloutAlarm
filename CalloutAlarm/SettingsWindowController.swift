//
//  SettingsWindowController.swift
//  CalloutAlarm
//
//  Created by Shigeru Hagiwara on 2018/03/12.
//  Copyright © 2018年 Shigeru Hagiwara. All rights reserved.
//

import Cocoa

class SettingsWindowController: NSWindowController, NSWindowDelegate {

    override func windowDidLoad() {
        super.windowDidLoad()
    }

    func windowShouldClose(_ sender: NSWindow) -> Bool {
        NSLog("#### SettingsWindowController: windowShouldClose called")
        let vc = self.contentViewController as! SettingsViewController
        return vc.validateData()
    }
}
