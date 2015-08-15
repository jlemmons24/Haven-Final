//
//  LookoutLocation.swift
//  Haven Final
//
//  Created by Jordan Lemmons on 8/14/15.
//  Copyright (c) 2015 MakeSchool. All rights reserved.
//

import MapKit
import UIKit

class LookoutLocation: NSObject, MKAnnotation {
    var title : String
    var coordinate : CLLocationCoordinate2D
    var info : String? = nil
   
    
    
    init(title : String, coordinate : CLLocationCoordinate2D, info : String){
        self.title = title
        self.coordinate = coordinate
        self.info = info
        
    }

}
