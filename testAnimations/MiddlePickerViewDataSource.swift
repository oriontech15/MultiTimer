//
//  MiddlePickerViewDataSource.swift
//  testAnimations
//
//  Created by Justin Smith on 11/10/15.
//  Copyright © 2015 Justin Smith. All rights reserved.
//

import Foundation
import UIKit

class MiddlePickerViewDataSource: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate
{
    let seconds = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15,
        16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30,
        31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45,
        46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59]
    
    let minutes = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15,
        16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30,
        31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45,
        46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59]
    
    let hours = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23]
    
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
            return NSAttributedString(string: String(hours[row]), attributes: [NSForegroundColorAttributeName:ColorPalette.pBlueColor()])
            
        case 1:
            return NSAttributedString(string: "H", attributes: [NSForegroundColorAttributeName:ColorPalette.pBlueColor()])
            
        case 2:
            return NSAttributedString(string: String(minutes[row]), attributes: [NSForegroundColorAttributeName:ColorPalette.pBlueColor()])
            
        case 3:
            return NSAttributedString(string: "M", attributes: [NSForegroundColorAttributeName:ColorPalette.pBlueColor()])
            
        case 4:
            return NSAttributedString(string: String(seconds[row]), attributes: [NSForegroundColorAttributeName:ColorPalette.pBlueColor()])
            
        case 5:
            return NSAttributedString(string: "S", attributes: [NSForegroundColorAttributeName:ColorPalette.pBlueColor()])
            
        default:
            return nil
        }
    }
}
