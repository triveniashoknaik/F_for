//
//  LoginViewController.swift
//  Ffor
//
//  Created by Triveni Ashok Naik on 4/29/17.
//  Copyright © 2017 Triveni Ashok Naik. All rights reserved.
//1. facebook and google login
//2. viewdiddisappear--clear the login details

import UIKit

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var userEmail: UITextField!
    
    @IBOutlet weak var userPassword: UITextField!
    
    @IBAction func dismissKeyboard(sender: AnyObject) {
        userEmail.resignFirstResponder()
        userPassword.resignFirstResponder()
    }
    
    
    @IBAction func Loginbutton(sender: AnyObject) {
        
        let uEmail = userEmail.text;
        let uPassword = userPassword.text;
        
        let userEmailStored = NSUserDefaults.standardUserDefaults().stringForKey("uEmail");
        let userPasswordStored = NSUserDefaults.standardUserDefaults().stringForKey("uPassword");
        
        if(userEmailStored == uEmail){
            if(uPassword == userPasswordStored){
                
                //login is successful...rdirect to the address controller
                NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isUserLoggedIn");
                
                NSUserDefaults.standardUserDefaults().synchronize();
                
                //self dismissal
                self.dismissViewControllerAnimated(true, completion: nil);
                
                self.performSegueWithIdentifier("LoginToAddress", sender: self);
            }
            else{
                displayError("Wrong password!");
            }
        }
        else{
            displayError("You are not registered!");
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "a8.png")!)

        //for keyboard
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillShow), name:UIKeyboardWillShowNotification, object: nil)
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillHide), name:UIKeyboardWillHideNotification, object: nil)
        
        //to remove the back button
        let backButton = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton
        
        //remove autocorrect
        userEmail.autocorrectionType = .No
        userPassword.autocorrectionType = .No
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    //function to display error alert
    func displayError(errorMessage:String){
        let errAlert = UIAlertController(title:"Alert", message: errorMessage, preferredStyle: UIAlertControllerStyle.Alert);
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil);
        
        errAlert.addAction(okAction);
        
        self.presentViewController(errAlert, animated: true, completion: nil);
    }
    

    
    
}
