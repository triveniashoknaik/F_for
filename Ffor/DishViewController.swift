//
//  DishViewController.swift
//  TestProj
//
//  Created by Triveni Ashok Naik on 4/25/17.
//  Copyright © 2017 Nishant Agrawal. All rights reserved.
//

import UIKit

class DishViewController: UITableViewController, UINavigationBarDelegate {
    
    let menuStore = MenuStore()
    
    //segue data
    //var item: NSDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set contentInset for tableView
        let statusBarHeight = UIApplication.sharedApplication().statusBarFrame.height
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        
        //tableView.rowHeight = 150
        tableView.estimatedRowHeight = 65
        
        print("Font: \(UIApplication.sharedApplication().preferredContentSizeCategory)")
        print(menuStore.stat_dishes.count)
    }
    
    //
    //Asks the data source to return the number of sections in the table view.
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    //
    //Asks the data source to return the number of rows in a given section of a table view.
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return menuStore.stat_dishes.count //?? 0
    }
   
    //    //Asks the data source for a cell to insert in a particular location of the table view.
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let dish = menuStore.stat_dishes[indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier("DishCell", forIndexPath: indexPath) as! DishCell
        
        cell.nameLabel.text = dish.name
        cell.valueLabel.text = "$\(dish.valueInDollars)"
        cell.layer.borderWidth = 1.0
        cell.layer.borderColor = UIColor.brownColor().CGColor
        
        cell.updateLabels()
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){

        let dish = menuStore.stat_dishes[indexPath.row]
        print(dish.name)
        askConfirmation(dish);
        
    }
    
    func askConfirmation(dish: Dish){
        let confAlert = UIAlertController(title:"Alert", message: "ADD TO YOUR CART!", preferredStyle: UIAlertControllerStyle.Alert);
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default){
            action in
            
            if MenuStore.order_dishes.isEmpty == true {
                 print("hello000000")
                MenuStore.order_dishes.append(dish);
            }else{
                print("hello conf:")
                var x: Int = 0
                for dishcheck in MenuStore.order_dishes{
                    if dish.name == dishcheck.name{
                        x = 1
                        break
                        
                    }else{
                        print("break")
                    }
                }
                
                if x == 0 {
                    MenuStore.order_dishes.append(dish);
                }
            }

            
        }
        
        let cancelAction = UIAlertAction(title: "CANCEL", style: UIAlertActionStyle.Default, handler: nil)
        
        confAlert.addAction(okAction);
        confAlert.addAction(cancelAction);
        
        self.presentViewController(confAlert, animated: true, completion: nil);
    }
    
    //    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    //        print("Segue invoked.")
    //
    //        if segue.identifier == "ShowCart" {
    //
    //            let destinationController = segue.destinationViewController as! CartViewController
    //            destinationController.item = self.item
    //        }
    //    }
    
}




