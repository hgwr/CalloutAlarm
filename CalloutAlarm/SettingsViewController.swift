//
//  SettingsViewController.swift
//  CalloutAlarm
//
//  Created by Shigeru Hagiwara on 2018/03/03.
//  Copyright © 2018年 Shigeru Hagiwara. All rights reserved.
//

import Cocoa

class SettingsViewController: NSViewController {
    
    // MARK: - instance variables

    @IBOutlet weak var startTimeStrField: NSTextField!
    @IBOutlet weak var finishTimeStrField: NSTextField!
    @IBOutlet weak var speechIntervalStrField: NSTextField!
    @IBOutlet weak var speechTextAtTheStartField: NSTextField!
    @IBOutlet weak var timeSpeechFormatField: NSTextField!
    @IBOutlet weak var volumeSlider: NSSlider!
    
    let utils = CalloutAlarmUtils()
    
    // MARK: - NSViewController overrides
    
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
        NSLog("SettingsViewController: preference window viewWillDisappear")
        UserDefaults.standard.synchronize()
    }
    
    // MARK: - Actions
    
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
        self.view.window!.performClose(self)
    }
    
    // MARK: - NSControl overrides
    
    override func controlTextDidEndEditing(_ notification: Notification) {
        switch notification.object {
        case let textField as NSTextField where textField === self.startTimeStrField:
            _ = validateAndSaveStartTime()
        case let textField as NSTextField where textField === self.finishTimeStrField:
            _ = validateAndSaveFinishTime()
        case let textField as NSTextField where textField === self.speechIntervalStrField:
            _ = validateAndSaveSpeechInterval()
        case let textField as NSTextField where textField === self.speechTextAtTheStartField:
            saveSpeechTextAtTheStart()
        case let textField as NSTextField where textField === self.timeSpeechFormatField:
            saveTimeSpeechFormat()
        default:
            break
        }
    }
    
    // MARK: - validators
    
    func validateAndSaveStartTime() -> Bool {
        let fieldValue = startTimeStrField.stringValue
        if utils.validTimeFormat(fieldValue) {
            UserDefaults.standard.set(fieldValue.strip, forKey: CalloutAlarmKeys.startTimeStr)
            return true
        } else {
            let startTimeStr: String =
                UserDefaults.standard.string(forKey: CalloutAlarmKeys.startTimeStr) ??
                    CalloutAlarmDefaults.startTimeStr
            startTimeStrField.stringValue = startTimeStr
            utils.alert(NSLocalizedString("time format alert", comment: ""))
            return false
        }
    }
    
    func validateAndSaveFinishTime() -> Bool {
        let fieldValue = finishTimeStrField.stringValue
        if utils.validTimeFormat(fieldValue) {
            UserDefaults.standard.set(fieldValue.strip, forKey: CalloutAlarmKeys.finishTimeStr)
            return true
        } else {
            let finishTimeStr: String =
                UserDefaults.standard.string(forKey: CalloutAlarmKeys.finishTimeStr) ??
                    CalloutAlarmDefaults.finishTimeStr
            finishTimeStrField.stringValue = finishTimeStr
            utils.alert(NSLocalizedString("time format alert", comment: ""))
            return false
        }
    }
    
    func validateAndSaveSpeechInterval() -> Bool {
        let fieldValue = speechIntervalStrField.stringValue
        if let matches = fieldValue.strip.matches(for: "^([0-9]+)$"),
            matches.count == 2,
            let intervalSec = Int(matches[1]),
            intervalSec >= 30 && intervalSec <= 60 * 60 * 2 {
            UserDefaults.standard.set(fieldValue.strip, forKey: CalloutAlarmKeys.speechIntervalStr)
            return true
        } else {
            let speechIntervalStr: String = UserDefaults.standard.string(forKey: CalloutAlarmKeys.speechIntervalStr) ?? CalloutAlarmDefaults.speechIntervalStr
            speechIntervalStrField.stringValue = speechIntervalStr
            utils.alert(NSLocalizedString("speech interval warning", comment: ""))
            return false
        }
    }
    
    func validateData() -> Bool {
        return (validateAndSaveStartTime() &&
            validateAndSaveFinishTime() &&
            validateAndSaveSpeechInterval())
    }
    
    // MARK: - UserDefaults savers
    
    func saveSpeechTextAtTheStart() {
        let fieldValue = speechTextAtTheStartField.stringValue
        UserDefaults.standard.set(fieldValue.strip, forKey: CalloutAlarmKeys.speechTextAtTheStart)
    }
    
    func saveTimeSpeechFormat() {
        let fieldValue = timeSpeechFormatField.stringValue
        UserDefaults.standard.set(fieldValue.strip, forKey: CalloutAlarmKeys.timeSpeechFormat)
    }
    
    func validateDataAndSave() -> Bool {
        saveSpeechTextAtTheStart()
        saveTimeSpeechFormat()
        return validateData()
    }
    
}
