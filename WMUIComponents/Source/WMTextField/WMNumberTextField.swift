//
//  KLNumberTextField.swift
 
//
//  Created by Wasim on 18/08/22.
//  Copyright © 2022 Wasim. All rights reserved.
//

import UIKit
public class WMNumberTextField: WMTextField {
   public var maxDigit = 0
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
        textField.delegate = self
    }
    
}
extension WMNumberTextField: UITextFieldDelegate {
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let str = (textField.text ?? "") as NSString
        let result = str.replacingCharacters(in: range, with: string)
        let numbersOnly = NSCharacterSet.init(charactersIn: "0123456789")
        let textFieldChars = NSCharacterSet.init(charactersIn: result)
        
        if !numbersOnly.isSuperset(of: textFieldChars as CharacterSet) {
            return false
        }
        textField.text = result.formatString([maxDigit], seprator: "")
        return false
    }
}

