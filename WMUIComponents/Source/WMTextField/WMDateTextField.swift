//
//  KLDateTextField.swift
//  KinderLink
//
//  Created by Wasim on 02/08/22.
//  Copyright © 2022 wasim malek. All rights reserved.
//

import UIKit
public protocol WMDateTextFieldDelegate: AnyObject {
    func dateDidSelected(_ textfield: WMDateTextField, date: Date)
}
public class WMDateTextField: WMTextField {
    var maximumDate:Date? {
        didSet {
            textField.maximumDate = maximumDate
        }
    }
    var minimumDate:Date? {
        didSet {
            textField.minimumDate = minimumDate
        }
    }
    weak var dateDelegate: WMDateTextFieldDelegate?
    var dateFormat = DateFormat.date_mmddyyy.format
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
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        var currentDate:Date = Date()
            if((self.text.count ) > 0){
                currentDate = self.text.dateFromStringDate(self.dateFormat)
            }

            self.textField.showDatePickerView(.date,
                                              minuteInterval: 1 ,
                                              currentDate: currentDate,
                                              didSelect: { (strdate:String,date:Date) in

                    self.setText(strdate)
                self.dateDelegate?.dateDidSelected(self, date: date)

            })
        return false
    }
}
