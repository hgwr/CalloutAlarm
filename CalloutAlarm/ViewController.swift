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
    
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSLog("### ViewController#viewDidLoad called.")

        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            let currentDate = Date()
            let timeStr = formatter.string(from: currentDate)
            self.timeLabel.stringValue = timeStr
            // NSLog("timer: %@", timeStr)
        }
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
        NSLog("speech switch clicked: %@", checked ? "ON" : "OFF")
        // TODO: ボタンの状態によって、読み上げするかどうか制御する
    }
}

