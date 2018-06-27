//
//  CartViewController.swift
//  TestProj
//
//  Created by Triveni Ashok Naik on 4/27/17.
//  Copyright © 2017 Nishant Agrawal. All rights reserved.
//

import UIKit
import MessageUI

class CartViewController: UITableViewController, MFMailComposeViewControllerDelegate {
    
    var performMail:Int = 1
    
//    @IBOutlet var totalValue: UILabel!
//    
//        var totalValueComp2: Double! {
//            var newNumber: Double = 0.00
//            for dish in MenuStore.order_dishes{
//                newNumber += dish.valueInDollars
//            }
//            return newNumber
//        }
    
    
    @IBAction func placeOrderButton(sender: AnyObject) {
        print("place order button")
        if MenuStore.order_dishes.isEmpty == true{
            displayErr("Please select items from the menu!")
        }else{
        
        if performMail == 0 {
            let mailComposeViewController = configuredMailComposeViewController()
            if MFMailComposeViewController.canSendMail() {
                self.presentViewController(mailComposeViewController, animated: true, completion: nil)
            } else {
                self.showSendMailErrorAlert()
            }
        } else if performMail == 1 {
            
            displayConf("Your order has been placed. Want to make another order?")
        }
    }
}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "a2.png")!)
        
        //set contentInset for tableView
        let statusBarHeight = UIApplication.sharedApplication().statusBarFrame.height
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        
        //tableView.rowHeight = 150
        tableView.estimatedRowHeight = 65
        
        print("Font: \(UIApplication.sharedApplication().preferredContentSizeCategory)")
        print(MenuStore.order_dishes.count)
        
    }
    
    
    //Asks the data source to return the number of sections in the table view.
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    //
    //Asks the data source to return the number of rows in a given section of a table view.
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuStore.order_dishes.count
    }
    //
    //    //Asks the data source for a cell to insert in a particular location of the table view.
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let dish = MenuStore.order_dishes[indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier("CartCell", forIndexPath: indexPath) as! CartCell
        
        cell.nameLabel.text = dish.name
        cell.valueLabel.text = "$\(dish.valueInDollars)"
        
        cell.updateLabels()
        
        return cell
    }
    
    func displayConf(errorMessage:String){
        let errAlert = UIAlertController(title:"Alert", message: errorMessage, preferredStyle: UIAlertControllerStyle.Alert);
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default){
            action in
            
            MenuStore.order_dishes.removeAll()
            self.performSegueWithIdentifier("OrderPlaced", sender: self);
        }
        
        let cancelAction = UIAlertAction(title: "CANCEL", style: UIAlertActionStyle.Default){
            action in
            exit(0)
        }
        
        errAlert.addAction(okAction);
        errAlert.addAction(cancelAction);
        
        self.presentViewController(errAlert, animated: true, completion: nil);
    }
    
    
    func displayErr(errorMessage:String){
        let errAlert = UIAlertController(title:"Alert", message: errorMessage, preferredStyle: UIAlertControllerStyle.Alert);
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        
        errAlert.addAction(okAction);
        
        self.presentViewController(errAlert, animated: true, completion: nil);
    }
    

    @IBAction func toggleEditingMode(sender: AnyObject) {
        //tableView.editing = true
        
        if editing {
            //editing = false
            setEditing(false, animated: true)
            //button.setTitle("Edit", forState: .Normal)
        }
        else {
            //editing = true
            setEditing(true, animated: true)
            //button.setTitle("Done", forState: .Normal)
        }
    }
    
    //Asks the data source to commit the insertion or deletion of a specified row
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        print(#function)
        
        if editingStyle == .Delete {
            let item = MenuStore.order_dishes[indexPath.row]
            
            let title = "Delete \(item.name)?"
            let message = "Are you sure?"
            
            //UIAlertController
            let ac = UIAlertController(title: title, message: message, preferredStyle: .ActionSheet)
            
            //Cancel Action
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
            ac.addAction(cancelAction)
            
            //Delete Action
            let deleteAction = UIAlertAction(title: "Delete", style: .Destructive, handler: {(delete) -> Void in
                MenuStore.removeItem(item)
                
                self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            })
            
            ac.addAction(deleteAction)
            
            presentViewController(ac, animated: true, completion: nil)
        }
    }
            
    ////////
    ///////
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients(["nagraw01@syr.edu"])
        mailComposerVC.setSubject("Order Details")
        
        let placedBy = NSUserDefaults.standardUserDefaults().stringForKey("uName");
        let deliverAt = NSUserDefaults.standardUserDefaults().stringForKey("uAddress");
        
        var names: String = ""
        
        for dish in MenuStore.order_dishes{
            names += dish.name + " :: Amount: "
        }
        
        let messageString = "Order Place by: \(placedBy)" +
                            " Deliver At: \(deliverAt)" +
                            "Order Details: "
            
        mailComposerVC.setMessageBody(messageString, isHTML: false)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertController(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "CANCEL", style: UIAlertActionStyle.Default, handler: nil)
        
        sendMailErrorAlert.addAction(okAction);
        
        self.presentViewController(sendMailErrorAlert, animated: true, completion: nil);
    }
    
    // MFMailComposeViewControllerDelegate
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
}

