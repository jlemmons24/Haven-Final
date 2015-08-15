//
//  DataViewController.swift
//  Haven Final
//
//  Created by Jordan Lemmons on 8/11/15.
//  Copyright (c) 2015 MakeSchool. All rights reserved.
//

import UIKit
import MapKit
//import Parse

class DataViewController: SessionViewController, MKMapViewDelegate, UITableViewDataSource {

//UI Outlets
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var videoTableView: UITableView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configMapView()
        readjustBrightness()
        println(sessionVars.finalTimeElapsed)
        displayData()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//Methods
  
  //Config
    func configMapView(){
        
        self.mapView.delegate = self
        let latitude = sessionVars.startLatitude!
        let longitude = sessionVars.startLongitude!
        let address : String = String(stringInterpolationSegment: sessionVars.address)
        let locality : String = String(stringInterpolationSegment: sessionVars.locality)
        let zipcode : String = String(stringInterpolationSegment: sessionVars.zipcode)
        let lookoutLoc = LookoutLocation(
            title: ("\(address) \n \(locality) \n \(zipcode)"),
            coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude),
            info: " ")
        mapView.addAnnotation(lookoutLoc)
    }
    
    func configTableView(){
        videoTableView.dataSource = self
    }

    
    func displayData() {
        
        let center : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: SessionViewController.sessionVars.manager.location.coordinate.latitude, longitude: SessionViewController.sessionVars.manager.location.coordinate.longitude)
        
       let region = MKCoordinateRegionMake(center, MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
       mapView.setRegion(region, animated: true)
        
       
         var labelTime = sessionVars.durationSnatch
        
        self.durationLabel.text = labelTime

    }
    
    func readjustBrightness() {
        
        UIScreen.mainScreen().brightness = CGFloat(0.5)
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }


}

extension DataViewController : UITableViewDataSource {
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("VideoCell", forIndexPath: indexPath) as! UITableViewCell
        
        let row = indexPath.row
        cell.textLabel?.text = "Hello World"
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
    
    }
    
}
