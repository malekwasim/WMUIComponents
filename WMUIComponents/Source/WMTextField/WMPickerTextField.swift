//
//  KLPickerTextField.swift
 
//
//  Created by Apple on 16/09/22.
//  Copyright © 2022 Wasim. All rights reserved.
//

import UIKit
public protocol WMPickerTextFieldDelegate: AnyObject {
    func pickerDidSelectedAtIndex(_ index: Int, textfield: WMPickerTextField)
}
public class WMPickerTextField: WMTextField {
    public  var options =  [String]()
    public  var selectedIndex = 0
    public  var selectedOption = ""
   public weak var pickerDelegate: WMPickerTextFieldDelegate?
    
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
        textField.delegate = self
    }

}
extension WMPickerTextField: UITextFieldDelegate {
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.textField.showSingleValueSelectionPopup(options,
                                                     selectedIndex: selectedIndex,
                                                     popupMode: .singleIndexSelection,
                                                     didSelect: { (index, value) in
            
                                                        self.setSelectedData(index, value: value)
        }, isFullscreen: false, setTitle: "Select Option")
        return false
    }
    private func setSelectedData(_ index: Int, value: String) {
        self.textField.text = value
        self.selectedIndex = index
        self.pickerDelegate?.pickerDidSelectedAtIndex(index,
                                                      textfield: self)
    }
}
