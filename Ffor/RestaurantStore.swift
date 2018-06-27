//
//  RestaurantStore.swift
//  Ffor
//
//  Created by Triveni Ashok Naik on 4/30/17.
//  Copyright © 2017 Triveni Ashok Naik. All rights reserved.
//

import Foundation
let zomatoKey = "49264a3f83cada47160a024d9de45b1b"
//let centerLatitude = 12.9716, centerLongitude = 77.5946


struct RestaurantStore{
    static var restaurants : [NSDictionary]!
    
    
    static func fetchrestaurants(centerLatitude: String, centerLongitude: String)
    {
        print(centerLatitude + centerLongitude)
        let urlString = "https://developers.zomato.com/api/v2.1/search?&lat=\(centerLatitude)&lon=\(centerLongitude)";
        let url = NSURL(string: urlString)
        
        if url != nil
        {
            let request = NSMutableURLRequest(URL: url!)
            request.HTTPMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.addValue(zomatoKey, forHTTPHeaderField: "user_key")
            
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: {(data, response, error) -> Void in
                if error == nil
                {
                    let httpResponse = response as! NSHTTPURLResponse!
                    
                    if httpResponse.statusCode == 200
                    {
                        do
                        {
                            if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                            {
                                if let restau = json["restaurants"] as? [NSDictionary]
                                {
                                    
                                    restaurants = restau
                                    for rest in restau{
                    
                                        let restaurant = rest["restaurant"] as! NSDictionary
                                        let name = restaurant["name"] as! String
                                        print(name);
                                    
                                    }
                                }
                            }
                            
                        } catch {
                            print("hello bhai: ")

                            print(error)
                        }
                    }
                }
            })
            
            task.resume()
        }
        
    }
}
