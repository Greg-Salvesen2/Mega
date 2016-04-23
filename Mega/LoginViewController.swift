//
//  ViewController.swift
//  Mega
//
//  Created by Greg Salvesen on 3/8/16.
//  Copyright © 2016 Mega. All rights reserved.
//

import UIKit

/*
 Class Name: LoginViewController
 Purpose: This ViewController allows the user to login by entering their email and password for an already registered account. This VC also allows users to segue back to the LaunchViewController, or to the ForgotPasswordViewController, if they have forgotten their password. This view also queries the countdown script, in order to display the time to the next weekly drawing.
*/
class LoginViewController: SuperViewController {
    
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
        
        //Gesture recognizers to handle tapping the background, tapping the login button, tapping the forgot password label, and tapping the logo to return to the launch screen
        let backgroundGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.backgroundTapped))
        let loginGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.loginPressed))
        let forgotGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.goToForgotPassword))
        let launchGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.goToLaunch))
        
        self.view.addGestureRecognizer(backgroundGestureRecognizer)
        
        //Set the width of the logo
        let imageWidth = width * 0.3;
        
        //Find the height of the logo based on the scale of the source image
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
        
        let emailDoneButton = UIBarButtonItem(title: "Previous", style: UIBarButtonItemStyle.Done, target: self, action: #selector(LoginViewController.previousPressed))
        let emailNextButton = UIBarButtonItem(title: "Next", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(LoginViewController.nextPressed))
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
        
        let passwordDoneButton = UIBarButtonItem(title: "Previous", style: UIBarButtonItemStyle.Done, target: self, action: #selector(LoginViewController.previousPressed))
        let passwordNextButton = UIBarButtonItem(title: "Next", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(LoginViewController.nextPressed))
        
        passwordToolBar.setItems([passwordDoneButton, passwordNextButton], animated: false)
        passwordToolBar.userInteractionEnabled = true
        passwordToolBar.sizeToFit()
        passwordTextField.inputAccessoryView = passwordToolBar
        
        //Forgot Password Label
        let forgotPasswordView: UIView = self.addUIView(self.view, x: width / 2, y: 390, width: textFieldWidth / 2, height: 25)
        self.addUILabel(forgotPasswordView, x: 0, y: 0, width: forgotPasswordView.frame.size.width, height: forgotPasswordView.frame.size.height, labelText: "Forgot Password?", red: 230.0, green:201.0, blue:37.0)
        forgotPasswordView.addGestureRecognizer(forgotGestureRecognizer)
        
        //Login Button
        let loginView: UIView = self.addUIView(self.view, x: (width / 2) - (loginButtonWidth / 2), y: 475, width: loginButtonWidth, height: 65, backgroundRed: 230.0, backgroundGreen: 201.0, backgroundBlue: 37.0, transparency: 255.0, rounded: 30.0)
        self.addUILabel(loginView, x: 0, y: 0, width: loginView.frame.size.width, height: loginView.frame.size.height, labelText: "LOGIN")
        loginView.addGestureRecognizer(loginGestureRecognizer)
        
        //Adds time to next weekly winner
        self.addTimeToNextWeeklyWinner(self.view, x: 0, y: 550, width: width, height: height - 550, red: 230.0, green: 201.0, blue: 37.0)
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
            loginPressed()
        }
    }
    
    /*
     Name: loginPressed
     Purpose: Takes the text from the email and password text fields, and queries the login.php script. Handles any errors that may have occured, and otherwise logs the user in.
     Inputs: None
     Outputs: None
     Values Modified: None
    */
    func loginPressed() {
        let email = emailTextField.text!
        let password = passwordTextField.text!
        
        let url = NSURL(string: kURLLogin)
        let request = NSMutableURLRequest(URL: url!)
        let postString = "email=\(email)&password=\(password)"
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
            if(dataString == "Successful login") {
                //If server accepts a successful login, handle the login
                self.handleLogin()
            } else if(dataString == "Invalid email or password") {
                //If the server returns an invalid email or password message, display an invalid email or password error
                dispatch_async(dispatch_get_main_queue(), {
                    let alert = UIAlertController(title: "Invalid email or password", message: "", preferredStyle: .Alert)
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
     Name: goToLogin
     Purpose: Sends user to ForgotPasswordViewController
     Inputs: None
     Outputs: None
     Values Modified: None
    */
    func goToForgotPassword() {
        self.segueToNewViewController(kToForgotPassword, sender: self)
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

