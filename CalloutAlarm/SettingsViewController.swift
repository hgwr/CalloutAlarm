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
        self.view.window?.title = NSLocalizedString("Preferences", comment: "")
        
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
    
    override func viewWillDisappear() {
        // TODO: validation
        UserDefaults.standard.synchronize()
    }
    
    @IBAction func timeSpeechTestClicked(_ sender: Any) {
        NSLog("timeSpeechTestClicked")
        let player = SpeechPlayer(volume: utils.speechVolume)
        player.say(utils.currentTimeSpeechText)
    }
  
    @IBAction func startSpeechTestClicked(_ sender: Any) {
        NSLog("startSpeechTestClicked: volume = %f", utils.speechVolume)
        let player = SpeechPlayer(volume: utils.speechVolume)
        player.say(utils.speechTextAtTheStart)
    }
    
    @IBAction func volumeSliderChanged(_ sender: NSSlider) {
        UserDefaults.standard.set(self.volumeSlider.integerValue, forKey: CalloutAlarmKeys.volume)
        NSLog("volumeSliderChanged: self.volumeSlider.integerValue = %d", self.volumeSlider.integerValue)
        NSLog("utils.speechVolume = %f", utils.speechVolume)
    }
    
    @IBAction func okButtonClicked(_ sender: Any) {
        self.view.window!.close()
    }
    
    override func controlTextDidEndEditing(_ notification: Notification) {
        let userDefaults = UserDefaults.standard
        
        switch notification.object {
            
        case let textField as NSTextField where textField === self.startTimeStrField:
            let fieldValue = textField.stringValue
            if utils.validTimeFormat(fieldValue) {
                userDefaults.set(fieldValue.strip, forKey: CalloutAlarmKeys.startTimeStr)
            } else {
                let startTimeStr: String = UserDefaults.standard.string(forKey: CalloutAlarmKeys.startTimeStr) ?? CalloutAlarmDefaults.startTimeStr
                textField.stringValue = startTimeStr
                utils.alert("時刻は「12:34」のような形式で入力してください。")
            }
            
        case let textField as NSTextField where textField === self.finishTimeStrField:
            let fieldValue = textField.stringValue
            if utils.validTimeFormat(fieldValue) {
                userDefaults.set(fieldValue.strip, forKey: CalloutAlarmKeys.finishTimeStr)
            } else {
                let finishTimeStr: String = UserDefaults.standard.string(forKey: CalloutAlarmKeys.finishTimeStr) ?? CalloutAlarmDefaults.finishTimeStr
                textField.stringValue = finishTimeStr
                utils.alert("時刻は「12:34」のような形式で入力してください。")
            }
            
        case let textField as NSTextField where textField === self.speechIntervalStrField:
            let fieldValue = textField.stringValue
            if let matches = fieldValue.strip.matches(for: "^([0-9]+)$"),
                matches.count == 2,
                let intervalSec = Int(matches[1]),
                intervalSec >= 30 && intervalSec <= 60 * 60 * 2 {
                userDefaults.set(fieldValue.strip, forKey: CalloutAlarmKeys.speechIntervalStr)
            } else {
                let speechIntervalStr: String = UserDefaults.standard.string(forKey: CalloutAlarmKeys.speechIntervalStr) ?? CalloutAlarmDefaults.speechIntervalStr
                textField.stringValue = speechIntervalStr
                utils.alert("読み上げ間隔(秒)は、「180」のような形式で入力してください。30 から 7200 が有効な値です。")
            }
            
        case let textField as NSTextField where textField === self.speechTextAtTheStartField:
            let fieldValue = textField.stringValue
            userDefaults.set(fieldValue.strip, forKey: CalloutAlarmKeys.speechTextAtTheStart)
            
        case let textField as NSTextField where textField === self.timeSpeechFormatField:
            let fieldValue = textField.stringValue
            userDefaults.set(fieldValue.strip, forKey: CalloutAlarmKeys.timeSpeechFormat)
            
        default:
            break
        }
    }
}
