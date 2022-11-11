//
//  KLYearTextField.swift
 
//
//  Created by Apple on 03/09/22.
//  Copyright © 2022 Wasim. All rights reserved.
//

import UIKit

public class WMYearTextField: WMTextField {
    var years =  [String]()
    var selectedIndex: Int?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTextField()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupTextField()
    }
    private func setupTextField() {
        setRightView(UIImage(named: "ic_arrow_drop_down"))

        var formattedDate: String? = ""

        let format = DateFormatter()
        format.dateFormat = DateFormat.year.format
        formattedDate = format.string(from: Date())

        for i in (Int(formattedDate!)!-50..<Int(formattedDate!)!+1).reversed() {
            years.append("\(i)")
        }
        textField.delegate = self
    }
}

extension WMYearTextField: UITextFieldDelegate {
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.textField.showSingleValueSelectionPopup(self.years,
                                                     selectedIndex: selectedIndex,
                                                     popupMode: .singleIndexSelection,
                                                     didSelect: { (index, value) in
            self.textField.text = value
            self.selectedIndex = index
        }, isFullscreen: false, setTitle: "Select Year")
        return false
    }
}
