//
//  RestaurantViewController.swift
//  Ffor
//
//  Created by Triveni Ashok Naik on 4/30/17.
//  Copyright © 2017 Triveni Ashok Naik. All rights reserved.
//

//
//  RestaurantViewController.swift
//  TestProj
//
//  Created by Nishant Agrawal on 4/24/17.
//  Copyright © 2017 Nishant Agrawal. All rights reserved.
//

import UIKit
class RestaurantViewController: UITableViewController {
    
    var images = [UIImage(named: "6.jpg"), UIImage(named: "7.jpg"), UIImage(named: "8.jpg"), UIImage(named: "9.jpg"), UIImage(named: "10.jpg"), UIImage(named: "11.jpg"), UIImage(named: "12.jpg"), UIImage(named: "13.jpg"), UIImage(named: "14.jpg"), UIImage(named: "15.jpeg"), UIImage(named: "16.jpg"), UIImage(named: "17.jpg"), UIImage(named: "18.jpg"), UIImage(named: "19.jpg"), UIImage(named: "20.jpg"), UIImage(named: "21.jpg"), UIImage(named: "22.jpg"), UIImage(named: "23.jpg"), UIImage(named: "24.jpg"), UIImage(named: "25.jpg"), UIImage(named: "26.jpg"), UIImage(named: "27.jpg"), UIImage(named: "28.jpg")]
    
    //let resStore = RestaurantStore()
    @IBAction func Logoutbutton(sender: AnyObject) {
        
        NSUserDefaults.standardUserDefaults().setObject(false, forKey: "isUserLoggedIn");
        self.performSegueWithIdentifier("ListLogout", sender: self);
    }
    
    override func viewDidLoad() {
        //  tableview.controller = self
        super.viewDidLoad()
        
       // self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "RestaurantCell")
        
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "chair.png")!)
        print("hello table");
        
        //set contentInset for tableView
        let statusBarHeight = UIApplication.sharedApplication().statusBarFrame.height
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        
        //tableView.rowHeight = 150
        tableView.estimatedRowHeight = 150
        
        print("Font: \(UIApplication.sharedApplication().preferredContentSizeCategory)")
        
        //navigationItem.title = "Restaurants List"
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        print("ItemsViewController viewWillAppear")
        
        //navigationItem.title = "Restaurants List"
        
        tableView.reloadData()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        print("sections")
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("resStore.restaurants!.count")
        return RestaurantStore.restaurants!.count
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        print("cells")
        let cell = tableView.dequeueReusableCellWithIdentifier("RestaurantCell", forIndexPath: indexPath) as! RestaurantCell
        let rest = RestaurantStore.restaurants![indexPath.row]
        let restaurant = rest["restaurant"] as! NSDictionary
        let name = restaurant["name"] as! String
        let img_url = restaurant["thumb"] as! String
        print(img_url)
        
        let cuisines = restaurant["cuisines"] as! String
        print(cuisines)
        
//        if let iurl = NSURL(string: img_url) {
//            if let data = NSData(contentsOfURL: iurl) {
//                cell.photo.image = UIImage(data: data)
//            }
//        }
        cell.nameLabel.text = name
        cell.layer.borderWidth = 1.0
        cell.layer.borderColor = UIColor.brownColor().CGColor
        
        cell.photo.image = images[indexPath.row]
        
        cell.updateLabels()
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("Segue invoked.")
        
        if segue.identifier == "ShowDetails" {
            if let row = tableView.indexPathForSelectedRow?.row {
                
                //MenuStore.stat_rest_selected = RestaurantStore.restaurants![row]
                
                let rest = RestaurantStore.restaurants![row]
                let destinationController = segue.destinationViewController as! DetailsViewController
                destinationController.item = rest
            }
        }
    }
    
    
}


