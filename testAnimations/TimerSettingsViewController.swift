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
    
    @IBOutlet weak var middleTitleTextField: UITextField!
    @IBOutlet weak var leftTitleTextField: UITextField!
    @IBOutlet weak var rightTitleTextField: UITextField!
    
    @IBOutlet weak var leftPicker: UIPickerView!
    @IBOutlet weak var rightPicker: UIPickerView!
    @IBOutlet weak var middlePicker: UIPickerView!
    
    @IBOutlet weak var leftTimerButton: UIButton!
    @IBOutlet weak var middleTimerButton: UIButton!
    @IBOutlet weak var rightTimerButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    
    @IBOutlet weak var leftMainTitleLabel: UILabel!
    @IBOutlet weak var middleMainTitleLabel: UILabel!
    @IBOutlet weak var rightMainTitleLabel: UILabel!
    
    @IBOutlet weak var leftTimerTitleLabel: UILabel!
    @IBOutlet weak var middleTimerTitleLabel: UILabel!
    @IBOutlet weak var rightTimerTitleLabel: UILabel!
    
    var blurredBackdropView: UIVisualEffectView!
    
    var delegate: GetTimesDelegate?
    
    var leftTimerText = "Set Me"
    var middleTimerText = "Set Me"
    var rightTimerText = "Set Me"
    
    var leftDefaultTitle = "Yellow Timer"
    var middleDefaultTitle = "Blue Timer"
    var rightDefaultTitle = "Red Timer"
    
    var leftTitle = ""
    var middleTitle = ""
    var rightTitle = ""
    
//    let leftTimer = LeftTimer()
//    let middleTimer = MiddleTimer()
//    let rightTimer = RightTimer()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        leftTimerTitleLabel.text = leftTitle
        middleTimerTitleLabel.text = middleTitle
        rightTimerTitleLabel.text = rightTitle
        
        leftMainTitleLabel.text = leftTitle
        middleMainTitleLabel.text = middleTitle
        rightMainTitleLabel.text = rightTitle
        
        doneButton.layer.cornerRadius = 8
        
        leftTimerButton.setTitle(leftTimerText, forState: .Normal)
        leftPicker.layer.borderWidth = 1
        leftPicker.layer.borderColor = ColorPalette.pYellowColor().CGColor
        middleTimerButton.setTitle(middleTimerText, forState: .Normal)
        middlePicker.layer.borderWidth = 1
        middlePicker.layer.borderColor = ColorPalette.pBlueColor().CGColor
        rightTimerButton.setTitle(rightTimerText, forState: .Normal)
        rightPicker.layer.borderWidth = 1
        rightPicker.layer.borderColor = ColorPalette.pRedColor().CGColor
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }
    
    func passLeftTimeBackToMain(left: Int, title: String? = "")
    {
        self.delegate?.sendLeftValue(left, title: title)
    }
    
    func passMiddleTimeBackToMain(middle: Int, title: String? = "")
    {
        self.delegate?.sendMiddleValue(middle, title: title)
    }
    
    func passRightTimeBackToMain(right: Int, title: String? = "")
    {
        self.delegate?.sendRightValue(right, title: title)
    }
    
    @IBAction func setDefaultsButtonTapped()
    {
        let leftHours = leftPicker.selectedRowInComponent(0)
        let leftMinutes = leftPicker.selectedRowInComponent(2) + (leftHours * 60)
        let totalSecondsForLeftTimer = NSTimeInterval(leftMinutes * 60)
        
        let middleHours = middlePicker.selectedRowInComponent(0)
        let middleMinutes = middlePicker.selectedRowInComponent(2) + (middleHours * 60)
        let totalSecondsForMiddleTimer = NSTimeInterval(middleMinutes * 60)
        
        let rightHours = rightPicker.selectedRowInComponent(0)
        let rightMinutes = rightPicker.selectedRowInComponent(2) + (rightHours * 60)
        let totalSecondsForRightTimer = NSTimeInterval(rightMinutes * 60)
        
        print("leftDefault \(totalSecondsForLeftTimer)")
        print("middleDefault \(totalSecondsForMiddleTimer)")
        print("rightDefault \(totalSecondsForRightTimer)")
    }
    
    @IBAction func leftTimerButtonTapped()
    {
        self.leftPickerView.backgroundColor = ColorPalette.clearColor()
        self.leftPickerView.hidden = false
        
        addBlurredBackgroundViewToView()
        self.view.bringSubviewToFront(leftPickerView)
    }
    
    @IBAction func middleTimerButtonTapped()
    {
        self.middlePickerView.backgroundColor = ColorPalette.clearColor()
        self.middlePickerView.hidden = false
        
        addBlurredBackgroundViewToView()
        self.view.bringSubviewToFront(middlePickerView)
    }
    
    @IBAction func rightTimerButtonTapped()
    {
        self.rightPickerView.backgroundColor = ColorPalette.clearColor()
        self.rightPickerView.hidden = false
        
        addBlurredBackgroundViewToView()
        self.view.bringSubviewToFront(rightPickerView)
    }
    
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
        
        if middleTitleTextField.text != ""
        {
            middleMainTitleLabel.text = middleTitleTextField.text
            middleTitle = middleTitleTextField.text!
        }
        else
        {
            middleTitle = middleDefaultTitle
            middleMainTitleLabel.text = "Blue Timer"
        }
        
        passMiddleTimeBackToMain(middleTotalSeconds, title: middleTitle)
        
        middlePickerView.hidden = true
        self.blurredBackdropView.removeFromSuperview()
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
        
        if leftTitleTextField.text != ""
        {
            leftMainTitleLabel.text = leftTitleTextField.text
            leftTitle = leftTitleTextField.text!
        }
        else
        {
            leftTitle = leftDefaultTitle
            leftMainTitleLabel.text = "Yellow Timer"
        }
        
        passLeftTimeBackToMain(leftTotalSeconds, title: leftTitle)
        leftPickerView.hidden = true
        
        self.blurredBackdropView.removeFromSuperview()
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
        
        if rightTitleTextField.text != ""
        {
            rightMainTitleLabel.text = rightTitleTextField.text
            rightTitle = rightTitleTextField.text!
        }
        else
        {
            rightTitle = rightDefaultTitle
            rightMainTitleLabel.text = "Red Timer"
        }
        
        passRightTimeBackToMain(rightTotalSeconds, title: rightTitle)
        
        rightPickerView.hidden = true
        
        self.blurredBackdropView.removeFromSuperview()
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
    
    
    func addBlurredBackgroundViewToView()
    {
        let blurEffect = UIBlurEffect(style: .Dark)
        let blurredBackdropView = UIVisualEffectView(effect: blurEffect)

        blurredBackdropView.autoresizingMask = [UIViewAutoresizing.FlexibleHeight, UIViewAutoresizing.FlexibleWidth]
        blurredBackdropView.frame = self.view.bounds
        self.view.addSubview(blurredBackdropView)
        self.blurredBackdropView = blurredBackdropView
    }
    
}

extension TimerSettingsViewController: UITextFieldDelegate
{
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        if leftTitleTextField.text != ""
        {
            leftTimerTitleLabel.text = leftTitleTextField.text
        }
        else
        {
            leftTimerTitleLabel.text = "Yellow Timer"
        }
        
        if middleTitleTextField.text != ""
        {
            middleTimerTitleLabel.text = middleTitleTextField.text
        }
        else
        {
            middleTimerTitleLabel.text = "Blue Timer"
        }
        
        if rightTitleTextField.text != ""
        {
            rightTimerTitleLabel.text = rightTitleTextField.text
        }
        else
        {
            rightTimerTitleLabel.text = "Red Timer"
        }
        
        textField.resignFirstResponder()
        return true
    }
}
