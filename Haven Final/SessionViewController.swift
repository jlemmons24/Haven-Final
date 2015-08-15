//
//  SessionViewController.swift
//  Haven Final
//
//  Created by Jordan Lemmons on 8/10/15.
//  Copyright (c) 2015 MakeSchool. All rights reserved.
//

import UIKit
import CoreLocation
import AVFoundation
//import Parse

class SessionViewController: UIViewController, CLLocationManagerDelegate {
    
    //Vars
    var inSession = false
    
    //Timer
    var timer  = NSTimer()
    
 
    //Gesture Segue
    let longPress = UILongPressGestureRecognizer()
    
    //Location static
    var startLocation = CLLocation()
   
    
    //Recording 
    let captureSession = AVCaptureSession()
    var captureDevice : AVCaptureDevice?
    var movieFileOutput : AVCaptureMovieFileOutput?
   // var fileUrl : NSURL =
    
    //Variable Struct
    
    struct sessionVars {
        
       static var counter : Int = 30000
       static var durationSnatch : String = " "
       static let finalTimeElapsed : String? = nil
       static var startLatitude : CLLocationDegrees? = -122.417974434907
       static var startLongitude : CLLocationDegrees? = 37.7735397918502
       static let manager = CLLocationManager()
       static let address : String? = nil
       static let locality : String? = nil
       static let zipcode : String? = nil
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLongGesture()
        adjustBrightness()
        configLocSettings()
        startTimer()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
   
    
    //Button Action
        
    
    func setupLongGesture() {
        longPress.addTarget(self, action: "toDataView")
        self.view.addGestureRecognizer(longPress)
        self.view.userInteractionEnabled = true
        longPress.minimumPressDuration = 4
        longPress.numberOfTouchesRequired = 1
    }

    
    
   /********Adjust Brightness**/
    
    func adjustBrightness() {
    
        
        UIScreen.mainScreen().brightness = CGFloat(0)
        
    }
    
    func toDataView() {
        self.endSession()
        self.performSegueWithIdentifier("toDataView", sender: self)
        
    }
    
  /********Timer functions****/
    func startTimer() {
        if (sessionVars.finalTimeElapsed == nil){
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "updateTime", userInfo: nil, repeats: true)
            println("****BOOO***")
            println("\(sessionVars.durationSnatch)")
        } else {
            timer.invalidate()
        }
    }
        
        
    
    func tapThat() {
        println("got the tap")
        }
    
    func updateTime() {
        
        if(sessionVars.finalTimeElapsed == nil){
            sessionVars.counter++
          println("\(sessionVars.counter)")
        }
        
        }
    
    func getDuration(){
        
        var hours = Int(sessionVars.counter / 3600)
        var mins = Int(sessionVars.counter / 60)
        var secs = sessionVars.counter % 60
        

        //Format seconds into hours, mins, and secs
        if (sessionVars.counter < 60){
            
           sessionVars.durationSnatch = String(sessionVars.counter)
            println("counter set)")
            
        } else if (sessionVars.counter >= 60 && sessionVars.counter != 0){
            
            if (hours == 0){
                sessionVars.durationSnatch = String(NSString(format: "%.2d:%.2d", mins, secs))
                // println(sessionVars.timeElapsed)
                
            }else if (sessionVars.counter >= 3600){
                mins = (Int(sessionVars.counter - (3600 * (Int(sessionVars.counter / 3600)))) / 60)
                sessionVars.durationSnatch = NSString(format: "%.2d:%.2d:%.2d", hours, mins, secs) as String
                // println(sessionVars.timeElapsed)
            }
        }
        
        
        sessionVars.finalTimeElapsed == "0"
        println("durationSnatch: \(sessionVars.durationSnatch), finalTimeElapsed: \(sessionVars.finalTimeElapsed), counter: \(sessionVars.counter)")

    }
    
    func endTimer( timer: NSTimer) {
        timer.invalidate()
       // counter = 0
        println("timer invalidated")
       
        
        
        }
    
   /************Location Functions*******///
    
  
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        CLGeocoder().reverseGeocodeLocation(manager.location, completionHandler: { (placemarks, error) ->
            
            Void in
            
            if error != nil {
                
                println("Error: " + error.localizedDescription)
                return
            }
            
            
            
           if placemarks.count > 0 {
                
                let pm = placemarks[0] as! CLPlacemark
                self.displayLocationInfo(pm)
            }
        })
        
        
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println("Error: " + error.localizedDescription)
    }
    
    func configLocSettings() {
        sessionVars.manager.delegate = self
        sessionVars.manager.desiredAccuracy = kCLLocationAccuracyBest
        sessionVars.manager.requestAlwaysAuthorization()
        sessionVars.manager.startUpdatingLocation()
    }
    
    
    func displayLocationInfo(placemark: CLPlacemark){
        sessionVars.startLatitude = (sessionVars.manager.location.coordinate.latitude)
        sessionVars.startLongitude = (sessionVars.manager.location.coordinate.longitude)
        
        //Save placemarks in variables for passing between Views
        let address2 = "\(placemark.subThoroughfare)" + " " + "\(placemark.thoroughfare)"
        let locality2 = "\(placemark.locality)" + " " + "\(placemark.subLocality)" + "\(placemark.administrativeArea)"
        let zipcode2 = "\(placemark.administrativeArea)"
        
        
        
        
        //Display Address, City, Zipcode data from placemark
        println("Longitude: \(sessionVars.startLongitude)")
        println("Latitude: \(sessionVars.startLatitude)")
        println(placemark.subThoroughfare + " " + placemark.thoroughfare)
//        //println(placemark.locality + " " + "(\(placemark.subLocality))")
//        println(placemark.postalCode)
//        println(placemark.administrativeArea)
//        
        
        sessionVars.manager.stopUpdatingLocation()
        

    }
    
    func setCoordinates(){
        sessionVars.startLatitude = sessionVars.manager.location.coordinate.latitude
        sessionVars.startLongitude = sessionVars.manager.location.coordinate.longitude

        println("\(sessionVars.startLatitude) , \(sessionVars.startLongitude)")
        
        }

    /*****Recording Functions****/
    
    func beginSession() {
        
        /*previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        self.view.layer.addSublayer(previewLayer)
        previewLayer?.frame = self.view.layer.frame*/
        inSession == true
       
        if (captureDevice != nil){
            
        self.captureSession.startRunning()
    }
    
    
    func configRecording(){
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), {
        self.captureSession.addOutput(self.movieFileOutput)  //Add Output
        self.captureSession.sessionPreset = AVCaptureSessionPresetHigh //Set session Preset
    
    //Add Input
        var err : NSError? = nil
        self.captureSession.addInput(AVCaptureDeviceInput(device: self.captureDevice, error: &err))
        
        if err != nil {
            println("error: \(err?.localizedDescription)")
            
        }
        
    //Set MovieFileOutput Video length
       self.movieFileOutput?.maxRecordedDuration = CMTimeMakeWithSeconds(25, 1)
       self.movieFileOutput?.maxRecordedFileSize = 10000000
        
    //Find a device
        
        let devices = AVCaptureDevice.devices()
        
        //Loop through all devices on phone
        for device in devices {
            
            //Does device support video?
            if (device.hasMediaType(AVMediaTypeVideo)){
                
                //Confirm that we've selected front camera
                if(device.position == AVCaptureDevicePosition.Front){
                    self.captureDevice = device as? AVCaptureDevice
                }
                
            }
            
        }
    })
      
    }
    }
    
    
    func endSession() {
        endTimer(timer)
        getDuration()
        self.captureSession.stopRunning()
        inSession == false
        println("\(sessionVars.finalTimeElapsed)")
        println("HEEEEMMMMMENDDDD")
        }
    
    
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


