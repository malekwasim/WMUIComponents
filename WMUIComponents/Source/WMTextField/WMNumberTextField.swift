//
//  KLNumberTextField.swift
 
//
//  Created by Wasim on 18/08/22.
//  Copyright © 2022 Wasim. All rights reserved.
//

import UIKit
public class WMNumberTextField: WMTextField {
    var maxDigit = 0
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        setupPhoneTextField()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
        setupPhoneTextField()
    }
    
    private func setupPhoneTextField() {
        self.textfieldType = .number
        setTextPadtype()
//        self.textField.shouldChangeCharactersInRangeBlock = { (textField:UITextField?, range:NSRange, string:String?) -> Bool in
//            let str = (textField?.text ?? "") as NSString
//            let result = str.replacingCharacters(in: range, with: string!)
//            let numbersOnly = NSCharacterSet.init(charactersIn: "0123456789")
//            let textFieldChars = NSCharacterSet.init(charactersIn: result)
//            
//            if !numbersOnly.isSuperset(of: textFieldChars as CharacterSet) {
//                return false
//            }
//            textField?.text = result.formatString([self.maxDigit], seprator: "")
//            return false
//        }
    }
    
}

