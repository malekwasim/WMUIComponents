//
//  KLPickerTextField.swift
//  KinderLink
//
//  Created by Apple on 16/09/22.
//  Copyright © 2022 Wasim. All rights reserved.
//

import UIKit
protocol WMPickerTextFieldDelegate: AnyObject {
    func pickerDidSelectedAtIndex(_ index: Int, textfield: WMPickerTextField)
}
class WMPickerTextField: WMTextField {
    var options =  [String]()
    var selectedIndex = 0
    var selectedOption = ""
    weak var pickerDelegate: WMPickerTextFieldDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTextField()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupTextField()
    }
    private func setupTextField() {
        textfieldType = .picker
        setRightView(UIImage(named: "ic_arrow_drop_down"))
//        self.textField.shouldBegindEditingBlock = { (textField: UITextField?) -> Bool in
//
//            self.textField.showSingleValueSelectionPopup(self.options , selectedIndex: self.selectedIndex,
//                                                         popupMode:KEY_SINGLE_INDEX_SELECTION,
//                                                         didSelect: {
//                (index:Int , value: String) in
//                self.selectedIndex = index
//                self.selectedOption = self.options[index]
//                self.setText(self.selectedOption)
//                self.pickerDelegate?.pickerDidSelectedAtIndex(index, textfield: self)
//            },isFullscreen: false,setTitle: "")
//            return false
//        }
    }

}
