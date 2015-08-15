//
//  ViewController.swift
//  Haven Final
//
//  Created by Jordan Lemmons on 8/10/15.
//  Copyright (c) 2015 MakeSchool. All rights reserved.
//

import UIKit
//import Parse

class HomeViewController: UIViewController {
   
    //Gesture Recognizers
    
    let doubleTapRec = UITapGestureRecognizer()
    
    //Buttons
    
    @IBOutlet weak var lookoutButton: UIButton!
    
    @IBOutlet weak var guardiansButton: UIButton!
    
    @IBOutlet weak var profileButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        doubleTapRec.numberOfTapsRequired == 2
        
     
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startLookout(sender: UITapGestureRecognizer) {
        
        
        

    }
    
    /* Not Yet!!

    @IBAction func gotoGuardians(sender: AnyObject) {
    }
   
    @IBAction func gotoProfile(sender: AnyObject) {
    }

    */
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
