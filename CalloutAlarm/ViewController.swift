//
//  ViewController.swift
//  CalloutAlarm
//
//  Created by Shigeru Hagiwara on 2018/03/02.
//  Copyright © 2018年 Shigeru Hagiwara. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, AlarmEventHandler {

    @IBOutlet weak var timeLabel: NSTextField!
    @IBOutlet weak var shouldSpeechSwitchButton: NSButton!
    
    let utils = CalloutAlarmUtils()
    let libretto = Libretto()
    
    var timer: Timer?
    var stateManager = AlarmStateManager()
    
    var shouldSpeech: Bool {
        get {
            return UserDefaults.standard.bool(forKey: CalloutAlarmKeys.shouldSpeech)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: CalloutAlarmKeys.shouldSpeech)
        }
    }
    
    func onStartActive() {
        NSLog("onStartActive")
        libretto.reset()
        // TODO: start caffeinate
    }
    
    func onActive() {
        if (self.shouldSpeech) {
            var speechLine = ""
            if let prelude = libretto.getPrelude() {
                speechLine = prelude
            }
            if let line = libretto.getSpeechLine() {
                speechLine += " " + line
            }
            let player = SpeechPlayer(volume: self.utils.speechVolume)
            player.say(speechLine)
        }
    }
    
    func onStartInactive() {
        NSLog("onStartInactive")
        // TODO: finish caffeinate
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.stateManager.delegate = self

        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            let currentDate = Date()
            let timeStr = formatter.string(from: currentDate)
            self.timeLabel.stringValue = timeStr
            
            self.stateManager.tick()
        }
    }
    
    override func viewWillAppear() {
        let shouldSpeech = self.shouldSpeech
        
        self.shouldSpeechSwitchButton.state = shouldSpeech ?
            NSControl.StateValue.on : NSControl.StateValue.off
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    override func viewDidDisappear() {
        if let timer = self.timer {
            timer.invalidate()
            self.timer = nil
        }
    }
    
    @IBAction func speechSwitchClicked(_ sender: NSButton) {
        let checked = (sender.state == NSControl.StateValue.on)
        self.shouldSpeech = checked
    }
}
