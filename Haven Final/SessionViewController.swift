//
//  SessionViewController.swift
//  Haven Final
//
//  Created by Jordan Lemmons on 8/10/15.
//  Copyright (c) 2015 MakeSchool. All rights reserved.
//

import UIKit

class SessionViewController: HomeViewController {

    let longPressRec = UILongPressGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        longPressRec.minimumPressDuration == 3

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
