//
//  LaunchViewController.swift
//  Mega
//
//  Created by Greg Salvesen on 3/27/16.
//  Copyright © 2016 Mega. All rights reserved.
//

import UIKit

class LaunchViewController: SuperViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = UIScreen.mainScreen().bounds.size.width
        let height = UIScreen.mainScreen().bounds.size.height
        
        let loginGestureRecognizer = UITapGestureRecognizer(target: self, action: "goToLogin")
        let registerGestureRecognizer = UITapGestureRecognizer(target: self, action: "goToRegister")
        
        self.view.addBackground(kLoginBackground)
        
        let imageWidth = width * 0.3;
        
        let buttonWidth = width * 0.75;
        
        //Find the height of the image based on the scale of the source image
        let imageHeight = (543 * imageWidth) / 489
        
        
        //Logo
        self.addUIImage(self.view, x: (width / 2) - (imageWidth / 2), y: 50, width: imageWidth, height: imageHeight, filepath: kLandingLogo)
        
        // Login and Register Buttons
        let loginView: UIView = self.addUIView(self.view, x: (width / 2) - (buttonWidth / 2), y: 275, width: buttonWidth, height: 60, backgroundRed: 255.0, backgroundGreen: 255.0, backgroundBlue: 255.0, transparency: 255.0, roundedWidth: 40.0, roundedHeight: 40.0)
        self.addUILabel(loginView, x: 0, y: 0, width: loginView.frame.size.width, height: loginView.frame.size.height, labelText: "LOGIN", red: 0.0, green: 0.0, blue: 0.0, centered: true, fontSize: kDefaultFontSize)
        
        let registerView: UIView = self.addUIView(self.view, x: (width / 2) - (buttonWidth / 2), y: 375, width: buttonWidth, height: 60, backgroundRed: 230.0, backgroundGreen: 201.0, backgroundBlue: 37.0, transparency: 255.0, roundedWidth: 40.0, roundedHeight: 40.0)
        self.addUILabel(registerView, x: 0, y: 0, width: registerView.frame.size.width, height: registerView.frame.size.height, labelText: "REGISTER", red: 0.0, green: 0.0, blue: 0.0, centered: true, fontSize: kDefaultFontSize)
        
        loginView.addGestureRecognizer(loginGestureRecognizer)
        registerView.addGestureRecognizer(registerGestureRecognizer)
        
        self.addTimeToNextWeeklyWinner(self.view, x: 0, y: 550, width: width, height: height - 550, red: 230.0, green: 201.0, blue: 37.0)
        
    }
    
    func goToLogin() {
        self.segueToNewViewController(kToLogin, sender: self)
    }
    
    func goToRegister() {
        self.segueToNewViewController(kToRegister, sender: self)
    }

}