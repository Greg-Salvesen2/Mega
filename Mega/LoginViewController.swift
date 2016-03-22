//
//  ViewController.swift
//  Mega
//
//  Created by Greg Salvesen on 3/8/16.
//  Copyright © 2016 Mega. All rights reserved.
//

import UIKit

class LoginViewController: SuperViewController {
    
    var emailTextField, passwordTextField: UITextField!;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        let width = UIScreen.mainScreen().bounds.size.width
        let height = UIScreen.mainScreen().bounds.size.height
        
        self.view.addBackground(kLoginBackground)
        
        let backgroundGestureRecognizer = UITapGestureRecognizer(target: self, action: "backgroundTapped")
        
        self.view.addGestureRecognizer(backgroundGestureRecognizer)
        
        let imageWidth = width * 0.3;
        
        //Find the height of the image based on the scale of the source image
        let imageHeight = (543 * imageWidth) / 489
        
        
        let textFieldWidth = width * 0.75;
        let loginButtonWidth = width * 0.8;
        
        
        //Background Image
        self.addUIImage(self.view, x: (width / 2) - (imageWidth / 2), y: 50, width: imageWidth, height: imageHeight, filepath: kLandingLogo)
        
        //Email and Login Text Fields
        let emailView: UIView = self.addUIView(self.view, x: (width / 2) - (textFieldWidth / 2), y: 240, width: textFieldWidth, height: 60, backgroundRed: 255.0, backgroundGreen: 255.0, backgroundBlue: 255.0, transparency: 255.0, roundedWidth: 40.0, roundedHeight: 40.0)
        emailTextField = self.addUITextField(emailView, x: 20, y: 0, width: emailView.frame.size.width - 20, height: emailView.frame.size.height, placeholderText: "EMAIL")
        
        let passwordView: UIView = self.addUIView(self.view, x: (width / 2) - (textFieldWidth / 2), y: 320, width: textFieldWidth, height: 60, backgroundRed: 255.0, backgroundGreen: 255.0, backgroundBlue: 255.0, transparency: 255.0, roundedWidth: 40.0, roundedHeight: 40.0)
        passwordTextField = self.addUITextField(passwordView, x: 20, y: 0, width: passwordView.frame.size.width - 20, height: passwordView.frame.size.height, placeholderText: "PASSWORD")
        
        
        //Forgot Password Label
        let forgotPasswordView: UIView = self.addUIView(self.view, x: width / 2, y: 390, width: textFieldWidth / 2, height: 25, backgroundRed: 1.0, backgroundGreen: 0.0, backgroundBlue: 0.0, transparency: 0.0, roundedWidth: 0.0, roundedHeight: 0.0)
        self.addUILabel(forgotPasswordView, x: 0, y: 0, width: forgotPasswordView.frame.size.width, height: forgotPasswordView.frame.size.height, labelText: "Forgot Password?", red: 230.0, green:201.0, blue:37.0, centered: true, fontSize: kDefaultFontSize)
        
        //Login Button
        let loginView: UIView = self.addUIView(self.view, x: (width / 2) - (loginButtonWidth / 2), y: 475, width: loginButtonWidth, height: 65, backgroundRed: 230.0, backgroundGreen: 201.0, backgroundBlue: 37.0, transparency: 255.0, roundedWidth: 40.0, roundedHeight: 40.0)
        self.addUILabel(loginView, x: 0, y: 0, width: loginView.frame.size.width, height: loginView.frame.size.height, labelText: "LOGIN", red: 0, green: 0, blue: 0, centered: true, fontSize: kDefaultFontSize)
        
        self.addTimeToNextWeeklyWinner(self.view, x: 0, y: 550, width: width, height: height - 550, red: 230.0, green: 201.0, blue: 37.0)
        
        
    }
    
    func backgroundTapped() {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }


}

