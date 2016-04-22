//
//  RegisterViewController.swift
//  Mega
//
//  Created by Greg Salvesen on 3/27/16.
//  Copyright © 2016 Mega. All rights reserved.
//

import UIKit

/*
 Class Name: RegisterViewController
 Purpose: This ViewController allows the user to register a new account by entering their email and password. This VC also allows users to segue back to the LaunchViewController, and displays the time to the next weekly drawing.
*/
class RegisterViewController: SuperViewController {
    
    var emailTextField, passwordTextField: UITextField!;
    
    /*
     Name: viewDidLoad
     Purpose: Automatically called when the view loads. Sets up the ViewController with the necessary views.
     Inputs: None
     Outputs: None
     Values Modified: emailTextField, passwordTextField
    */
    override func viewDidLoad() {
        super.viewDidLoad();
        
        //Width and height of device
        let width = UIScreen.mainScreen().bounds.size.width
        let height = UIScreen.mainScreen().bounds.size.height
        
        self.view.addBackground(kLoginBackground)
        
        //Gesture recognizers to handle tapping the background, and tapping the logo to return to the launch screen
        let backgroundGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(RegisterViewController.backgroundTapped))
        let launchGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(RegisterViewController.goToLaunch))
        let registerGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(RegisterViewController.registerAccount))
        
        self.view.addGestureRecognizer(backgroundGestureRecognizer)
        
        //Set the width of the logo
        let imageWidth = width * 0.3;
        
        //Find the height of the image based on the scale of the source image
        let imageHeight = (543 * imageWidth) / 489
        
        //Set the width of the text fields, and the login button
        let textFieldWidth = width * 0.75;
        let loginButtonWidth = width * 0.8;
        
        
        //Logo
        let logoView: UIView = self.addUIView(self.view, x: (width / 2) - (imageWidth / 2), y: 50, width: imageWidth, height: imageHeight)
        self.addUIImage(logoView, x: 0, y: 0, width: logoView.frame.size.width, height: logoView.frame.size.height, filepath: kLandingLogo)
        logoView.addGestureRecognizer(launchGestureRecognizer)
        
        //Email Text Field
        let emailView: UIView = self.addUIView(self.view, x: (width / 2) - (textFieldWidth / 2), y: 240, width: textFieldWidth, height: 60, backgroundRed: 255.0, backgroundGreen: 255.0, backgroundBlue: 255.0, transparency: 255.0, rounded: 30.0)
        emailTextField = self.addUITextField(emailView, x: 20, y: 0, width: emailView.frame.size.width - 20, height: emailView.frame.size.height, placeholderText: "EMAIL", isEmail: true)
        
        //Email Text Field toolbar, for close and next buttons
        let emailToolBar = UIToolbar()
        emailToolBar.barStyle = UIBarStyle.BlackTranslucent
        emailToolBar.translucent = true
        emailToolBar.tintColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        
        let emailDoneButton = UIBarButtonItem(title: "Previous", style: UIBarButtonItemStyle.Done, target: self, action: #selector(RegisterViewController.previousPressed))
        let emailNextButton = UIBarButtonItem(title: "Next", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(RegisterViewController.nextPressed))
        emailToolBar.setItems([emailDoneButton, emailNextButton], animated: false)
        emailToolBar.userInteractionEnabled = true
        emailToolBar.sizeToFit()
        emailTextField.inputAccessoryView = emailToolBar
        
        //Password Text Field
        let passwordView: UIView = self.addUIView(self.view, x: (width / 2) - (textFieldWidth / 2), y: 320, width: textFieldWidth, height: 60, backgroundRed: 255.0, backgroundGreen: 255.0, backgroundBlue: 255.0, transparency: 255.0, rounded: 30.0)
        passwordTextField = self.addUITextField(passwordView, x: 20, y: 0, width: passwordView.frame.size.width - 20, height: passwordView.frame.size.height, placeholderText: "PASSWORD", isPass: true)
        
        //Password Text Field toolbar, for previous and submit buttons
        let passwordToolBar = UIToolbar()
        passwordToolBar.barStyle = UIBarStyle.BlackTranslucent
        passwordToolBar.translucent = true
        passwordToolBar.tintColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        
        let passwordDoneButton = UIBarButtonItem(title: "Previous", style: UIBarButtonItemStyle.Done, target: self, action: #selector(RegisterViewController.previousPressed))
        let passwordNextButton = UIBarButtonItem(title: "Next", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(RegisterViewController.nextPressed))
        
        passwordToolBar.setItems([passwordDoneButton, passwordNextButton], animated: false)
        passwordToolBar.userInteractionEnabled = true
        passwordToolBar.sizeToFit()
        passwordTextField.inputAccessoryView = passwordToolBar
        
        //Register Button
        let registerView: UIView = self.addUIView(self.view, x: (width / 2) - (loginButtonWidth / 2), y: height - 100, width: loginButtonWidth, height: 65, backgroundRed: 230.0, backgroundGreen: 201.0, backgroundBlue: 37.0, transparency: 255.0, rounded: 30.0)
        self.addUILabel(registerView, x: 0, y: 0, width: registerView.frame.size.width, height: registerView.frame.size.height, labelText: "CREATE ACCOUNT", red: 0, green: 0, blue: 0, centered: true, fontSize: kDefaultFontSize)
        
        registerView.addGestureRecognizer(registerGestureRecognizer)
    }
    
    /*
     Name: registerAccount
     Purpose: Takes the text from the email and password text fields, and queries the register.php script. Handles any errors that may have occured, and otherwise registers the account and logs the user in.
     Inputs: None
     Outputs: None
     Values Modified: None
    */
    func registerAccount() {
        let email = emailTextField.text!
        let password = passwordTextField.text!
        
        let url = NSURL(string: kURLRegister)
        let request = NSMutableURLRequest(URL: url!)
        let postString = "email=\(email)&password=\(password)"
        print(postString)
        let session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            //Checks to make sure there are no errors, if there are display an unable to complete server connection error
            guard error == nil else {
                dispatch_async(dispatch_get_main_queue(), {
                    let alert = UIAlertController(title: "Unable to complete server connection", message: "Try checking your internet connection, and trying again.", preferredStyle: .Alert)
                    alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                })
                return
            }
            
            let dataString = String(data: data!, encoding: NSUTF8StringEncoding)!.stringByReplacingOccurrencesOfString("\"", withString: "")
            print(dataString)
            if(dataString == "Successfully registered account") {
                //If server accepts a successful login, handle the login
                self.handleLogin()
            } else if(dataString == "Invalid email address") {
                //If the server returns an invalid email message, display an invalid email or password error
                dispatch_async(dispatch_get_main_queue(), {
                    let alert = UIAlertController(title: "Invalid email", message: "The email you provided is not a valid email address. Please try again.", preferredStyle: .Alert)
                    alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                })
            } else if(dataString == "Email address already exists") {
                //If the server returns an email already exists message, display an email already exists error
                dispatch_async(dispatch_get_main_queue(), {
                    let alert = UIAlertController(title: "Email address already exists  ", message: "The email you provided is already associated with a Mega account", preferredStyle: .Alert)
                    alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                })
            } else if(dataString == "Unexpected Error") {
                //If the server returns an unexpected error message, display an unexpected error
                dispatch_async(dispatch_get_main_queue(), {
                    let alert = UIAlertController(title: "Unexpected error", message: "Something went wrong. Sorry about that, try again in a few minutes.", preferredStyle: .Alert)
                    alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                })
            }
            return
        })
        
        task.resume()
    }
    
    /*
     Name: previousPressed
     Purpose: If the email text field is active, unactivate the text field. If the password text field is active, activate the email text field instead
     Inputs: None
     Outputs: None
     Values Modified: None
    */
    func previousPressed() {
        if(emailTextField.isFirstResponder()) {
            emailTextField.resignFirstResponder()
        } else {
            emailTextField.becomeFirstResponder()
        }
    }
    
    /*
     Name: nextPressed
     Purpose: If the email text field is active, activate the password text field instead. If the password text field is active, unactivate the text field, and call the loginPressed function
     Inputs: None
     Outputs: None
     Values Modified: None
    */
    func nextPressed() {
        if(emailTextField.isFirstResponder()) {
            passwordTextField.becomeFirstResponder()
        } else {
            passwordTextField.resignFirstResponder()
            registerAccount()
        }
    }
    
    /*
     Name: backgroundTapped
     Purpose: Deactivates the email and password text fields, to close the keyboard.
     Inputs: None
     Outputs: None
     Values Modified: None
    */
    func backgroundTapped() {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    /*
     Name: goToLaunch
     Purpose: Sends user to LaunchViewController
     Inputs: None
     Outputs: None
     Values Modified: None
    */
    func goToLaunch() {
        self.segueToNewViewController(kToLaunch, sender: self)
    }
    
    /*
     Name: handleLogin
     Purpose: Sets the loginCheck flag to logged in, then sends user to CarListViewController
     Inputs: None
     Outputs: None
     Values Modified: None
    */
    func handleLogin() {
        let defaults = NSUserDefaults.standardUserDefaults()
        
        defaults.setValue("Logged in", forKey: "loginCheck")
        
        defaults.synchronize()
        
        self.segueToNewViewController(kToCarList, sender: self)
    }
    
}