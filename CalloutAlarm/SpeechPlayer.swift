//
//  SpeechPlayer.swift
//  CalloutAlarm
//
//  Created by Shigeru Hagiwara on 2018/03/07.
//  Copyright © 2018年 Shigeru Hagiwara. All rights reserved.
//

import Foundation
import AppKit

class SpeechPlayer: NSObject, NSSpeechSynthesizerDelegate {
    static let defaultRate: Float = 160
    static let defaultVolume: Float = 0.9
    static let kyoko = "com.apple.speech.synthesis.voice.kyoko"
    
    let speechSynth: NSSpeechSynthesizer?
    
    var speechFinishCallback: ((SpeechPlayer) -> ())?
    
    init(volume: Float) {
        let voiceName = NSSpeechSynthesizer.VoiceName(rawValue: SpeechPlayer.kyoko)
        self.speechSynth = NSSpeechSynthesizer(voice: voiceName)
        super.init()
        if let ss = self.speechSynth {
            ss.delegate = self
            ss.rate = SpeechPlayer.defaultRate
            ss.volume = volume
        }
    }
    
    convenience override init() {
        self.init(volume: SpeechPlayer.defaultVolume)
    }
    
    var rate: Float? {
        get {
            guard let ss = self.speechSynth else {
                return nil
            }
            return ss.rate
        }
        set {
            guard let ss = self.speechSynth,
                let v = newValue else {
                return
            }
            ss.rate = v
        }
    }

    var volume: Float? {
        get {
            guard let ss = self.speechSynth else {
                return nil
            }
            return ss.volume
        }
        set {
            guard let ss = self.speechSynth,
                let v = newValue else {
                return
            }
            ss.volume = v
        }
    }

    func say(_ text: String) {
        guard let speechSynth = self.speechSynth else {
            fatalError("speechSynth is nil")
        }
        speechSynth.startSpeaking(text)
    }
    
    func speechSynthesizer(_ sender: NSSpeechSynthesizer, didFinishSpeaking finishedSpeaking: Bool) {
        NSLog("speech finished")
        if let callback = self.speechFinishCallback {
            callback(self)
        }
    }
}
