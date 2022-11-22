//
//  KLDateTextField.swift
 
//
//  Created by Wasim on 02/08/22.
//  Copyright © 2022 wasim malek. All rights reserved.
//

import UIKit
public protocol WMDateTextFieldDelegate: AnyObject {
    func dateDidSelected(_ textfield: WMDateTextField, date: Date)
}
public class WMDateTextField: WMTextField {
    public var maximumDate:Date? {
        didSet {
            textField.maximumDate = maximumDate
        }
    }
    public var minimumDate:Date? {
        didSet {
            textField.minimumDate = minimumDate
        }
    }
    public var datePickerMode = UIDatePicker.Mode.date
    public weak var dateDelegate: WMDateTextFieldDelegate?
    public var dateFormat = DateFormat.date_mmddyyy.format
    public var timeInterval = 1
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTextField()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupTextField()
    }
    private func setupTextField() {
        textField.delegate = self
        setRightView(UIImage(named: "ic_arrow_drop_down"))
    }
    
}

extension WMDateTextField: UITextFieldDelegate {
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        var currentDate:Date = Date()
            if((self.text.count ) > 0){
                currentDate = self.text.dateFromStringDate(self.dateFormat)
            }

            self.textField.showDatePickerView(datePickerMode,
                                              minuteInterval: timeInterval ,
                                              currentDate: currentDate,
                                              didSelect: { (strdate:String,date:Date) in

                    self.setText(strdate)
                self.dateDelegate?.dateDidSelected(self, date: date)

            })
        return false
    }
}
