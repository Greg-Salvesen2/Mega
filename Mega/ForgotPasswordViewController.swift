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
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        let width = UIScreen.mainScreen().bounds.size.width
        
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
        self.addUILabel(sendPasswordView, x: 0, y: 0, width: sendPasswordView.frame.size.width, height: sendPasswordView.frame.size.height, labelText: "SEND PASSWORD", red: 0, green: 0, blue: 0, centered: true, fontSize: kDefaultFontSize)
        sendPasswordView.addGestureRecognizer(sendPasswordGestureRecognizer)
    }
    
    func sendPasswordPressed() {
        //TODO: Insert code to call the reset password script, handle any errors that may occur
        
        self.segueToNewViewController(kToForgotPasswordConfirm, sender: self)
    }
    
    func backgroundTapped() {
        emailTextField.resignFirstResponder()
    }
    
    func goToLaunch() {
        self.segueToNewViewController(kToLaunch, sender: self)
    }
    
}