//
//  RightTimerViewController.swift
//  testAnimations
//
//  Created by Justin Smith on 10/28/15.
//  Copyright © 2015 Justin Smith. All rights reserved.
//

import UIKit

class RightTimerController: NSObject
{
    static let sharedInstance = RightTimerController()
    
    let rightTimerProgressLine = CAShapeLayer()
    
    func startRightTimer(time: CFTimeInterval, radius: CGFloat, color: UIColor)
    {
        // set up some values to use in the curve
        let ovalStartAngle = CGFloat(90.01 * M_PI/180)
        let ovalEndAngle = CGFloat(90 * M_PI/180)
        let ovalRect = CGRectMake(MainTimerViewController.rightView.center.x - radius, MainTimerViewController.rightView.center.y - radius, radius * 2, radius * 2)
        
        // create the bezier path
        let ovalPath = UIBezierPath()
        
        ovalPath.addArcWithCenter(CGPointMake(CGRectGetMidX(ovalRect), CGRectGetMidY(ovalRect)),
            radius: CGRectGetWidth(ovalRect) / 2,
            startAngle: ovalStartAngle,
            endAngle: ovalEndAngle, clockwise: true)
        
        // create an object that represents how the curve
        // should be presented on the screen
        rightTimerProgressLine.path = ovalPath.CGPath
        rightTimerProgressLine.strokeColor = color.CGColor
        rightTimerProgressLine.fillColor = UIColor.clearColor().CGColor
        rightTimerProgressLine.lineWidth = 5.0
        rightTimerProgressLine.lineCap = kCALineCapRound
        
        let animateStrokeEnd = CABasicAnimation(keyPath: "strokeEnd")
        animateStrokeEnd.duration = time
        animateStrokeEnd.fromValue = 0.0
        animateStrokeEnd.toValue = 1.0
        animateStrokeEnd.removedOnCompletion = true
        
        // add the curve to the screen
        MainTimerViewController.rightView.layer.addSublayer(rightTimerProgressLine)
        // add the animation
        rightTimerProgressLine.addAnimation(animateStrokeEnd, forKey: "animate stroke end animation")
        
        if animateStrokeEnd.duration == time / 2
        {
            rightTimerProgressLine.strokeColor = UIColor.redColor().CGColor
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }
}
