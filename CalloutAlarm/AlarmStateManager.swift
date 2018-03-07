//
//  AlarmStateManager.swift
//  CalloutAlarm
//
//  Created by Shigeru Hagiwara on 2018/03/07.
//  Copyright © 2018年 Shigeru Hagiwara. All rights reserved.
//

import Foundation

@objc protocol AlarmEventHandler {
    @objc optional func onStartActive()
    @objc optional func onActive()
    @objc optional func onStartInactive()
}

class AlarmStateManager {
    let utils = CalloutAlarmUtils()
    
    enum State {
        case inactive
        case active
    }

    var state: State = .inactive
    
    var delegate: AlarmEventHandler?
    
    init() {
        
    }
    
    var active: Bool {
        get { return self.state == .active }
    }
    var inactive: Bool {
        get { return self.state == .inactive }
    }
    func setActive() { self.state = .active }
    func setInactive() { self.state = .inactive }
    
    func isActiveStage(now: Date = Date()) -> Bool {
        guard let startTime = utils.startTime,
            let finishTime = utils.finishTime else {
                return false
        }
        return startTime <= now && now <= finishTime
    }
    
    func tick() {
        if isActiveStage() {
            if inactive {
                setActive()
                callOnStartActive()
            }
            callOnActive()
        } else {
            if active {
                setInactive()
                callOnStartInActive()
            }
        }
    }
    
    func callOnStartActive() {
        guard let delegate = self.delegate,
            let f = delegate.onStartActive else {
            return
        }
        f()
    }
    
    func callOnActive() {
        guard let delegate = self.delegate,
            let f = delegate.onActive else {
                return
        }
        f()
    }
    
    func callOnStartInActive() {
        guard let delegate = self.delegate,
            let f = delegate.onStartInactive else {
                return
        }
        f()
    }
}
