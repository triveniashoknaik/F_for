//
//  RegisterViewController.swift
//  Ffor
//
//  Created by Triveni Ashok Naik on 4/29/17.
//  Copyright © 2017 Triveni Ashok Naik. All rights reserved.
//

//
//  RegisterPageViewController.swift
//  UserLoginReg
//
//  Created by Nishant Agrawal on 3/31/17.
//  Copyright © 2017 Nishant Agrawal. All rights reserved.
//
//1. proper email authentication while register
//2. after registration successful-- segue back to login
//3. after already registered-- clear the fields
//4. after already registered-- first responder
//5. keyboard--first responder activating and deactivating



import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    @IBOutlet weak var repeatPassword: UITextField!
    
    @IBAction func dismissKeyboard(sender: AnyObject) {
        userName.resignFirstResponder()
        userEmail.resignFirstResponder()
        userPassword.resignFirstResponder()
        repeatPassword.resignFirstResponder()
    }
    
    @IBAction func registerButton(sender: AnyObject) {
        
        let uName = userName.text;
        let uEmail = userEmail.text;
        let uPassword = userPassword.text;
        let rPassword = repeatPassword.text;
        
        //check for empty fields
        if(uName!.isEmpty || uEmail!.isEmpty || uPassword!.isEmpty || rPassword!.isEmpty){
            
            //display error
            displayError("All fields are required");
            
            return;
        }
        
        //check email address format
        if isValidEmail(uEmail!) == false {
            
            //display error
            displayError2("Invalid Email Address");
            return;
        }
        
        //check password match
        if(uPassword != rPassword){
            
            //display error
            displayError("Passwords do not match");
            return;
        }
        
        
        //if same email do not store
        let userEmailStored = NSUserDefaults.standardUserDefaults().stringForKey("uEmail");
        if(uEmail == userEmailStored){
            displayError2("Already registered");
        }
        
        
        
        //store data
        NSUserDefaults.standardUserDefaults().setObject(uName, forKey: "uName");
        NSUserDefaults.standardUserDefaults().setObject(uEmail, forKey: "uEmail");
        NSUserDefaults.standardUserDefaults().setObject(uPassword, forKey: "uPassword");
        
        NSUserDefaults.standardUserDefaults().synchronize();
        
        
        //confirmation
        displayConfirmation();
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "a7.png")!)
        //
        let backButton = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton
        
        //remove autocorrect
        userName.autocorrectionType = .No
        userEmail.autocorrectionType = .No
        userPassword.autocorrectionType = .No
        repeatPassword.autocorrectionType = .No
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    func displayError(errorMessage:String){
        let errAlert = UIAlertController(title:"Alert", message: errorMessage, preferredStyle: UIAlertControllerStyle.Alert);
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil);
        
        errAlert.addAction(okAction);
        
        self.presentViewController(errAlert, animated: true, completion: nil);
    }
    
    func displayError2(errorMessage:String){
        let errAlert = UIAlertController(title:"Alert", message: errorMessage, preferredStyle: UIAlertControllerStyle.Alert);
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default){
            action in
            self.userName.text = ""
            self.userEmail.text = ""
            self.userPassword.text = ""
            self.repeatPassword.text = ""
        }
        
        errAlert.addAction(okAction);
        
        self.presentViewController(errAlert, animated: true, completion: nil);
    }
    
    func displayConfirmation(){
        let confAlert = UIAlertController(title:"Alert", message: "Registration successful!", preferredStyle: UIAlertControllerStyle.Alert);
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default){
            action in
            self.dismissViewControllerAnimated(true, completion: nil)
            self.performSegueWithIdentifier("RegisterDone", sender: self);
        }
        
        confAlert.addAction(okAction);
        
        self.presentViewController(confAlert, animated: true, completion: nil);
    }
    
    //check valid email address
    func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        print(emailTest.evaluateWithObject(testStr))
        return emailTest.evaluateWithObject(testStr)
    }
    
    
}

