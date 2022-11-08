//
//  BorderdPickerTextField.swift
//  KinderKastle
//
//  Created by tejasmacmini on 27/09/16.
//  Copyright © 2016 KinderKastle. All rights reserved.
//

import UIKit

class BorderdDatePickerTextField : DatePickerTextField {
    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 5);
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.addBorder(width: 1, radius: 5, color: .platinum)
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
