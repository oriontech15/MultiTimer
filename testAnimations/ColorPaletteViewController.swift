//
//  colorPaletteViewController.swift
//  testAnimations
//
//  Created by Justin Smith on 10/27/15.
//  Copyright © 2015 Justin Smith. All rights reserved.
//

import UIKit

class ColorPaletteViewController: UIViewController {

    @IBOutlet weak var purpleColorButton: UIButton!
    @IBOutlet weak var redColorButton: UIButton!
    @IBOutlet weak var orangeColorButton: UIButton!
    @IBOutlet weak var yellowColorButton: UIButton!
    @IBOutlet weak var blueColorButton: UIButton!
    @IBOutlet weak var greenColorButton: UIButton!
    @IBOutlet weak var pinkButtonColor: UIButton!
    @IBOutlet weak var whiteColorButton: UIButton!
    @IBOutlet weak var grayView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        purpleColorButton.layer.cornerRadius = purpleColorButton.bounds.height / 2
        redColorButton.layer.cornerRadius = redColorButton.bounds.height / 2
        orangeColorButton.layer.cornerRadius = orangeColorButton.bounds.height / 2
        yellowColorButton.layer.cornerRadius = yellowColorButton.bounds.height / 2
        blueColorButton.layer.cornerRadius = blueColorButton.bounds.height / 2
        greenColorButton.layer.cornerRadius = greenColorButton.bounds.height / 2
        pinkButtonColor.layer.cornerRadius = pinkButtonColor.bounds.height / 2
        whiteColorButton.layer.cornerRadius = whiteColorButton.bounds.height / 2
        grayView.layer.cornerRadius = grayView.bounds.height / 2
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doneButtonTapped(sender: UIButton)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
