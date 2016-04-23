//
//  TOSViewController.swift
//  Mega
//
//  Created by Greg Salvesen on 4/20/16.
//  Copyright © 2016 Mega. All rights reserved.
//

import UIKit

/*
 Class Name: TOSViewController
 Purpose: This ViewController is the initial view that appears when the user launches the app. This view allows the user to decide whether they want to go to the Register page or to the Login page. This view also queries the countdown script, in order to display the time to the next weekly drawing.
 */
class TOSViewController: SuperViewController {
    
    /*
     Name: viewDidLoad
     Purpose: Automatically called when the view loads. Sets up the ViewController with the necessary views.
     Inputs: None
     Outputs: None
     Values Modified: None
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Width and height of device
        let width = UIScreen.mainScreen().bounds.size.width
        let height = UIScreen.mainScreen().bounds.size.height
        
        //Gesture recognizers to either send user to login or register page
        let loginGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LaunchViewController.goToLogin))
        let registerGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LaunchViewController.goToRegister))
        
        self.view.addBackground(kLoginBackground)
        
        //Set the width of the logo
        let imageWidth = width * 0.3;
        
        //Set the width of the login and register buttons
        let buttonWidth = width * 0.75;
        
        //Find the height of the logo based on the scale of the source image
        let imageHeight = (543 * imageWidth) / 489
        
        //Logo
        self.addUIImage(self.view, x: (width / 2) - (imageWidth / 2), y: 50, width: imageWidth, height: imageHeight, filepath: kLandingLogo)
        
        // Login and Register Buttons
        let loginView: UIView = self.addUIView(self.view, x: (width / 2) - (buttonWidth / 2), y: 275, width: buttonWidth, height: 60, backgroundRed: 255.0, backgroundGreen: 255.0, backgroundBlue: 255.0, transparency: 255.0, rounded: 30.0)
        self.addUILabel(loginView, x: 0, y: 0, width: loginView.frame.size.width, height: loginView.frame.size.height, labelText: "LOGIN")
        
        let registerView: UIView = self.addUIView(self.view, x: (width / 2) - (buttonWidth / 2), y: 375, width: buttonWidth, height: 60, backgroundRed: 230.0, backgroundGreen: 201.0, backgroundBlue: 37.0, transparency: 255.0, rounded: 30.0)
        self.addUILabel(registerView, x: 0, y: 0, width: registerView.frame.size.width, height: registerView.frame.size.height, labelText: "REGISTER")
        
        loginView.addGestureRecognizer(loginGestureRecognizer)
        registerView.addGestureRecognizer(registerGestureRecognizer)
        
        //Adds time to next weekly drawing
        self.addTimeToNextWeeklyWinner(self.view, x: 0, y: 550, width: width, height: height - 550, red: 230.0, green: 201.0, blue: 37.0)
    }
    
    /*
     Name: viewDidAppear
     Purpose: Automatically called when the view appears. Checks if user is already logged in. If they are, immediately send them to the Car List Page.
     Inputs: None
     Outputs: None
     Values Modified: None
     */
    override func viewDidAppear(animated: Bool) {
        let defaults = NSUserDefaults.standardUserDefaults()
        
        //If login check is unset, or set to Logged out, do nothing, otherwise send to
        //car list
        guard defaults.stringForKey("loginCheck") == nil || defaults.stringForKey("loginCheck") == "Logged in" else {
            self.segueToNewViewController(kToCarList, sender: self)
            return
        }
    }
    
    /*
     Name: goToLogin
     Purpose: Sends user to LoginViewController
     Inputs: None
     Outputs: None
     Values Modified: None
     */
    func goToLogin() {
        self.segueToNewViewController(kToLogin, sender: self)
    }
    
    /*
     Name: goToRegister
     Purpose: Sends user to LoginViewController
     Inputs: None
     Outputs: None
     Values Modified: None
     */
    func goToRegister() {
        self.segueToNewViewController(kToRegister, sender: self)
    }
    
}