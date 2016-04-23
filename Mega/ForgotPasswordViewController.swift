//
//  ForgotPasswordViewController.swift
//  Mega
//
//  Created by Greg Salvesen on 3/27/16.
//  Copyright © 2016 Mega. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: SuperViewController {
    
    var emailTextField: UITextField!;
    var toForgotPasswordConfirmView: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        let width = UIScreen.mainScreen().bounds.size.width
        toForgotPasswordConfirmView = false
        
        self.view.addBackground(kLoginBackground)
        
        let backgroundGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ForgotPasswordViewController.backgroundTapped))
        let sendPasswordGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ForgotPasswordViewController.sendPasswordPressed))
        let launchGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ForgotPasswordViewController.goToLaunch))
        
        self.view.addGestureRecognizer(backgroundGestureRecognizer)
        
        let imageWidth = width * 0.3;
        
        //Find the height of the image based on the scale of the source image
        let imageHeight = (543 * imageWidth) / 489
        
        let textFieldWidth = width * 0.75;
        let loginButtonWidth = width * 0.8;
        
        //Logo
        let logoView: UIView = self.addUIView(self.view, x: (width / 2) - (imageWidth / 2), y: 50, width: imageWidth, height: imageHeight)
        self.addUIImage(logoView, x: 0, y: 0, width: logoView.frame.size.width, height: logoView.frame.size.height, filepath: kLandingLogo)
        logoView.addGestureRecognizer(launchGestureRecognizer)
        
        //Email Text Field
        let emailView: UIView = self.addUIView(self.view, x: (width / 2) - (textFieldWidth / 2), y: 280, width: textFieldWidth, height: 60, backgroundRed: 255.0, backgroundGreen: 255.0, backgroundBlue: 255.0, transparency: 255.0, rounded: 30.0)
        emailTextField = self.addUITextField(emailView, x: 20, y: 0, width: emailView.frame.size.width - 20, height: emailView.frame.size.height, placeholderText: "EMAIL")
        
        //Send Password Button
        let sendPasswordView: UIView = self.addUIView(self.view, x: (width / 2) - (loginButtonWidth / 2), y: 400, width: loginButtonWidth, height: 65, backgroundRed: 230.0, backgroundGreen: 201.0, backgroundBlue: 37.0, transparency: 255.0, rounded: 30.0)
        self.addUILabel(sendPasswordView, x: 0, y: 0, width: sendPasswordView.frame.size.width, height: sendPasswordView.frame.size.height, labelText: "SEND PASSWORD")
        sendPasswordView.addGestureRecognizer(sendPasswordGestureRecognizer)
    }
    
    func sendPasswordPressed() {
        let email = emailTextField.text!
        
        let url = NSURL(string: kURLForgotPassword)
        let request = NSMutableURLRequest(URL: url!)
        let postString = "email=\(email)"
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
            if(dataString == "Successfully emailed user") {
                //If server accepts a successful login, handle the login
                dispatch_async(dispatch_get_main_queue(), {
                    self.toForgotPasswordConfirmView = true
                    self.segueToNewViewController(kToForgotPasswordConfirm, sender: self)
                })
            } else if(dataString == "Invalid email address") {
                //If the server returns an invalid email message, display an invalid email or password error
                dispatch_async(dispatch_get_main_queue(), {
                    let alert = UIAlertController(title: "Invalid email", message: "The email you provided is not a valid email address. Please try again.", preferredStyle: .Alert)
                    alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                })
            } else if(dataString == "Email address not found") {
                //If the server returns an invalid email or password message, display an invalid email or password error
                dispatch_async(dispatch_get_main_queue(), {
                    let alert = UIAlertController(title: "Email not found", message: "This email is not associated with any Mega account. Please try again.", preferredStyle: .Alert)
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(toForgotPasswordConfirmView == true) {
            let targetViewController = segue.destinationViewController as! ForgotPasswordConfirmViewController
            
            targetViewController.email = emailTextField.text
        }
    }
    
    func backgroundTapped() {
        emailTextField.resignFirstResponder()
    }
    
    func goToLaunch() {
        self.segueToNewViewController(kToLaunch, sender: self)
    }
    
}