//
//  SettingsViewController.swift
//  CalloutAlarm
//
//  Created by Shigeru Hagiwara on 2018/03/03.
//  Copyright © 2018年 Shigeru Hagiwara. All rights reserved.
//

import Cocoa

class SettingsViewController: NSViewController {
    @IBOutlet weak var startTimeStrField: NSTextField!
    @IBOutlet weak var finishTimeStrField: NSTextField!
    @IBOutlet weak var speechTextAtTheStartField: NSTextField!
    @IBOutlet weak var timeSpeechFormatField: NSTextField!
    @IBOutlet weak var volumeSlider: NSSlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func timeSpeechTestClicked(_ sender: Any) {
        NSLog("timeSpeechTestClicked")
    }
  
    @IBAction func startSpeechTestClicked(_ sender: Any) {
        NSLog("startSpeechTestClicked")
    }

    override func controlTextDidChange(_ notification: Notification) {
        switch notification.object {
        case let textField as NSTextField where textField === self.startTimeStrField:
            NSLog("startTimeStrField was changed")
        case let textField as NSTextField where textField === self.finishTimeStrField:
            NSLog("finishTimeStrField was changed")
        case let textField as NSTextField where textField === self.speechTextAtTheStartField:
            NSLog("speechTextAtTheStartField was changed")
        case let textField as NSTextField where textField === self.timeSpeechFormatField:
            NSLog("timeSpeechFormatField was changed")
        default:
            break
        }
    }
}
