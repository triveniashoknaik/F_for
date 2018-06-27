//
//  AddressViewController.swift
//  Ffor
//
//  Created by Triveni Ashok Naik on 4/29/17.
//  Copyright © 2017 Triveni Ashok Naik. All rights reserved.
//

import UIKit
import CoreLocation

class AddressViewController: UIViewController, CLLocationManagerDelegate {
    
    var wifi: Int = 0
    
    
    let locationManager = CLLocationManager();
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var userAddress: UITextField!
    
    
    @IBAction func dismissKeyboard(sender: AnyObject) {
        userAddress.resignFirstResponder()
    
    }
    
    @IBAction func Logoutbutton(sender: AnyObject) {
        
        NSUserDefaults.standardUserDefaults().setBool(false, forKey: "isUserLoggedIn");
        //NSUserDefaults.standardUserDefaults().setObject(false, forKey: "isUserLoggedIn");
        self.performSegueWithIdentifier("AddressLogout", sender: self);
    }
    
    @IBAction func Searchbutton(sender: AnyObject) {
        
        activityIndicator.startAnimating()
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
      
        
        self.readAddress()
        
        
        print("entered the shit::::")
        print(self.wifi)
        let seconds = 2.0
        let delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
        let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        
        dispatch_after(dispatchTime, dispatch_get_main_queue(), {
        
            print(self.wifi)
            //if wifi is there
        if self.wifi == 0{
            
            let lat = NSUserDefaults.standardUserDefaults().stringForKey("uLat");
            let long = NSUserDefaults.standardUserDefaults().stringForKey("uLong");
            RestaurantStore.fetchrestaurants(lat!, centerLongitude: long!)
                
            let seconds2 = 4.0
            let delay2 = seconds2 * Double(NSEC_PER_SEC)  // nanoseconds per seconds
            let dispatchTime2 = dispatch_time(DISPATCH_TIME_NOW, Int64(delay2))
            
            dispatch_after(dispatchTime2, dispatch_get_main_queue(), {
                if RestaurantStore.restaurants.isEmpty == false {
                    self.performSegueWithIdentifier("AddToResList", sender: self);
                }else{
                    self.displayErr("Please enter a specific valid address for getting NEARBY restaurants")
                }
                
                
            })
        }
    })
        let seconds3 = 6.0
        let delay3 = seconds3 * Double(NSEC_PER_SEC)  // nanoseconds per seconds
        let dispatchTime3 = dispatch_time(DISPATCH_TIME_NOW, Int64(delay3))
        
        dispatch_after(dispatchTime3, dispatch_get_main_queue(), {
            
            self.activityIndicator.stopAnimating()
            UIApplication.sharedApplication().endIgnoringInteractionEvents()
            
        })
        

//        if RestaurantStore.restaurants != nil {
//            RestaurantStore.restaurants.removeAll()
//        }
//            
//        if RestaurantStore.restaurants.isEmpty {
//            
//            
//            
//        
//        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "a3.png")!)
        
        print("hello")
        self.locationManager.requestAlwaysAuthorization();
        self.locationManager.requestWhenInUseAuthorization();
        
        if CLLocationManager.locationServicesEnabled() {
            print("hello2")
            locationManager.delegate = self;
            locationManager.desiredAccuracy = kCLLocationAccuracyBest;
            
            locationManager.startUpdatingLocation();
        }
        
        if let userAddress = NSUserDefaults.standardUserDefaults().stringForKey("uAddress"){
            print("hello3")
            self.userAddress.text = userAddress
        
        }
        
        let backButton = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
     
    }
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        
//        let userLocation:CLLocation = locations[0]
//        
//        let long = userLocation.coordinate.longitude;
//        let lat = userLocation.coordinate.latitude;
//        print("locations = \(long) \(lat)")
        //RestaurantStore.fetchrestaurants(locValue.latitude, locValue.longitude)
        
        
//        CLGeocoder().reverseGeocodeLocation(userLocation){(placemark, error) in
//            if error != nil{
//                print("there was an error");
//                self.locationManager.stopUpdatingLocation()
//            }
//            else{
//                if placemark.count > 0{
//                    if let checker = place.subThoroughfare{
//                        let userAddress = "\(place.subThoroughfare) \(place.thoroughfare) \(place.country)"
//                        //self.userAddress.text = "\(place.subThoroughfare) \(place.thoroughfare) \(place.country)"
//                         NSUserDefaults.standardUserDefaults().setObject(userAddress, forKey: "uAddress");
//                    }
//                }
//            }
//        }
        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: {(placemarks, error) ->
            Void in
            
            if error != nil{
                print("error: ")
                return
            }
            
            if placemarks!.count > 0{
                let pm = placemarks![0] 
                self.displayLocationInfo(pm)
            }
        
        })
    }
    
        func displayLocationInfo(placemark: CLPlacemark) {
            self.locationManager.stopUpdatingLocation()
            print(placemark.locality)
            
        }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("error: " + error.localizedDescription)
    }
    
    func readAddress() {
 
        if let address = userAddress.text{
            NSUserDefaults.standardUserDefaults().setObject(address, forKey: "uAddress");
            let geocoder = CLGeocoder()
            geocoder.geocodeAddressString(address, completionHandler: {(placemarks, error) -> Void in
                
                if((error) != nil){
                    
                    self.wifi = 1
                    print("Error: ", error?.localizedDescription)
                    
                    self.activityIndicator.stopAnimating()
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    
                    self.displayErrorForWifi("Please enter a valid address and check your internet connectivity!")
                    //The first check of webservice will be done well before this when fetching the location
                }
                if let placemark = placemarks?.first {
                    let coordinates:CLLocationCoordinate2D = placemark.location!.coordinate
                    let lat = String(coordinates.latitude)
                    let long = String(coordinates.longitude)
                    NSUserDefaults.standardUserDefaults().setObject(lat, forKey: "uLat");
                    NSUserDefaults.standardUserDefaults().setObject(long, forKey: "uLong");
                    print(lat)
                    print(long)
                    
                }
            })
        }
    }
    
    func displayErrorForWifi(errorMessage:String){
        let errAlert = UIAlertController(title:"Alert", message: errorMessage, preferredStyle: UIAlertControllerStyle.Alert);
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default){
            action in
            
            NSUserDefaults.standardUserDefaults().setBool(false, forKey: "isUserLoggedIn");
            //self.performSegueWithIdentifier("AddressLogout", sender: self);
        }
        
        errAlert.addAction(okAction);
        
        self.presentViewController(errAlert, animated: true, completion: nil);
    }
    
    func displayErr(errorMessage:String){
        let errAlert = UIAlertController(title:"Alert", message: errorMessage, preferredStyle: UIAlertControllerStyle.Alert);
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        
        errAlert.addAction(okAction);
        
        self.presentViewController(errAlert, animated: true, completion: nil);
    }
    
}


