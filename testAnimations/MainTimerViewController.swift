//
//  ViewController.swift
//  testAnimations
//
//  Created by Justin Smith on 10/26/15.
//  Copyright © 2015 Justin Smith. All rights reserved.
//

import UIKit

class MainTimerViewController: UIViewController
{
    @IBOutlet weak var leftTimerLabel: UILabel!
    @IBOutlet weak var middleTimerLabel: UILabel!
    @IBOutlet weak var rightTimerLabel: UILabel!
    @IBOutlet weak var colorPaletteButton: UIButton!
    @IBOutlet weak var leftTimerView: UIView!
    @IBOutlet weak var middleTimerView: UIView!
    @IBOutlet weak var rightTimerView: UIView!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var middleButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var leftMinLabel: UILabel!
    @IBOutlet weak var rightMinLabel: UILabel!
    @IBOutlet weak var middleMinLabel: UILabel!
    @IBOutlet weak var clearAllButton: UIButton!
    @IBOutlet weak var centerView: UIView!
    
    var leftTimer = LeftTimer()
    var middleTimer = MiddleTimer()
    var rightTimer = RightTimer()
    
    static var leftView = UIView()
    static var middleView = UIView()
    static var rightView = UIView()
    
    var leftIsDone: Bool = true
    var middleIsDone: Bool = true
    var rightIsDone: Bool = true
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        MainTimerViewController.leftView = leftTimerView
        MainTimerViewController.middleView = middleTimerView
        MainTimerViewController.rightView = rightTimerView
        
        clearAllButton.backgroundColor = .lightGrayColor()
        clearAllButton.layer.borderColor = UIColor.lightGrayColor().CGColor
        clearAllButton.layer.borderWidth = 3
        clearAllButton.layer.cornerRadius = clearAllButton.bounds.height / 2
        
//LABEL: Notification Center Observers
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateTimerLabel", name: LeftTimer.notificationSecondTick, object: leftTimer)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "leftTimerComplete", name: LeftTimer.notificationComplete, object: leftTimer)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "complete", name: LeftTimer.notificationComplete, object: leftTimer)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateTimerLabel", name: MiddleTimer.notificationSecondTick, object: middleTimer)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "middleTimerComplete", name: MiddleTimer.notificationComplete, object: middleTimer)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "complete", name: MiddleTimer.notificationComplete, object: middleTimer)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateTimerLabel", name: RightTimer.notificationSecondTick, object: rightTimer)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "rightTimerComplete", name: RightTimer.notificationComplete, object: rightTimer)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "complete", name: RightTimer.notificationComplete, object: rightTimer)
        
    }
    
//LABEL: Button Actions
    @IBAction func fiveMinButtonTapped()
    {
        clearAllButton.backgroundColor = .clearColor()
        clearAllButton.enabled = true
        
        leftMinLabel.backgroundColor = .darkGrayColor()
        leftPopOutAnimation()
        
        LeftTimerController.sharedInstance.leftTimerProgressLine.removeFromSuperlayer()
        leftTimerLabel.hidden = false
//        leftMinLabel.hidden = false
        leftButton.enabled = false
        leftIsDone = false
        LeftTimerController.sharedInstance.startLeftTimer(10, radius: 150, color: ColorPalette.pYellowColor())
        toggleTimer(10, timerType:  "left")
    }
    
    @IBAction func tenMinButtonTapped()
    {
        clearAllButton.backgroundColor = .clearColor()
        clearAllButton.enabled = true
        
        middleMinLabel.backgroundColor = .darkGrayColor()
        middlePopOutAnimation()
        
        MiddleTimerController.sharedInstance.middleTimerProgressLine.removeFromSuperlayer()
        middleTimerLabel.hidden = false
//        middleMinLabel.hidden = false
        middleButton.enabled = false
        middleIsDone = false
        MiddleTimerController.sharedInstance.startMiddleTimer(20, radius: 125, color: ColorPalette.pBlueColor())
        toggleTimer(20, timerType: "middle")
    }
    
    @IBAction func twentyMinButtonTapped()
    {
        clearAllButton.backgroundColor = .clearColor()
        clearAllButton.enabled = true
        
        rightMinLabel.backgroundColor = .darkGrayColor()
        rightPopOutAnimation()
        
        RightTimerController.sharedInstance.rightTimerProgressLine.removeFromSuperlayer()
        rightTimerLabel.hidden = false
//        rightMinLabel.hidden = false
        rightButton.enabled = false
        rightIsDone = false
        RightTimerController.sharedInstance.startRightTimer(30, radius: 100, color: ColorPalette.pRedColor())
        toggleTimer(30, timerType: "right")
    }
    
    @IBAction func clearAllButtonTapped()
    {
        clearAllButton.backgroundColor = .clearColor()
        self.shrink(self.clearAllButton.center.x, y: self.clearAllButton.center.y)
        colorPaletteButton.backgroundColor = .lightGrayColor()
        colorPaletteButton.enabled = true
        
        leftTimerComplete()
        leftMinLabel.text = "00"
        leftMinLabel.backgroundColor = .clearColor()
        leftMinLabel.layer.borderColor = UIColor.clearColor().CGColor
        leftMinLabel.layer.borderWidth = 0
        leftMinLabel.layer.cornerRadius = leftMinLabel.bounds.height / 2
        leftTimer.stopTimer()
        LeftTimerController.sharedInstance.leftTimerProgressLine.removeFromSuperlayer()
        
        middleTimerComplete()
        middleMinLabel.text = "00"
        middleMinLabel.backgroundColor = .clearColor()
        middleMinLabel.layer.borderColor = UIColor.clearColor().CGColor
        middleMinLabel.layer.borderWidth = 0
        middleMinLabel.layer.cornerRadius = middleMinLabel.bounds.height / 2
        middleTimer.stopTimer()
        MiddleTimerController.sharedInstance.middleTimerProgressLine.removeFromSuperlayer()
        
        rightTimerComplete()
        rightMinLabel.text = "00"
        rightMinLabel.backgroundColor = .clearColor()
        rightMinLabel.layer.borderColor = UIColor.clearColor().CGColor
        rightMinLabel.layer.borderWidth = 0
        rightMinLabel.layer.cornerRadius = rightMinLabel.bounds.height / 2
        rightTimer.stopTimer()
        RightTimerController.sharedInstance.rightTimerProgressLine.removeFromSuperlayer()
        
        complete()
    }
    
    
    func leftPopOutAnimation()
    {
        leftMinLabel.hidden = false
        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.4, options: UIViewAnimationOptions.TransitionNone, animations: { () -> Void in
            
            self.leftMinLabel.center = CGPoint(x: self.clearAllButton.center.x - 40, y: self.clearAllButton.center.y - 40)
            
            }, completion: nil)
    }
    
    func middlePopOutAnimation()
    {
        middleMinLabel.hidden = false
        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.4, options: UIViewAnimationOptions.TransitionNone, animations: { () -> Void in
            
            self.middleMinLabel.center = CGPoint(x: self.clearAllButton.center.x, y: self.clearAllButton.center.y + 50)
            
            }, completion: nil)
    }
    
    func rightPopOutAnimation()
    {
        rightMinLabel.hidden = false
        
        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.4, options: UIViewAnimationOptions.TransitionNone, animations: { () -> Void in
            
            self.rightMinLabel.center = CGPoint(x: self.clearAllButton.center.x + 40, y: self.clearAllButton.center.y - 40)
            
            }, completion: nil)
    }
    
    func leftDismissAnimation(x: CGFloat, y: CGFloat)
    {
        UIView.animateWithDuration(1.0, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: UIViewAnimationOptions.TransitionNone, animations: { () -> Void in
            
            self.leftMinLabel.center = CGPoint(x: x + 40, y: y + 40)
            self.leftMinLabel.textColor = .lightGrayColor()
            self.clearAllButton.bounds = CGRectMake(x, y, self.clearAllButton.bounds.width + 38, self.clearAllButton.bounds.height + 38)
            self.clearAllButton.layer.cornerRadius = self.clearAllButton.bounds.height / 2
            
            }, completion: { _ in
                self.leftMinLabel.hidden = true
                self.shrink(self.clearAllButton.center.x, y: self.clearAllButton.center.y)})
    }
    
    func middleDismissAnimation(x: CGFloat, y: CGFloat)
    {
        UIView.animateWithDuration(1.0, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: UIViewAnimationOptions.TransitionNone, animations: { () -> Void in
            
            self.middleMinLabel.center = CGPoint(x: x, y: y - 50)
            self.middleMinLabel.textColor = .lightGrayColor()
            self.clearAllButton.bounds = CGRectMake(x, y, self.clearAllButton.bounds.width + 38, self.clearAllButton.bounds.height + 38)
            self.clearAllButton.layer.cornerRadius = self.clearAllButton.bounds.height / 2
            
            }, completion: { _ in
                self.middleMinLabel.hidden = true
                self.shrink(self.clearAllButton.center.x, y: self.clearAllButton.center.y)})
    }
    
    func rightDismissAnimation(x: CGFloat, y: CGFloat)
    {
        UIView.animateWithDuration(1.0, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: UIViewAnimationOptions.TransitionNone, animations: { () -> Void in
            
            self.rightMinLabel.center = CGPoint(x: x - 40, y: y + 40)
            self.rightMinLabel.textColor = .lightGrayColor()
            self.clearAllButton.bounds = CGRectMake(x, y, self.clearAllButton.bounds.width + 38, self.clearAllButton.bounds.height + 38)
            self.clearAllButton.layer.cornerRadius = self.clearAllButton.bounds.height / 2
            
            }, completion: { _ in
                self.rightMinLabel.hidden = true
                self.shrink(self.clearAllButton.center.x, y: self.clearAllButton.center.y)})
    }
    
    func shrink(x: CGFloat, y: CGFloat)
    {
        UIView.animateWithDuration(1.0, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: UIViewAnimationOptions.TransitionNone, animations: { () -> Void in
            
            self.clearAllButton.bounds = CGRectMake(x, y, self.clearAllButton.bounds.width - 38, self.clearAllButton.bounds.height - 38)
            self.clearAllButton.layer.cornerRadius = self.clearAllButton.bounds.height / 2
            
            }, completion: { _ in
                if self.clearAllButton.enabled == true
                {
                    self.clearAllButton.backgroundColor = .lightGrayColor()
                }
                else
                {
                    self.clearAllButton.backgroundColor = .clearColor()
                    self.clearAllButton.enabled = false
                }})
    }
    
    
    
//Timer Methods
    func toggleTimer(time: CFTimeInterval, timerType: String) {
        switch timerType
        {
            case "left":
                if leftTimer.isOn
                {
                    leftTimer.stopTimer()
                }
                else
                {
                    leftButton.backgroundColor = ColorPalette.pLightYellowColor()
                    leftButton.layer.borderColor = ColorPalette.pYellowColor().CGColor
                    leftButton.layer.borderWidth = 3
                    
                    leftMinLabel.backgroundColor = .clearColor()
                    leftMinLabel.layer.borderColor = ColorPalette.pYellowColor().CGColor
                    leftMinLabel.layer.borderWidth = 3
                    leftMinLabel.layer.cornerRadius = leftMinLabel.bounds.height / 2
                    
                    colorPaletteButton.enabled = false
                    colorPaletteButton.backgroundColor = .clearColor()
                    colorPaletteButton.layer.borderColor = UIColor.lightGrayColor().CGColor
                    colorPaletteButton.layer.borderWidth = 3
                    colorPaletteButton.setTitleColor(.lightGrayColor(), forState: .Disabled)
                    
                    leftTimer.setTimer(time)
                    leftTimer.startTimer()
                }
            break
            
            case "middle":
                if middleTimer.isOn
                {
                    middleTimer.stopTimer()
                }
                else
                {
                    middleButton.backgroundColor = ColorPalette.pLightBlueColor()
                    middleButton.layer.borderColor = ColorPalette.pBlueColor().CGColor
                    middleButton.layer.borderWidth = 3
                    
                    middleMinLabel.backgroundColor = .clearColor()
                    middleMinLabel.layer.borderColor = ColorPalette.pBlueColor().CGColor
                    middleMinLabel.layer.borderWidth = 3
                    middleMinLabel.layer.cornerRadius = middleMinLabel.bounds.height / 2
                    
                    colorPaletteButton.enabled = false
                    colorPaletteButton.backgroundColor = .clearColor()
                    colorPaletteButton.layer.borderColor = UIColor.lightGrayColor().CGColor
                    colorPaletteButton.layer.borderWidth = 3
                    colorPaletteButton.setTitleColor(.lightGrayColor(), forState: .Disabled)
                    
                    middleTimer.setTimer(time)
                    middleTimer.startTimer()
                }
            break
            
            case "right":
                if rightTimer.isOn
                {
                    rightTimer.stopTimer()
                }
                else
                {
                    rightButton.backgroundColor = ColorPalette.pLightRedColor()
                    rightButton.layer.borderColor = ColorPalette.pRedColor().CGColor
                    rightButton.layer.borderWidth = 3
                    
                    rightMinLabel.backgroundColor = .clearColor()
                    rightMinLabel.layer.borderColor = ColorPalette.pRedColor().CGColor
                    rightMinLabel.layer.borderWidth = 3
                    rightMinLabel.layer.cornerRadius = rightMinLabel.bounds.height / 2
                    
                    colorPaletteButton.enabled = false
                    colorPaletteButton.backgroundColor = .clearColor()
                    colorPaletteButton.layer.borderColor = UIColor.lightGrayColor().CGColor
                    colorPaletteButton.layer.borderWidth = 3
                    colorPaletteButton.setTitleColor(.lightGrayColor(), forState: .Disabled)
                    
                    rightTimer.setTimer(time)
                    rightTimer.startTimer()
                }
            break
            
        default:
            return
        }
    }
    
    func updateTimerLabel()
    {
        leftMinLabel.text = leftTimer.secondsLeft
        middleMinLabel.text = middleTimer.secondsLeft
        rightMinLabel.text = rightTimer.secondsLeft
        
        leftTimerLabel.text = leftTimer.string
        middleTimerLabel.text = middleTimer.string
        rightTimerLabel.text = rightTimer.string
    }
    
    func complete()
    {
        if leftIsDone == true && middleIsDone == true && rightIsDone == true
        {
            middleButton.backgroundColor = ColorPalette.pBlueColor()
            leftButton.backgroundColor = ColorPalette.pYellowColor()
            rightButton.backgroundColor = ColorPalette.pRedColor()
            
            colorPaletteButton.backgroundColor = .lightGrayColor()
            colorPaletteButton.enabled = true
        }
    }
    
    func leftTimerComplete()
    {
        leftButton.backgroundColor = ColorPalette.pYellowColor()
        leftDismissAnimation(leftMinLabel.center.x, y: leftMinLabel.center.y)
        leftTimerLabel.text = "Start"
        leftTimerLabel.hidden = true
//        leftMinLabel.hidden = true
        leftButton.enabled = true
        leftIsDone = true
    }
    
    func middleTimerComplete()
    {
        middleButton.backgroundColor = ColorPalette.pBlueColor()
        middleDismissAnimation(middleMinLabel.center.x, y: middleMinLabel.center.y)
        middleTimerLabel.text = "Start"
        middleTimerLabel.hidden = true
//        middleMinLabel.hidden = true
        middleButton.enabled = true
        middleIsDone = true
    }
    
    func rightTimerComplete()
    {
        rightButton.backgroundColor = ColorPalette.pRedColor()
        rightDismissAnimation(rightMinLabel.center.x, y: rightMinLabel.center.y)
        rightTimerLabel.text = "Start"
        rightTimerLabel.hidden = true
//        rightMinLabel.hidden = true
        rightButton.enabled = true
        rightIsDone = true
    }
    
}
