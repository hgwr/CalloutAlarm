//
//  ViewController.swift
//  CalloutAlarm
//
//  Created by Shigeru Hagiwara on 2018/03/02.
//  Copyright © 2018年 Shigeru Hagiwara. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var timeLabel: NSTextField!
    @IBOutlet weak var shouldSpeechSwitchButton: NSButton!
    
    let utils = CalloutAlarmUtils()
    
    var timer: Timer?
    
    var shouldSpeech: Bool {
        get {
            return UserDefaults.standard.bool(forKey: CalloutAlarmKeys.shouldSpeech)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: CalloutAlarmKeys.shouldSpeech)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: 読み上げ台詞キューを作成

        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            let currentDate = Date()
            let timeStr = formatter.string(from: currentDate)
            self.timeLabel.stringValue = timeStr
            
            // TODO: 該当時刻かつ speechSwitch が ON だったら、
            // 読み上げ台詞キューから台詞を取り出して、時刻読み上げ
            // 範囲時間外
            // 状態管理
            
            if (self.shouldSpeech) {
                // let player = SpeechPlayer(volume: self.utils.speechVolume)
                // player.say(self.utils.currentTimeSpeechText)
                NSLog(self.utils.currentTimeSpeechText)
            }
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
