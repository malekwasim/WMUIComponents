//
//  KLPhoneTextField.swift
//  KinderLink
//
//  Created by Wasim on 01/08/22.
//  Copyright © 2022 Diptesh Patel. All rights reserved.
//

import UIKit
public class WMPhoneTextField: WMTextField {
    var isSSN = false
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        setupPhoneTextField()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.textfieldType = .phone
        commonInit()
        setupPhoneTextField()
    }
    
    private func setupPhoneTextField() {
        setTextPadtype()
        textField.delegate = self
    }
    @IBAction override func textfieldEnd() {
        delegate?.textfieldDidEnd(self)
    }
    @IBAction override func textfieldChanged() {
        delegate?.textfieldDidChange(self)
    }
    
}
extension WMPhoneTextField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let str = (textField.text ?? "") as NSString
        var result = str.replacingCharacters(in: range, with: string)
        
        result = result.replacingOccurrences(of: "-", with: "")
        
        let numbersOnly = NSCharacterSet.init(charactersIn: "0123456789")
        let textFieldChars = NSCharacterSet.init(charactersIn: result)
        
        if !numbersOnly.isSuperset(of: textFieldChars as CharacterSet) {
            return false
        }
        if self.isSSN {
            textField.text = result.formatString([3,2,4], seprator: "-")
        } else {
            textField.text = result.formatString([3,3,4], seprator: "-")
        }
        self.delegate?.textfieldDidChange(self)
        return false
    }
}