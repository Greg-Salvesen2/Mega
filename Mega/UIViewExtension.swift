//
//  UIViewExtension.swift
//  Mega
//
//  Created by Greg Salvesen on 3/17/16.
//  Copyright © 2016 Mega. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func addBackground(filename: String) {
        // screen width and height:
        let width = UIScreen.mainScreen().bounds.size.width
        let height = UIScreen.mainScreen().bounds.size.height
        
        let imageViewBackground = UIImageView(frame: CGRectMake(0, 0, width, height))
        imageViewBackground.image = UIImage(named: filename)
        
        // you can change the content mode:
        imageViewBackground.contentMode = UIViewContentMode.ScaleAspectFill
        
        self.addSubview(imageViewBackground)
        self.sendSubviewToBack(imageViewBackground)
    }
}