//
//  SuperViewController.swift
//  Mega
//
//  Created by Greg Salvesen on 3/17/16.
//  Copyright © 2016 Mega. All rights reserved.
//

import Foundation
import UIKit

class SuperViewController: UIViewController {
    
    var daysLabel, hoursLabel, minutesLabel, secondsLabel: UILabel!;
    
    func addUIImage(curView: UIView, x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, filepath: String)-> UIImageView {
        
        let image: UIImageView = UIImageView(frame: CGRectMake(x, y, width, height))
        image.image = UIImage(named: filepath);
        
        curView.addSubview(image);
        
        
        return image;
    }
    
    func addUIView(curView:UIView, x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, backgroundRed: CGFloat = 0.0, backgroundGreen: CGFloat = 0.0, backgroundBlue: CGFloat = 0.0, transparency: CGFloat = 0.0, borderRed: CGFloat = 0.0, borderGreen: CGFloat = 0.0, borderBlue: CGFloat = 0.0, borderTransparency:CGFloat = 0.0, borderWidth: CGFloat = 1.0, rounded: CGFloat = 0.0) -> UIView {
        
        let view: UIView = UIView(frame: CGRectMake(x, y, width, height))
        
        view.backgroundColor = UIColor(red: (backgroundRed / 255.0), green: (backgroundGreen / 255.0), blue: (backgroundBlue / 255.0), alpha: (transparency / 255.0))
        
        view.layer.borderWidth = borderWidth
        view.layer.borderColor = UIColor(red: (borderRed / 255.0), green: (borderGreen / 255.0), blue: (borderBlue / 255.0), alpha: (borderTransparency / 255.0)).CGColor
        
        view.layer.cornerRadius = rounded
        
        curView.addSubview(view)
        
        return view
    }
    
    
    
    func addUITextField(curView:UIView, x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, placeholderText: String = "", centered: Bool = false, isEmail: Bool = false, isNum: Bool = false, isPass: Bool = false) -> UITextField {
        let textField: UITextField = UITextField(frame: CGRectMake(x, y, width, height))
        
        textField.placeholder = placeholderText
        
        textField.keyboardAppearance = .Dark
        
        if(centered) {
            textField.textAlignment = .Center
        }
        
        if(isNum) {
            textField.keyboardType = .NumberPad
        }
        
        if(isEmail) {
            textField.keyboardType = .EmailAddress
        }
        
        textField.secureTextEntry = isPass
        
        
        curView.addSubview(textField)
        
        return textField
    }

    
    func segueToNewViewController(controllerIdentifier: String, sender: AnyObject) {
        self.performSegueWithIdentifier(controllerIdentifier, sender: sender)
    }
    
    func addUILabel(curView:UIView, x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, labelText: String = "", attribLabelText: NSMutableAttributedString? = nil, red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, centered:Bool = true, fontSize: CGFloat = kDefaultFontSize) -> UILabel {
        
        let label:UILabel = UILabel(frame: CGRectMake(x, y, width, height))
        
        label.textColor = UIColor(red: (red / 255.0), green: (green / 255.0), blue: (blue / 255.0), alpha: 1.0)
        
        if(attribLabelText != nil) {
            label.attributedText = attribLabelText
        } else {
            label.text = labelText
        }
        label.font = UIFont(name: (label.font?.fontName)!, size: fontSize)
        
        if(centered) {
            label.textAlignment = NSTextAlignment.Center
        }
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.ByWordWrapping
        
        curView.addSubview(label)
        
        return label
    }
    
    func addTimeToNextWeeklyWinner(curView:UIView, x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, red: CGFloat, green: CGFloat, blue: CGFloat) {
        
        getTimeInSecondsToNextWeeklyWinner() {
            time in dispatch_async(dispatch_get_main_queue()) {
                self.addUILabel(curView, x: x, y: y, width: width, height: 25, labelText: "NEXT WEEKLY WINNER", red: red, green: green, blue: blue, fontSize: 20)
                var timeInt: Int = (time?.integerValue)!
                var days: Int = 0
                var hours: Int = 0
                var minutes: Int = 0
                var seconds: Int = 0
                days = timeInt / 86400
                timeInt -= days * 86400
                hours = timeInt / 3600
                timeInt -= hours * 3600
                minutes = timeInt / 60
                timeInt -= minutes * 60
                seconds = timeInt
                self.daysLabel = self.addUILabel(curView, x: x, y: y + 50, width: 75, height: 25, labelText: String(days), red: 230.0, green: 201.0, blue: 37.0, fontSize: 30)
                self.hoursLabel = self.addUILabel(curView, x: x + 100, y: y + 50, width: 75, height: 25, labelText: String(hours), red: 230.0, green: 201.0, blue: 37.0, fontSize: 30)
                self.minutesLabel = self.addUILabel(curView, x: x + 200, y: y + 50, width: 75, height: 25, labelText: String(minutes), red: 230.0, green: 201.0, blue: 37.0, fontSize: 30)
                self.secondsLabel = self.addUILabel(curView, x: x + 300, y: y + 50, width: 75, height: 25, labelText: String(seconds), red: 230.0, green: 201.0, blue: 37.0, fontSize: 30)
                
                self.addUILabel(curView, x: x, y: y + 80, width: 75, height: 25, labelText: "DAYS", red: 230.0, green: 201.0, blue: 37.0, fontSize: 12)
                self.addUILabel(curView, x: x + 100, y: y + 80, width: 75, height: 25, labelText: "HOURS", red: 230.0, green: 201.0, blue: 37.0, fontSize: 12)
                self.addUILabel(curView, x: x + 200, y: y + 80, width: 75, height: 25, labelText: "MINUTES", red: 230.0, green: 201.0, blue: 37.0, fontSize: 12)
                self.addUILabel(curView, x: x + 300, y: y + 80, width: 75, height: 25, labelText: "SECONDS", red: 230.0, green: 201.0, blue: 37.0, fontSize: 12)
                
                NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(SuperViewController.changeTimer), userInfo: nil, repeats: true)
            }
        }

    }
    
    func changeTimer() {
        var days = (daysLabel.text! as NSString).integerValue
        var hours = (hoursLabel.text! as NSString).intValue
        var minutes = (minutesLabel.text! as NSString).intValue
        var seconds = (secondsLabel.text! as NSString).intValue
        
        seconds -= 1;
        if(seconds < 0) {
            seconds = 59
            minutes -= 1
        }
        if(minutes < 0) {
            minutes = 59
            hours -= 1
        }
        if(hours < 0) {
            hours = 23
            days -= 1
        }
        
        daysLabel?.text = String(days)
        hoursLabel?.text = String(hours)
        minutesLabel?.text = String(minutes)
        secondsLabel?.text = String(seconds)
    }
    
    func getTimeInSecondsToNextWeeklyWinner(completion: ((NSString: NSString?) -> Void)) {
        let url = NSURL(string: kURLTimeToNextWeeklyWinner)
        let request = NSMutableURLRequest(URL: url!)
        let session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            guard error == nil else {
                dispatch_async(dispatch_get_main_queue(), {
                    let alert = UIAlertController(title: "Unable to complete server connection", message: "Try checking your internet connection, and trying again.", preferredStyle: .Alert)
                    alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                })
                return
            }
            completion(NSString: NSString(data: data!, encoding: NSUTF8StringEncoding))
        })
        
        task.resume()
    }
}