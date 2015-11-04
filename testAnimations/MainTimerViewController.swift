//
//  ViewController.swift
//  testAnimations
//
//  Created by Justin Smith on 10/26/15.
//  Copyright © 2015 Justin Smith. All rights reserved.
//

import UIKit

protocol GetTimesDelegate
{
    func sendLeftValue(left: Int)
    func sendMiddleValue(middle: Int)
    func sendRightValue(right: Int)
}

class MainTimerViewController: UIViewController, GetTimesDelegate
{
    /**************************/
    /* PROPERTIES AND OUTLETS */
    /**************************/
    static let sharedInstance = MainTimerViewController()
    
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
    @IBOutlet weak var finishedLeftCircleView: UIView!
    @IBOutlet weak var finishedMiddleCircleView: UIView!
    @IBOutlet weak var finishedRightCircleView: UIView!
    
    var leftTimer = LeftTimer()
    var middleTimer = MiddleTimer()
    var rightTimer = RightTimer()
    
    static var leftView = UIView()
    static var middleView = UIView()
    static var rightView = UIView()
    
    let timerSettingsVC = TimerSettingsViewController()
    
    var leftTimerTotalSeconds = 300
    var middleTimerTotalSeconds = 600
    var rightTimerTotalSeconds = 1200
    
    var leftString = ""
    var middleString = ""
    var rightString = ""
    
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
        clearAllButton.enabled = false
        clearAllButton.layer.borderColor = UIColor.lightGrayColor().CGColor
        clearAllButton.layer.borderWidth = 3
        clearAllButton.layer.cornerRadius = clearAllButton.bounds.height / 2
        
        /********************/
        /*  N.C. OBSERVERS  */
        /********************/
        
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
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        
        print("leftTotal: \(leftTimerTotalSeconds)")
        print("middleTotal: \(middleTimerTotalSeconds)")
        print("rightTotal: \(rightTimerTotalSeconds)")
        
        let leftHours = leftTimerTotalSeconds / 3600
        let leftMinutes = (leftTimerTotalSeconds - (leftHours * 3600)) / 60
        let leftSeconds = (leftTimerTotalSeconds - (leftHours * 3600) - (leftMinutes * 60))
        
        var leftHoursString = ""
        if leftHours > 0 {
            leftHoursString = "\(leftHours):"
        }
        
        var leftMinutesString = ""
        if leftMinutes < 10 {
            leftMinutesString = "0\(leftMinutes):"
        } else {
            leftMinutesString = "\(leftMinutes):"
        }
        
        var leftSecondsString = ""
        if leftSeconds < 10 {
            leftSecondsString = "0\(leftSeconds)"
        } else {
            leftSecondsString = "\(leftSeconds)"
        }
        
        leftString = leftHoursString + leftMinutesString + leftSecondsString
        
//        print("leftHours: \(leftHours)")
//        print("leftMinutes: \(leftMinutes)")
//        print("leftSeconds: \(leftSeconds)")
//        print("leftString: \(leftString)")
        
        let middleHours = middleTimerTotalSeconds / 3600
        let middleMinutes = (middleTimerTotalSeconds - (middleHours * 3600)) / 60
        let middleSeconds = (middleTimerTotalSeconds - (middleHours * 3600) - (middleMinutes * 60))
        
        var middleHoursString = ""
        if middleHours > 0 {
            middleHoursString = "\(middleHours):"
        }
        
        var middleMinutesString = ""
        if middleMinutes < 10 {
            middleMinutesString = "0\(middleMinutes):"
        } else {
            middleMinutesString = "\(middleMinutes):"
        }
        
        var middleSecondsString = ""
        if middleSeconds < 10 {
            middleSecondsString = "0\(middleSeconds)"
        } else {
            middleSecondsString = "\(middleSeconds)"
        }
        
        middleString = middleHoursString + middleMinutesString + middleSecondsString
        
//        print("middleHours: \(middleHours)")
//        print("middleMinutes: \(middleMinutes)")
//        print("middleSeconds: \(middleSeconds)")
//        print("middleString: \(middleString)")
        
        let rightHours = rightTimerTotalSeconds / 3600
        let rightMinutes = (rightTimerTotalSeconds - (rightHours * 3600)) / 60
        let rightSeconds = (rightTimerTotalSeconds - (rightHours * 3600) - (rightMinutes * 60))
        
        var rightHoursString = ""
        if rightHours > 0 {
            rightHoursString = "\(rightHours):"
        }
        
        var rightMinutesString = ""
        if rightMinutes < 10 {
            rightMinutesString = "0\(rightMinutes):"
        } else {
            rightMinutesString = "\(rightMinutes):"
        }
        
        var rightSecondsString = ""
        if rightSeconds < 10 {
            rightSecondsString = "0\(rightSeconds)"
        } else {
            rightSecondsString = "\(rightSeconds)"
        }
        
        rightString = rightHoursString + rightMinutesString + rightSecondsString
        
//        print("rightHours: \(rightHours)")
//        print("rightMinutes: \(rightMinutes)")
//        print("rightSeconds: \(rightSeconds)")
//        print("rightString: \(rightString)")
        
        leftButton.titleLabel?.adjustsFontSizeToFitWidth = true
        leftButton.setTitle(leftString, forState: .Normal)
        
        middleButton.titleLabel?.adjustsFontSizeToFitWidth = true
        middleButton.setTitle(middleString, forState: .Normal)
        
        rightButton.titleLabel?.adjustsFontSizeToFitWidth = true
        rightButton.setTitle(rightString, forState: .Normal)
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }
    
    /*************************/
    /* BUTTON ACTION METHODS */
    /*************************/
    
    @IBAction func fiveMinButtonTapped()
    {
        clearAllButton.backgroundColor = .clearColor()
        clearAllButton.enabled = true
        
        leftMinLabel.hidden = false
        leftPopOutAnimation()
        
        LeftTimerController.sharedInstance.leftTimerProgressLine.removeFromSuperlayer()
        
        LeftTimerController.sharedInstance.leftTimerProgressLine.hidden = false
        leftTimerLabel.hidden = false
//        leftMinLabel.hidden = false
        leftButton.enabled = false
        leftIsDone = false
        print("\(leftTimerTotalSeconds)")
        LeftTimerController.sharedInstance.startLeftTimer(NSTimeInterval(self.leftTimerTotalSeconds), radius: 150, color: ColorPalette.pYellowColor())
        toggleTimer(NSTimeInterval(self.leftTimerTotalSeconds), timerType:  "left")
    }
    
    @IBAction func tenMinButtonTapped()
    {
        clearAllButton.backgroundColor = .clearColor()
        clearAllButton.enabled = true
        
        middleMinLabel.backgroundColor = .darkGrayColor()
        middlePopOutAnimation()
        
        MiddleTimerController.sharedInstance.middleTimerProgressLine.removeFromSuperlayer()
        MiddleTimerController.sharedInstance.middleTimerProgressLine.hidden = false
        middleTimerLabel.hidden = false
//        middleMinLabel.hidden = false
        middleButton.enabled = false
        middleIsDone = false
        MiddleTimerController.sharedInstance.startMiddleTimer(NSTimeInterval(self.middleTimerTotalSeconds), radius: 125, color: ColorPalette.pBlueColor())
        toggleTimer(NSTimeInterval(self.middleTimerTotalSeconds), timerType: "middle")
    }
    
    @IBAction func twentyMinButtonTapped()
    {
        clearAllButton.backgroundColor = .clearColor()
        clearAllButton.enabled = true
        
        rightMinLabel.backgroundColor = .darkGrayColor()
        rightPopOutAnimation()
        
        RightTimerController.sharedInstance.rightTimerProgressLine.removeFromSuperlayer()
        RightTimerController.sharedInstance.rightTimerProgressLine.hidden = false
        rightTimerLabel.hidden = false
//        rightMinLabel.hidden = false
        rightButton.enabled = false
        rightIsDone = false
        RightTimerController.sharedInstance.startRightTimer(NSTimeInterval(self.rightTimerTotalSeconds), radius: 100, color: ColorPalette.pRedColor())
        toggleTimer(NSTimeInterval(self.rightTimerTotalSeconds), timerType: "right")
    }
    
    @IBAction func clearAllButtonTapped()
    {
        clearAllButton.backgroundColor = .clearColor()
        self.shrink(self.clearAllButton.center.x, y: self.clearAllButton.center.y)
        colorPaletteButton.backgroundColor = .lightGrayColor()
        colorPaletteButton.enabled = true
        
        leftTimerComplete()
        leftMinLabel.text = "00"

        leftMinLabel.layer.borderColor = UIColor.clearColor().CGColor
        leftMinLabel.layer.borderWidth = 0
        leftMinLabel.layer.cornerRadius = leftMinLabel.bounds.height / 2
        leftTimer.stopTimer()
        LeftTimerController.sharedInstance.leftTimerProgressLine.removeFromSuperlayer()
        
        middleTimerComplete()
        middleMinLabel.text = "00"

        middleMinLabel.layer.borderColor = UIColor.clearColor().CGColor
        middleMinLabel.layer.borderWidth = 0
        middleMinLabel.layer.cornerRadius = middleMinLabel.bounds.height / 2
        middleTimer.stopTimer()
        MiddleTimerController.sharedInstance.middleTimerProgressLine.removeFromSuperlayer()
        
        rightTimerComplete()
        rightMinLabel.text = "00"

        rightMinLabel.layer.borderColor = UIColor.clearColor().CGColor
        rightMinLabel.layer.borderWidth = 0
        rightMinLabel.layer.cornerRadius = rightMinLabel.bounds.height / 2
        rightTimer.stopTimer()
        RightTimerController.sharedInstance.rightTimerProgressLine.removeFromSuperlayer()
        
        complete()
    }

    /*******************/
    /*  TIMER METHODS  */
    /*******************/
    
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let timerSettingsViewController = segue.destinationViewController as? TimerSettingsViewController
        {
            timerSettingsViewController.leftTimerText = leftString
            timerSettingsViewController.middleTimerText = middleString
            timerSettingsViewController.rightTimerText = rightString
            
            timerSettingsViewController.delegate = self
        }
    }
    
    func sendLeftValue(left: Int) {
        self.leftTimerTotalSeconds = left
        self.viewWillAppear(true)
    }
    
    func sendMiddleValue(middle: Int) {
        self.middleTimerTotalSeconds = middle
        self.viewWillAppear(true)
    }
    
    func sendRightValue(right: Int) {
        self.rightTimerTotalSeconds = right
        self.viewWillAppear(true)
    }
    
    /********************/
    /*  UPDATE METHODS  */
    /********************/
    
    func updateTimerLabel()
    {
        leftMinLabel.text = leftTimer.secondsLeft
        middleMinLabel.text = middleTimer.secondsLeft
        rightMinLabel.text = rightTimer.secondsLeft
        
        leftTimerLabel.text = leftTimer.string
        middleTimerLabel.text = middleTimer.string
        rightTimerLabel.text = rightTimer.string
    }
    
    /********************/
    /* COMPLETE METHODS */
    /********************/
    
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
        
//        finishedLeftCircleView.hidden = false
//        finishedLeftCircleView.backgroundColor = .clearColor()
//        finishedLeftCircleView.layer.cornerRadius = finishedLeftCircleView.bounds.height / 2
//        finishedLeftCircleView.layer.borderColor = ColorPalette.pYellowColor().CGColor
//        finishedLeftCircleView.layer.borderWidth = 5
        
        //LeftTimerController.sharedInstance.leftTimerProgressLine.removeFromSuperlayer()
        
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
    
    /*******************/
    /*    ANIMATIONS   */
    /*******************/
    
    func leftPopOutAnimation()
    {
        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.4, options: UIViewAnimationOptions.TransitionNone, animations: { () -> Void in

            self.leftMinLabel.center = CGPoint(x: self.clearAllButton.center.x - 40, y: self.clearAllButton.center.y - 35)
            
            }, completion: nil)
    }
    
    func middlePopOutAnimation()
    {
        middleMinLabel.hidden = false
        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.4, options: UIViewAnimationOptions.TransitionNone, animations: { () -> Void in
            
            self.middleMinLabel.center = CGPoint(x: self.clearAllButton.center.x, y: self.clearAllButton.center.y + 55)
            
            }, completion: nil)
    }
    
    func rightPopOutAnimation()
    {
        rightMinLabel.hidden = false
        
        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.4, options: UIViewAnimationOptions.TransitionNone, animations: { () -> Void in
            
            self.rightMinLabel.center = CGPoint(x: self.clearAllButton.center.x + 40, y: self.clearAllButton.center.y - 35)
            
            }, completion: nil)
    }
    
    func leftDismissAnimation(x: CGFloat, y: CGFloat)
    {
        UIView.animateWithDuration(1.0, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: UIViewAnimationOptions.TransitionNone, animations: { () -> Void in
            
            self.leftMinLabel.center = CGPoint(x: x + 40, y: y + 35)
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
            
            self.middleMinLabel.center = CGPoint(x: x, y: y - 55)
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
            
            self.rightMinLabel.center = CGPoint(x: x - 40, y: y + 35)
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
                    self.clearAllButton.backgroundColor = .clearColor()
                    
                    if self.leftIsDone == true && self.middleIsDone == true && self.rightIsDone == true
                    {
                        self.shrinkProgressLines()
                        self.clearAllButton.backgroundColor = .lightGrayColor()
                        self.clearAllButton.enabled = false
                    }
                }})
    }
    
    func shrinkProgressLines()
    {
        UIView.animateWithDuration(1, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: UIViewAnimationOptions.TransitionNone, animations: { () -> Void in
            
            let leftStrokeEnd = CABasicAnimation(keyPath: "strokeEnd")
            leftStrokeEnd.duration = 1
            leftStrokeEnd.fromValue = 1.0
            leftStrokeEnd.toValue = 0.0
            
            LeftTimerController.sharedInstance.leftTimerProgressLine.addAnimation(leftStrokeEnd, forKey: "leftReverse")
            
            let middleStrokeEnd = CABasicAnimation(keyPath: "strokeEnd")
            middleStrokeEnd.duration = 1
            middleStrokeEnd.fromValue = 1.0
            middleStrokeEnd.toValue = 0.0
            
            MiddleTimerController.sharedInstance.middleTimerProgressLine.addAnimation(middleStrokeEnd, forKey: "middleReverse")
            
            let rightStrokeEnd = CABasicAnimation(keyPath: "strokeEnd")
            rightStrokeEnd.duration = 1
            rightStrokeEnd.fromValue = 1.0
            rightStrokeEnd.toValue = 0.0
            
            RightTimerController.sharedInstance.rightTimerProgressLine.addAnimation(rightStrokeEnd, forKey: "rightReverse")
            
            self.clearAllButton.backgroundColor = .clearColor()
            
            }, completion: { _ in
                
                sleep(1)
                LeftTimerController.sharedInstance.leftTimerProgressLine.hidden = true
                MiddleTimerController.sharedInstance.middleTimerProgressLine.hidden = true
                RightTimerController.sharedInstance.rightTimerProgressLine.hidden = true})
    }

    //func o()
//    {
//        var favoriteFillGrow = CATransform3DIdentity
//        favoriteFillGrow = CATransform3DScale(favoriteFillGrow, 0.0, -0.0, -0.01)
//        
//        // 5. Fill Circle grows until reach the size of step 2 and shrink back to the initial size.
//        let fillCircleAnimation = CAKeyframeAnimation(keyPath: "transform")
//        
//        let fillRingShape = LeftTimerController.sharedInstance.leftTimerProgressLine
//        
//        fillCircleAnimation.values = [
//            NSValue(CATransform3D:fillRingShape.transform),
//            NSValue(CATransform3D:favoriteFillGrow),
//            NSValue(CATransform3D:CATransform3DIdentity)
//        ]
//        fillCircleAnimation.keyTimes = [0.0,0.4,0.6]
//        fillCircleAnimation.duration = 3.0
//        fillCircleAnimation.beginTime = CACurrentMediaTime() + 0.22
//        fillCircleAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
//
//        
//        fillRingShape.addAnimation(fillCircleAnimation, forKey: "fill circle Animation")
//        fillRingShape.transform = CATransform3DIdentity
//    }
    
}



