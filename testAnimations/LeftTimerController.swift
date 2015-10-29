//
//  LeftTimerViewController.swift
//  testAnimations
//
//  Created by Justin Smith on 10/28/15.
//  Copyright © 2015 Justin Smith. All rights reserved.
//

import UIKit

class LeftTimerController: NSObject
{
    static let sharedInstance = LeftTimerController()
    
    let leftTimerProgressLine = CAShapeLayer()
    
    func startLeftTimer(time: CFTimeInterval, radius: CGFloat, color: UIColor)
    {
        // set up some values to use in the curve
        let ovalStartAngle = CGFloat(90.01 * M_PI/180)
        let ovalEndAngle = CGFloat(90 * M_PI/180)
        let ovalRect = CGRectMake(MainTimerViewController.leftView.center.x - radius, MainTimerViewController.leftView.center.y - radius, radius * 2, radius * 2)
        
        // create the bezier path
        let ovalPath = UIBezierPath()
        
        ovalPath.addArcWithCenter(CGPointMake(CGRectGetMidX(ovalRect), CGRectGetMidY(ovalRect)),
            radius: CGRectGetWidth(ovalRect) / 2,
            startAngle: ovalStartAngle,
            endAngle: ovalEndAngle, clockwise: true)
        
        // create an object that represents how the curve
        // should be presented on the screen
        leftTimerProgressLine.path = ovalPath.CGPath
        leftTimerProgressLine.strokeColor = color.CGColor
        leftTimerProgressLine.fillColor = UIColor.clearColor().CGColor
        leftTimerProgressLine.lineWidth = 5.0
        leftTimerProgressLine.lineCap = kCALineCapRound
        
        let animateStrokeEnd = CABasicAnimation(keyPath: "strokeEnd")
        animateStrokeEnd.duration = time
        animateStrokeEnd.fromValue = 0.0
        animateStrokeEnd.toValue = time / time
        
        // add the curve to the screen
        MainTimerViewController.leftView.layer.addSublayer(leftTimerProgressLine)

        // add the animation
        leftTimerProgressLine.addAnimation(animateStrokeEnd, forKey: "animate stroke end animation")
        
        if animateStrokeEnd.duration == time / 2
        {
            leftTimerProgressLine.strokeColor = UIColor.redColor().CGColor
        }
    }
}
