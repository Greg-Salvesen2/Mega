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
    
    func addUIImage(curView: UIView, x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, filepath: String)-> UIImageView {
        
        let image: UIImageView = UIImageView(frame: CGRectMake(x, y, width, height))
        image.image = UIImage(named: filepath);
        
        curView.addSubview(image);
        
        
        return image;
    }
    
    func addUIView(curView:UIView, x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, backgroundRed: CGFloat, backgroundGreen: CGFloat, backgroundBlue: CGFloat, transparency: CGFloat, roundedWidth: CGFloat, roundedHeight: CGFloat) -> UIView {
        
        let view: UIView = UIView(frame: CGRectMake(x, y, width, height))
        
        view.backgroundColor = UIColor(red: (backgroundRed / 255.0), green: (backgroundGreen / 255.0), blue: (backgroundBlue / 255.0), alpha: (transparency / 255.0))
        
        let maskPath = UIBezierPath(roundedRect: view.bounds,byRoundingCorners: .AllCorners, cornerRadii: CGSize(width: roundedWidth, height: roundedHeight))
        let maskLayer = CAShapeLayer(layer: maskPath)
        maskLayer.frame = view.bounds
        maskLayer.path = maskPath.CGPath
        view.layer.mask = maskLayer
        
        curView.addSubview(view)
        
        return view
    }
    
    func addUILabel(curView:UIView, x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, labelText: String, red: CGFloat, green: CGFloat, blue: CGFloat, centered:Bool) -> UILabel {
        
        let label:UILabel = UILabel(frame: CGRectMake(x, y, width, height))
        
        label.textColor = UIColor(red: (red / 255.0), green: (green / 255.0), blue: (blue / 255.0), alpha: 1.0)
        
        label.text = labelText
        
        if(centered) {
            label.textAlignment = NSTextAlignment.Center
        }
        
        curView.addSubview(label)
        
        
        
        return label
    }
    
}