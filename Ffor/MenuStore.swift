//
//  MenuStore.swift
//  TestProj
//
//  Created by Triveni Ashok Naik on 4/25/17.
//  Copyright © 2017 Nishant Agrawal. All rights reserved.
//

//
//  RestaurantStore.swift
//  TestProj
//
//  Created by Nishant Agrawal on 4/24/17.
//  Copyright © 2017 Nishant Agrawal. All rights reserved.
//

import Foundation



//struct MenuStore{
//    static var stat_dishes : [NSDictionary]!
//    static var stat_rest_selected: NSDictionary!
//
//
//    static func fetchMenu()
//    {
//        let restaurant = stat_rest_selected["restaurant"] as! NSDictionary
//
//        let id = restaurant["id"] as! String
//
//        print("in fetch menu")
//        print(id)
//
//        let urlStringMenu = "https://developers.zomato.com/api/v2.1/dailymenu?res_id=\(id)";
//        let urlMenu = NSURL(string: urlStringMenu)
//
//        if urlMenu != nil
//        {
//            let request = NSMutableURLRequest(URL: url!)
//            request.HTTPMethod = "GET"
//            request.addValue("application/json", forHTTPHeaderField: "Accept")
//            request.addValue(zomatoKey, forHTTPHeaderField: "user_key")
//
//            let task = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: {(data, response, error) -> Void in
//                if error == nil
//                {
//                    let httpResponse = response as! NSHTTPURLResponse!
//
//                    if httpResponse.statusCode == 200
//                    {
//                        do
//                        {
//                            if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
//                            {
//                                if let menu = json["daily_menu"] as? NSDictionary
//                                {
//
//                                    let dishes = menu["dishes"] as? [NSDictionary]
//                                    stat_dishes = dishes
//
//                                    for dish in dishes!{
//                                        print(dish)
//                                        //let restaurant = rest["restaurant"] as! NSDictionary
//                                        //let name = restaurant["name"] as! String
//                                        // let address = restaurant["address"] as! String
//                                        // let phonenumber = restaurant["phone_numbers"] as! Int
//                                        //print(name);
//                                        //print(address);
//                                        //print(phonenumber);
//                                    }
//                                }
//                            }
//
//                        } catch {
//                            print(error)
//                        }
//                    }
//                }
//            })
//
//            task.resume()
//        }
//
//    }
//}



/////////////////
////////////////

class MenuStore {
    var stat_dishes = [Dish]()
    
    static var order_dishes = [Dish]()
    
    init() {
        let randomValue = Int(arc4random_uniform(11)+10)
        
        for _ in 0..<randomValue {
            createItem()
        }
    }
    
    //creates an item, inserts it in the array, and returns the created item
    func createItem() -> Dish {
        let dish = Dish(random: true)
        
        stat_dishes.append(dish)
        //allItems.insert(item, atIndex: 0)
        
        return dish
    }
    
    //function to print all items in the array
    func printAllItems() {
        for dish in stat_dishes {
            print("Name: \(dish.name) Value: \(dish.valueInDollars)")
        }
    }
    
    //removes a specified item from the array
    static func removeItem(dish: Dish) {
        if let index = order_dishes.indexOf(dish) {
            order_dishes.removeAtIndex(index)
        }
    }
}
