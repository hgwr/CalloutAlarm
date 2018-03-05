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
    
    override func viewWillAppear() {
        guard
            let startTimeStr = UserDefaults.standard.string(forKey: CalloutAlarmKeys.startTimeStr),
            let finishTimeStr = UserDefaults.standard.string(forKey: CalloutAlarmKeys.finishTimeStr),
            let speechTextAtTheStart = UserDefaults.standard.string(forKey: CalloutAlarmKeys.speechTextAtTheStart),
            let timeSpeechFormat = UserDefaults.standard.string(forKey: CalloutAlarmKeys.timeSpeechFormat)
            else {
                fatalError("default not set??")
        }
        self.startTimeStrField.stringValue = startTimeStr
        self.finishTimeStrField.stringValue = finishTimeStr
        self.speechTextAtTheStartField.stringValue = speechTextAtTheStart
        self.timeSpeechFormatField.stringValue = timeSpeechFormat
        self.volumeSlider.integerValue = UserDefaults.standard.integer(forKey: CalloutAlarmKeys.volume)
    }
    
    @IBAction func timeSpeechTestClicked(_ sender: Any) {
        NSLog("timeSpeechTestClicked")
    }
  
    @IBAction func startSpeechTestClicked(_ sender: Any) {
        NSLog("startSpeechTestClicked")
    }

    override func controlTextDidChange(_ notification: Notification) {
        let userDefaults = UserDefaults.standard
        
        switch notification.object {
            
        case let textField as NSTextField where textField === self.startTimeStrField:
            let fieldValue = textField.stringValue
            if validTimeFormat(fieldValue) {
                userDefaults.set(fieldValue, forKey: CalloutAlarmKeys.startTimeStr)
            }
            
        case let textField as NSTextField where textField === self.finishTimeStrField:
            let fieldValue = textField.stringValue
            if validTimeFormat(fieldValue) {
                userDefaults.set(fieldValue, forKey: CalloutAlarmKeys.finishTimeStr)
            }
            
        case let textField as NSTextField where textField === self.speechTextAtTheStartField:
            let fieldValue = textField.stringValue
            if validTimeFormat(fieldValue) {
                userDefaults.set(fieldValue, forKey: CalloutAlarmKeys.speechTextAtTheStart)
            }
            
        case let textField as NSTextField where textField === self.timeSpeechFormatField:
            let fieldValue = textField.stringValue
            if validTimeFormat(fieldValue) {
                userDefaults.set(fieldValue, forKey: CalloutAlarmKeys.timeSpeechFormat)
            }
            
        default:
            break
        }
    }
    
    func validTimeFormat(_ value: String) -> Bool {
        // TODO: ちゃんと実装する
        return true
    }
}
