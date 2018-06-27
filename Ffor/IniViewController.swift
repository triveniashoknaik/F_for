//
//  ViewController.swift
//  Ffor
//
//  Created by Triveni Ashok Naik on 4/29/17.
//  Copyright © 2017 Triveni Ashok Naik. All rights reserved.
//

import UIKit

class IniViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        let isUserLoggedIn:Bool = NSUserDefaults.standardUserDefaults().boolForKey("isUserLoggedIn");
        
        activityIndicator.stopAnimating()
        UIApplication.sharedApplication().endIgnoringInteractionEvents()
        
        if(isUserLoggedIn == false){
            self.performSegueWithIdentifier("ProtecToLogin", sender: self);
            
        }
        else{
            self.performSegueWithIdentifier("ProtecToAddress", sender: self);
            
        }
        
    }


}


// keyboard textfield-- resigning working-- nor need to put the scroll view
// potrait
