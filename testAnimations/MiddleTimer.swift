//
//  MiddleTimer.swift
//  testAnimations
//
//  Created by Justin Smith on 10/28/15.
//  Copyright © 2015 Justin Smith. All rights reserved.
//

import UIKit

class MiddleTimer: NSObject {
    
    static let notificationSecondTick = "TimerNotificationSecondTick"
    static let notificationComplete = "TimerNotificationComplete"
    
    private(set) var seconds = NSTimeInterval(0)
    private var timer: NSTimer?
    var isOn: Bool {
        get {
            if timer != nil {
                return true
            } else {
                return false
            }
        }
    }
    var string: String {
        get {
            let totalSeconds = Int(self.seconds)
            
            let hours = totalSeconds / 3600
            let minutes = (totalSeconds - (hours * 3600)) / 60
            let seconds = totalSeconds - (hours * 3600) - (minutes * 60)
            
            var hoursString = ""
            if hours > 0 {
                hoursString = "\(hours):"
            }
            
            var minutesString = ""
            if minutes < 10 {
                minutesString = "0\(minutes):"
            } else {
                minutesString = "\(minutes):"
            }
            
            var secondsString = ""
            if seconds < 10 {
                secondsString = "0\(seconds)"
            } else {
                secondsString = "\(seconds)"
            }
            
            return hoursString + minutesString + secondsString
        }
    }
    
    var minutes: String
        {
        get
        {
            let totalSeconds = Int(self.seconds)
            
            let hours = totalSeconds / 3600
            let minutes = (totalSeconds - (hours * 3600)) / 60
            
            var minutesString = ""
            if minutes < 10
            {
                minutesString = "0\(minutes)"
            }
            else
            {
                minutesString = "\(minutes)"
            }
            
            return minutesString
        }
    }
    
    var secondsLeft: String
    {
        get
        {
            let totalSeconds = Int(self.seconds)
            
            let hours = totalSeconds / 3600
            let minutes = (totalSeconds - (hours * 3600)) / 60
            let seconds = totalSeconds - (hours * 3600) - (minutes * 60)
            
            var secondsString = ""
            if seconds < 10
            {
                secondsString = "0\(seconds)"
            }
            else
            {
                secondsString = "\(seconds)"
            }
            
            return secondsString
        }
    }
    
    func setTimer(seconds: NSTimeInterval)
    {
        self.seconds = seconds
    }
    
    func startTimer()
    {
        if !isOn {
            timer = NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(1.0), target: self, selector: "secondTick", userInfo: nil, repeats: true)
        }
    }
    
    func stopTimer()
    {
        self.seconds = NSTimeInterval(0)
        
        if isOn {
            timer?.invalidate()
            timer = nil
        }
    }
    
    func secondTick() {
        seconds--
        NSNotificationCenter.defaultCenter().postNotificationName(MiddleTimer.notificationSecondTick, object: self)
        if seconds <= 0 {
            stopTimer()
            NSNotificationCenter.defaultCenter().postNotificationName(MiddleTimer.notificationComplete, object: self)
        }
    }
}
