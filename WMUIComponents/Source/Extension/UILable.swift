//
//  UILable.swift
//  KLUIComponents
//
//  Created by Wasim on 23/10/22.
//

import UIKit

extension UILabel {
    //MARK: Make Last character of String Red for Required Fiels
    func markLabelTextAsRequiredWithString(_ string: String) -> NSMutableAttributedString{
        let myMutableString = NSMutableAttributedString(string: string, attributes: [NSAttributedString.Key.font:self.font ?? UIFont.systemFont(ofSize: 17)])
        let stringLength = string.count
        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: NSRange(location:stringLength - 1,length:1))
        
        return myMutableString
    }
}
