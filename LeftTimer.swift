//
//  LeftTimer.swift
//  testAnimations
//
//  Created by Justin Smith on 10/28/15.
//  Copyright © 2015 Justin Smith. All rights reserved.
//

import UIKit

class LeftTimer: NSObject, NSCoding {
    
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
    
    init(seconds: NSTimeInterval = NSTimeInterval(300))
    {
        self.seconds = seconds
    }
    
    convenience required init?(coder aDecoder: NSCoder)
    {
        guard let seconds = aDecoder.decodeObjectForKey("leftSeconds") as? NSTimeInterval
            else { return nil }
        
        self.init(seconds: seconds)
    }
    
    func encodeWithCoder(aCoder: NSCoder)
    {
        aCoder.encodeObject(self.seconds, forKey: "leftSeconds")
    }
    
    var string: String {
        get {
            let totalSeconds = Int(self.seconds)
            
            //print("left \(totalSeconds)")
            
            let hours = totalSeconds / 3600
            let minutes = (totalSeconds - (hours * 3600)) / 60
            let seconds = totalSeconds - (hours * 3600) - (minutes * 60)
            
//            print("left \(hours)")
//            print("left \(minutes)")
//            print("left \(seconds)")
            
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
    
    func setTimer(seconds: NSTimeInterval) -> NSTimeInterval
    {
        self.seconds = seconds
        
        print("t \(self.seconds)")
        
        return self.seconds
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
        NSNotificationCenter.defaultCenter().postNotificationName(LeftTimer.notificationSecondTick, object: self)
        if seconds <= 0 {
            stopTimer()
            NSNotificationCenter.defaultCenter().postNotificationName(LeftTimer.notificationComplete, object: self)
        }
    }
}
