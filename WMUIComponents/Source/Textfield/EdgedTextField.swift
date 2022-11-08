//
//  EdgedTextField.swift
//  KinderKastle
//
//  Created by Diptesh Patel on 17/12/15.
//  Copyright © 2015 Jigar Shah. All rights reserved.
//

import UIKit

class EdgedTextFiled: UITextField {
    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 5);

    override func draw(_ rect: CGRect) {
        let border = CALayer()
        let width = CGFloat(2.0)
        border.borderColor =  UIColor.platinum.cgColor
        border.frame = CGRect(x: 0,
                              y: self.frame.size.height - width,
                              width:  self.frame.size.width,
                              height: self.frame.size.height)
        
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return self.newBounds(bounds)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return self.newBounds(bounds)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return self.newBounds(bounds)
    }
    
    fileprivate func newBounds(_ bounds: CGRect) -> CGRect {
        
        var newBounds = bounds
        newBounds.origin.x += padding.left
        newBounds.origin.y += padding.top
        newBounds.size.height -= padding.top + padding.bottom
        newBounds.size.width -= padding.left + padding.right
        return newBounds
    }
}
