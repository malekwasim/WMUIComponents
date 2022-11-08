//
//  KLCurrencyTextField.swift
//  KinderLink
//
//  Created by Wasim on 02/08/22.
//  Copyright © 2022 wasim malek. All rights reserved.
//

import UIKit

class WMCurrencyTextField: WMTextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTextField()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupTextField()
    }
    private func setupTextField() {
        textField.keyboardType = .numberPad
        let prefix = UILabel()
        prefix.text = "$"
        prefix.font = UIFont.boldSystemFont(ofSize: 16)
        prefix.textColor = .gray
        prefix.sizeToFit()
        textField.leftView = prefix
        textField.leftViewMode = .always
    }
    
}
