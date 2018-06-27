//
//  MapViewController.swift
//  Ffor
//
//  Created by Triveni Ashok Naik on 5/1/17.
//  Copyright © 2017 Triveni Ashok Naik. All rights reserved.
//

//
//  MapViewController.swift
//  Ffor
//
//  Created by Triveni Ashok Naik on 4/30/17.
//  Copyright © 2017 Triveni Ashok Naik. All rights reserved.
//

//
//  MapViewController.swift
//  TestProj
//
//  Created by Triveni Ashok Naik on 4/25/17.
//  Copyright © 2017 Nishant Agrawal. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController
{
    var item: NSDictionary!
    var restaurant: NSDictionary!
    
    
    @IBOutlet weak var mapview: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // set initial location in Honolulu
        // let initialLocation = CLLocation(latitude: 43.037897, longitude: -76.130569)
        
        let lat = NSUserDefaults.standardUserDefaults().stringForKey("uLat");
        let long = NSUserDefaults.standardUserDefaults().stringForKey("uLong");
        
        /////added
//        let centerLocation = CLLocationCoordinate2D(latitude: Double(lat!)!, longitude: Double(long!)!)
//        
//        let region = MKCoordinateRegion(center: centerLocation, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
//        self.mapview.setRegion(region, animated: true)
//        
//        self.mapview.showsUserLocation = true
        //added
        
        let initialLocation = CLLocation(latitude: Double(lat!)!, longitude: Double(long!)!)
        centerMapOnLocation(initialLocation)
        
        let restau = RestaurantStore.restaurants
        
        for rest in restau{
            
            let restaurant = rest["restaurant"] as! NSDictionary
            let name = restaurant["name"] as! String
            let location = restaurant["location"] as? NSDictionary
            let address = location!["address"] as! String
            let latitude = location!["latitude"] as! String
            let longitude = location!["longitude"] as! String
            let latdouble = Double(latitude)
            let longdouble = Double(longitude)
            
            let coordinate = CLLocationCoordinate2D(latitude: latdouble!, longitude: longdouble!)
            
            let artwork = Artwork(title: name,
                                  locationName: address,
                                  discipline: "Restaurant",
                                  coordinate: coordinate)
            mapview.addAnnotation(artwork)
            
            print(name);
            
        }
        mapview.delegate = self
        
    }
    
    
    let regionRadius: CLLocationDistance = 150
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        mapview.setRegion(coordinateRegion, animated: true)
        
    }
}

