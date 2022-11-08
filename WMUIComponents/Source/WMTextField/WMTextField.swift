//
//  KLTextField.swift
//  KinderLink
//
//  Created by Wasim on 30/04/20.
//  Copyright © 2020 Diptesh Patel. All rights reserved.
//

import UIKit


public enum WMTextFieldType {
    case text
    case phone
    case email
    case picker
    case date
    case ssn
    case number
}

public protocol WMTextFieldDelegate: AnyObject {
    func textfieldDidChange(_ textfield: WMTextField)
    func textfieldDidEnd(_ textfield: WMTextField)
}

@IBDesignable
public class WMTextField: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var textField: BorderdTextField!
    var textfieldType = WMTextFieldType.text
    weak var delegate: WMTextFieldDelegate?
    @IBInspectable var title: String = "" {
        didSet {
            setupTitle()
        }
    }
    @IBInspectable var isEnable: Bool = true {
        didSet {
            textField.isEnabled = isEnable
        }
    }
    @IBInspectable var isRequired:Bool = false {
        didSet {
            setRequiredLabel()
        }
    }
    var text: String {
           return textField.text ?? ""
       }
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("WMTextField", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.backgroundColor = self.backgroundColor
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        //textField.delegate = self
        lblTitle.adjustsFontSizeToFitWidth = true
    }
    func setEmailKeyboardType() {
        textField.keyboardType = .emailAddress
    }
    func setTextPadtype() {
        textField.keyboardType = .phonePad
    }
    
    func setupTitle() {
        lblTitle.text = title
        setRequiredLabel()
    }
    
    func setText(_ text:String?) {
        textField.text = text
    }
    
    func setRightView(_ image: UIImage?) {
        if let img = image {
            textField.rightView = UIImageView.init(image: img)
            textField.rightViewMode = UITextField.ViewMode.always
        }
       
    }
    
    func setRequiredLabel() {
        if isRequired == true {
            if var title = lblTitle.text, !title.isEmpty {
                if title.last != "*" {
                    title += "*"
                }
                lblTitle.attributedText = lblTitle.markLabelTextAsRequiredWithString(title)
            }
        }
    }
    
    func isValid() -> Bool {
        if self.text.count == 0 {
            textField.showErrorBorder()
            return false
        } else {
            textField.hideErrorBorder()
            return true
        }
    }
    
    func isEmail() -> Bool {
        if self.text.isEmail == false {
            textField.showErrorBorder()
            return false
        } else {
            textField.hideErrorBorder()
            return true
        }
    }
    
    func isPhone() -> Bool {
        if self.text.count < 12 {
            textField.showErrorBorder()
            return false
        } else {
            textField.hideErrorBorder()
            return true
        }
    }
    
    func getErrorMessage() -> String? {
        if isRequired == false {
            return nil
        }
        if textfieldType == .text && self.text.isEmpty {
            textField.showErrorBorder()
            return getEmptyMessage()
        }
        if textfieldType == .email {
            if self.text.isEmpty {
                textField.showErrorBorder()
                return getEmptyMessage()
            } else if self.text.isEmail == false {
                textField.showErrorBorder()
                return ErrorMessages.validEmailAddress.error
            }
        }
        if  textfieldType == .phone {
            if self.text.isEmpty {
                textField.showErrorBorder()
                return getEmptyMessage()
            } else if self.text.count != 12  {
                textField.showErrorBorder()
                return ErrorMessages.homePhoneNumber.error
            }
        }
        if  textfieldType == .ssn {
            if self.text.isEmpty {
                textField.showErrorBorder()
                return getEmptyMessage()
            } else if self.text.count != 11  {
                textField.showErrorBorder()
                return ErrorMessages.socialSecurity.error
            }
        }
        if  textfieldType == .number {
            if self.text.isEmpty {
                textField.showErrorBorder()
                return getEmptyMessage()
            }
        }
        if  textfieldType == .picker {
            if self.text.isEmpty {
                textField.showErrorBorder()
                return getEmptyMessage()
            }
        }
        
        return nil
    }
    private func getEmptyMessage() -> String {
        if var err = lblTitle.text {
            if err.last == "*" {
                err.removeLast()
            }
            return "\(err) can not be empty"
        }
        return ""
    }

    @IBAction func textfieldEnd() {
        delegate?.textfieldDidEnd(self)
    }
    @IBAction func textfieldChanged() {
        delegate?.textfieldDidChange(self)
    }
}

