//
//  UIView.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 11/5/15.
//  Copyright © 2015 Yuji Hato. All rights reserved.
//

import UIKit

extension UIView {
    class func loadNib<T: UIView>(_ viewType: T.Type) -> T {
        let className = String.className(viewType)
        return Bundle(for: viewType).loadNibNamed(className, owner: nil, options: nil)!.first as! T
    }
    
    class func loadNib() -> Self {
        return loadNib(self)
    }
    
    //Wasim added
    func addBorder(width : CGFloat, radius : CGFloat, color: UIColor? = nil){
        layer.borderWidth = width
        layer.masksToBounds = false
        if let value = color {
            layer.borderColor = value.cgColor
        }
        layer.cornerRadius = radius
        clipsToBounds = true
    }
    
    func round() {
        layer.cornerRadius = self.bounds.height/2
    }
}
