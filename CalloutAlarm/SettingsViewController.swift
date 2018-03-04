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
        // Do view setup here.
    }
    
    @IBAction func timeSpeechTestClicked(_ sender: Any) {
    }
  
    @IBAction func startSpeechTestClicked(_ sender: Any) {
    }
}
