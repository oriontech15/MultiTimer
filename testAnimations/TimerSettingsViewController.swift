//
//  TimerSettings.swift
//  testAnimations
//
//  Created by Justin Smith on 10/30/15.
//  Copyright © 2015 Justin Smith. All rights reserved.
//

import UIKit

class TimerSettingsViewController: UIViewController {

    @IBOutlet var leftPickerView: UIView!
    @IBOutlet var middlePickerView: UIView!
    @IBOutlet var rightPickerView: UIView!
    @IBOutlet weak var leftPicker: UIPickerView!
    @IBOutlet weak var rightPicker: UIPickerView!
    @IBOutlet weak var middlePicker: UIPickerView!
    @IBOutlet weak var leftTimerButton: UIButton!
    @IBOutlet weak var middleTimerButton: UIButton!
    @IBOutlet weak var rightTimerButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    
    var seconds: [Int] = []
    var minutes: [Int] = []
    var hours: [Int] = []
    
    var delegate: GetTimesDelegate?
    
    var leftTimerText = "Set Me"
    var middleTimerText = "Set Me"
    var rightTimerText = "Set Me"
    
    let leftTimer = LeftTimer()
    let middleTimer = MiddleTimer()
    let rightTimer = RightTimer()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        doneButton.layer.cornerRadius = 8
        
        leftTimerButton.setTitle(leftTimerText, forState: .Normal)
        middleTimerButton.setTitle(middleTimerText, forState: .Normal)
        rightTimerButton.setTitle(rightTimerText, forState: .Normal)
        
        seconds = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59]
        
        minutes = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59]
        
        hours = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23]
        
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }
    
    func passLeftTimeBackToMain(left: Int)
    {
        self.delegate?.sendLeftValue(left)
    }
    
    func passMiddleTimeBackToMain(middle: Int)
    {
        self.delegate?.sendMiddleValue(middle)
    }
    
    func passRightTimeBackToMain(right: Int)
    {
        self.delegate?.sendRightValue(right)
    }
    
    @IBAction func leftTimerButtonTapped()
    {
        self.view.bringSubviewToFront(leftPickerView)
        self.leftPickerView.backgroundColor = ColorPalette.pYellowColor()
        self.leftPickerView.layer.cornerRadius = 10
        self.leftPickerView.hidden = false
    }
    
    @IBAction func middleTimerButtonTapped()
    {
        self.view.bringSubviewToFront(middlePickerView)
        self.middlePickerView.backgroundColor = ColorPalette.pBlueColor()
        self.middlePickerView.layer.cornerRadius = 10
        self.middlePickerView.hidden = false
    }
    
    @IBAction func rightTimerButtonTapped()
    {
        self.view.bringSubviewToFront(rightPickerView)
        self.rightPickerView.backgroundColor = ColorPalette.pRedColor()
        self.rightPickerView.layer.cornerRadius = 10
        self.rightPickerView.hidden = false
    }
    
//    @IBAction override func unwindForSegue(unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController)
//    {
//        let mainView = unwindSegue.destinationViewController as! MainTimerViewController
//        
//        mainView.leftText = "\(getLeftTime())"
//    }
    
    @IBAction func doneButtonTapped(sender: AnyObject)
    {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func middleSetButtonTapped(sender: AnyObject)
    {
        let hours = middlePicker.selectedRowInComponent(0)
        
        var hoursString = ""
        if hours > 0
        {
            if hours < 10 {
                hoursString = "0\(hours):"
            } else {
                hoursString = "\(hours):"
            }
        }
        
        let minutes = middlePicker.selectedRowInComponent(2)
        
        var minutesString = ""
        if minutes < 10 {
            minutesString = "0\(minutes):"
        } else {
            minutesString = "\(minutes):"
        }
        
        let seconds = middlePicker.selectedRowInComponent(4)
        
        var secondsString = ""
        if seconds < 10 {
            secondsString = "0\(seconds)"
        } else {
            secondsString = "\(seconds)"
        }
        
        middleTimerButton.setTitle(hoursString + minutesString + secondsString, forState: .Normal)
        
        middleTimerButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        let middleTotalSeconds = ((middlePicker.selectedRowInComponent(0) * 3600) + (middlePicker.selectedRowInComponent(2) * 60) + (middlePicker.selectedRowInComponent(4)))
        
        //print("o \(middleTotalSeconds)")
        
        middleTimerText = hoursString + minutesString + secondsString
        passMiddleTimeBackToMain(middleTotalSeconds)
        
        middlePickerView.hidden = true
    }
    
    @IBAction func leftSetButtonTapped(sender: AnyObject)
    {
        let hours = leftPicker.selectedRowInComponent(0)
        
        var hoursString = ""
        if hours > 0
        {
            if hours < 10 {
                hoursString = "0\(hours):"
            } else {
                hoursString = "\(hours):"
            }
        }
        
        let minutes = leftPicker.selectedRowInComponent(2)
        
        var minutesString = ""
        if minutes < 10 {
            minutesString = "0\(minutes):"
        } else {
            minutesString = "\(minutes):"
        }
        
        let seconds = leftPicker.selectedRowInComponent(4)
        
        var secondsString = ""
        if seconds < 10 {
            secondsString = "0\(seconds)"
        } else {
            secondsString = "\(seconds)"
        }
        
        leftTimerButton.setTitle(hoursString + minutesString + secondsString, forState: .Normal)
        
        leftTimerButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        let leftTotalSeconds = ((leftPicker.selectedRowInComponent(0) * 3600) + (leftPicker.selectedRowInComponent(2) * 60) + (leftPicker.selectedRowInComponent(4)))
        
        //print("o \(leftTotalSeconds)")
        
        leftTimerText = hoursString + minutesString + secondsString
        passLeftTimeBackToMain(leftTotalSeconds)
        leftPickerView.hidden = true
    }
    
    @IBAction func rightSetButtonTapped(sender: AnyObject)
    {
        let hours = rightPicker.selectedRowInComponent(0)
        
        var hoursString = ""
        if hours > 0
        {
            if hours < 10 {
                hoursString = "0\(hours):"
            } else {
                hoursString = "\(hours):"
            }
        }
        
        let minutes = rightPicker.selectedRowInComponent(2)
        
        var minutesString = ""
        if minutes < 10 {
            minutesString = "0\(minutes):"
        } else {
            minutesString = "\(minutes):"
        }
        
        let seconds = rightPicker.selectedRowInComponent(4)
        
        var secondsString = ""
        if seconds < 10 {
            secondsString = "0\(seconds)"
        } else {
            secondsString = "\(seconds)"
        }
        
        rightTimerButton.setTitle(hoursString + minutesString + secondsString, forState: .Normal)
        
        rightTimerButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        let rightTotalSeconds = ((rightPicker.selectedRowInComponent(0) * 3600) + (rightPicker.selectedRowInComponent(2) * 60) + (rightPicker.selectedRowInComponent(4)))
        
        //print("o \(rightTotalSeconds)")
        
        rightTimerText = hoursString + minutesString + secondsString
        passRightTimeBackToMain(rightTotalSeconds)
        
        rightPickerView.hidden = true
    }
    
    func getLeftTime() -> NSTimeInterval
    {
        let hours = leftPicker.selectedRowInComponent(0)
        let minutes = leftPicker.selectedRowInComponent(2) + (hours * 60)
        let totalSecondsForLeftTimer = NSTimeInterval(minutes * 60)
        
        print(totalSecondsForLeftTimer)
        
        return totalSecondsForLeftTimer
    }
    
    func getMiddleTime() -> NSTimeInterval
    {
        let hours = middlePicker.selectedRowInComponent(0)
        let minutes = middlePicker.selectedRowInComponent(2) + (hours * 60)
        let totalSecondsForMiddleTimer = NSTimeInterval(minutes * 60)
        
        print(totalSecondsForMiddleTimer)
        
        return totalSecondsForMiddleTimer
    }
    
    func getRightTime() -> NSTimeInterval
    {
        let hours = rightPicker.selectedRowInComponent(0)
        let minutes = rightPicker.selectedRowInComponent(2) + (hours * 60)
        let totalSecondsForRightTimer = NSTimeInterval(minutes * 60)
        
        print(totalSecondsForRightTimer)
        
        return totalSecondsForRightTimer
    }
    
    
}

extension TimerSettingsViewController: UIPickerViewDataSource, UIPickerViewDelegate
{
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 6
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component
        {
        case 0:
            return 24
            
        case 1:
            return 1
            
        case 2:
            return 60
            
        case 3:
            return 1
            
        case 4:
            return 60
            
        case 5:
            return 1
            
        default:
            return 0
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        switch component
        {
        case 0:
            return String(hours[row])
            
        case 1:
            return "HR"
            
        case 2:
            return String(minutes[row])
            
        case 3:
            return "MIN"
            
        case 4:
            return String(seconds[row])
            
        case 5:
            return "SEC"
            
        default:
            return nil
        }
        
    }

    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString?
    {
        switch component
        {
        case 0:
            return NSAttributedString(string: String(hours[row]), attributes: [NSForegroundColorAttributeName:UIColor.darkGrayColor()])
            
        case 1:
            return NSAttributedString(string: "H", attributes: [NSForegroundColorAttributeName:UIColor.darkGrayColor()])
            
        case 2:
            return NSAttributedString(string: String(minutes[row]), attributes: [NSForegroundColorAttributeName:UIColor.darkGrayColor()])
            
        case 3:
            return NSAttributedString(string: "M", attributes: [NSForegroundColorAttributeName:UIColor.darkGrayColor()])
            
        case 4:
            return NSAttributedString(string: String(seconds[row]), attributes: [NSForegroundColorAttributeName:UIColor.darkGrayColor()])
            
        case 5:
            return NSAttributedString(string: "S", attributes: [NSForegroundColorAttributeName:UIColor.darkGrayColor()])
            
        default:
            return nil
        }
    }
}
