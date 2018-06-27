
//
//  DetailsViewController.swift
//  TestProj
//
//  Created by Triveni Ashok Naik on 4/25/17.
//  Copyright © 2017 Nishant Agrawal. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController{
    @IBOutlet var rest_name: UILabel!
    @IBOutlet var rest_address: UILabel!
    @IBOutlet var rest_phone: UILabel!
    
    //@IBOutlet var imageView: UIImageView!
    
    @IBAction func displayMenu(sender: AnyObject) {
        print("hello menu")
        //        if let dishes = MenuStore.stat_dishes{
        //
        //        }else{
        //           print("no menu")
        //
        //        }
        
    }
    
    @IBAction func emptyCart(sender: AnyObject) {
        
        if MenuStore.order_dishes.isEmpty == false{
            MenuStore.order_dishes.removeAll()
        }
        
        _ = navigationController?.popViewControllerAnimated(true)
    }
    
    
    @IBAction func Logoutbutton(sender: AnyObject) {
        
        NSUserDefaults.standardUserDefaults().setBool(false, forKey: "isUserLoggedIn");
        //NSUserDefaults.standardUserDefaults().setObject(false, forKey: "isUserLoggedIn");
        self.performSegueWithIdentifier("DetailsLogout", sender: self);
    }
    
    //segue data
    var item: NSDictionary!
    //variable to store the item from restaurant
    var restaurant: NSDictionary!
    
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "a7.png")!)

        restaurant = item["restaurant"] as! NSDictionary
        let name = restaurant["name"] as! String
        let id = restaurant["id"] as! String
        
        //MenuStore.fetchMenu()
        
        print(name)
        print(id)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        print("DetailViewController viewWillAppear.")
        
        let name = restaurant["name"] as! String
        let location = restaurant["location"] as! NSDictionary
        let address = location["address"] as! String
        let is_open = restaurant["is_delivering_now"] as! Bool
        //let has_delivery = restaurant["has_online_delivery"] as! Bool
        
        rest_name.text = name
        rest_address.text = address
        
        
        if is_open{
            rest_phone.text = "The Restaurant is CLOSED now"
        }else {
            rest_phone.text = "The Restaurant is OPEN right now"
        }
    }
    
    //    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    //        print("Segue invoked.")
    //
    //        if segue.identifier == "ShowMenu" {
    //
    //                let destinationController = segue.destinationViewController as! DishViewController
    //                destinationController.item = self.item
    //            }
    //        }
}


