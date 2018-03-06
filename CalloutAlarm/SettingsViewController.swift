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
    @IBOutlet weak var speechIntervalStrField: NSTextField!
    @IBOutlet weak var speechTextAtTheStartField: NSTextField!
    @IBOutlet weak var timeSpeechFormatField: NSTextField!
    @IBOutlet weak var volumeSlider: NSSlider!
    
    let utils = CalloutAlarmUtils()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear() {
        let userDefaults = UserDefaults.standard
        guard
            let startTimeStr = userDefaults.string(forKey: CalloutAlarmKeys.startTimeStr),
            let finishTimeStr = userDefaults.string(forKey: CalloutAlarmKeys.finishTimeStr),
            let speechIntervalStr = userDefaults.string(forKey: CalloutAlarmKeys.speechIntervalStr),
            let speechTextAtTheStart = userDefaults.string(forKey: CalloutAlarmKeys.speechTextAtTheStart),
            let timeSpeechFormat = userDefaults.string(forKey: CalloutAlarmKeys.timeSpeechFormat)
            else {
                fatalError("default not set??")
        }
        self.startTimeStrField.stringValue = startTimeStr
        self.finishTimeStrField.stringValue = finishTimeStr
        self.speechIntervalStrField.stringValue = speechIntervalStr
        self.speechTextAtTheStartField.stringValue = speechTextAtTheStart
        self.timeSpeechFormatField.stringValue = timeSpeechFormat
        self.volumeSlider.integerValue = userDefaults.integer(forKey: CalloutAlarmKeys.volume)
    }
    
    @IBAction func timeSpeechTestClicked(_ sender: Any) {
        NSLog("timeSpeechTestClicked")
    }
  
    @IBAction func startSpeechTestClicked(_ sender: Any) {
        NSLog("startSpeechTestClicked")
    }
    
    @IBAction func volumeSliderChanged(_ sender: NSSlider) {
        UserDefaults.standard.set(self.volumeSlider.integerValue, forKey: CalloutAlarmKeys.volume)
    }
    
    @IBAction func okButtonClicked(_ sender: Any) {
        self.view.window!.close()
    }
    
    override func controlTextDidChange(_ notification: Notification) {
        let userDefaults = UserDefaults.standard
        
        switch notification.object {
            
        case let textField as NSTextField where textField === self.startTimeStrField:
            let fieldValue = textField.stringValue
            if utils.validTimeFormat(fieldValue) {
                userDefaults.set(fieldValue, forKey: CalloutAlarmKeys.startTimeStr)
            } else {
                let startTimeStr: String = UserDefaults.standard.string(forKey: CalloutAlarmKeys.startTimeStr) ?? CalloutAlarmDefaults.startTimeStr
                textField.stringValue = startTimeStr
                utils.alert("時刻は「12:34」のような形式で入力してください。")
            }
            
        case let textField as NSTextField where textField === self.finishTimeStrField:
            let fieldValue = textField.stringValue
            if utils.validTimeFormat(fieldValue) {
                userDefaults.set(fieldValue, forKey: CalloutAlarmKeys.finishTimeStr)
            } else {
                let startTimeStr: String = UserDefaults.standard.string(forKey: CalloutAlarmKeys.startTimeStr) ?? CalloutAlarmDefaults.startTimeStr
                textField.stringValue = startTimeStr
                utils.alert("時刻は「12:34」のような形式で入力してください。")
            }
            
        case let textField as NSTextField where textField === self.speechTextAtTheStartField:
            let fieldValue = textField.stringValue
            userDefaults.set(fieldValue, forKey: CalloutAlarmKeys.speechTextAtTheStart)
            
        case let textField as NSTextField where textField === self.timeSpeechFormatField:
            let fieldValue = textField.stringValue
            userDefaults.set(fieldValue, forKey: CalloutAlarmKeys.timeSpeechFormat)
            
        default:
            break
        }
    }
}
