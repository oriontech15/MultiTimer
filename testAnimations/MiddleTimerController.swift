//
//  MiddleTimerViewController.swift
//  testAnimations
//
//  Created by Justin Smith on 10/28/15.
//  Copyright © 2015 Justin Smith. All rights reserved.
//

import UIKit

class MiddleTimerController: NSObject
{
    static let sharedInstance = MiddleTimerController()
    
    let middleTimerProgressLine = CAShapeLayer()

    func startMiddleTimer(time: CFTimeInterval, radius: CGFloat, color: UIColor)
    {
        // set up some values to use in the curve
        let ovalStartAngle = CGFloat(90.01 * M_PI/180)
        let ovalEndAngle = CGFloat(90 * M_PI/180)
        let ovalRect = CGRectMake(MainTimerViewController.middleView.center.x - radius, MainTimerViewController.middleView.center.y - radius, radius * 2, radius * 2)
        
        // create the bezier path
        let ovalPath = UIBezierPath()
        
        ovalPath.addArcWithCenter(CGPointMake(CGRectGetMidX(ovalRect), CGRectGetMidY(ovalRect)),
            radius: CGRectGetWidth(ovalRect) / 2,
            startAngle: ovalStartAngle,
            endAngle: ovalEndAngle, clockwise: true)
        
        // create an object that represents how the curve
        // should be presented on the screen
        middleTimerProgressLine.path = ovalPath.CGPath
        middleTimerProgressLine.strokeColor = color.CGColor
        middleTimerProgressLine.fillColor = UIColor.clearColor().CGColor
        middleTimerProgressLine.lineWidth = 5.0
        middleTimerProgressLine.lineCap = kCALineCapRound
        
        let animateStrokeEnd = CABasicAnimation(keyPath: "strokeEnd")
        animateStrokeEnd.duration = time
        animateStrokeEnd.fromValue = 0.0
        animateStrokeEnd.toValue = 1.0
        
        // add the curve to the screen
        MainTimerViewController.middleView.layer.addSublayer(middleTimerProgressLine)
        // add the animation
        middleTimerProgressLine.addAnimation(animateStrokeEnd, forKey: "animate stroke end animation")
        
        if animateStrokeEnd.duration == time / 2
        {
            middleTimerProgressLine.strokeColor = UIColor.redColor().CGColor
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
}
