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
public protocol WMMultiPickerDelegate: AnyObject {
    func pickerDidSelectedAtIndexes(_ indexes: [Int], textfield: WMPickerTextField)
}
public class WMPickerTextField: WMTextField {
    public  var options =  [String]()
    public  var selectedIndex = 0
    public  var selectedOption = ""
   public weak var pickerDelegate: WMPickerTextFieldDelegate?
    //For Multi selection
    public var popupType: PopupType = .singleIndexSelection
    public var multiSelectedIndexes = [Int]()
    public weak var multiPickerDelegate: WMMultiPickerDelegate?
    
    //MARK: - Init
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
        if popupType == .singleIndexSelection {
            showSingleSelectionPopup()
        } else if popupType == .multiSelection {
            showMultiSelectionPopup()
        }
        
        return false
    }
    private func showSingleSelectionPopup() {
        self.textField.showSingleValueSelectionPopup(options,
                                                     selectedIndex: selectedIndex,
                                                     popupMode: .singleIndexSelection,
                                                     didSelect: { (index, value) in
                                                        self.setSelectedData(index, value: value)
        }, isFullscreen: false, setTitle: "Select Option")
    }
    private func showMultiSelectionPopup() {
        textField.showMultiSelectionPopup(options,
                                          selectedValues: multiSelectedIndexes,
                                          popupMode: .multiSelection) { (arrIndex)  in
            self.setMultiSelectData(arrIndex)
        }
    }
    private func setSelectedData(_ index: Int, value: String) {
        textField.text = value
        selectedIndex = index
        pickerDelegate?.pickerDidSelectedAtIndex(index,
                                                      textfield: self)
    }
    private func setMultiSelectData(_ indexes: [Int]) {
        multiSelectedIndexes = indexes
        if multiSelectedIndexes.count >= 1 {
            let firstindex = multiSelectedIndexes[0]
            let first = options[firstindex]
            let other = multiSelectedIndexes.count - 1
            if multiSelectedIndexes.count == 1{
                textField.text = first
            } else {
                textField.text = "\(first) + \(other) more"
            }
        }
        multiPickerDelegate?.pickerDidSelectedAtIndexes(multiSelectedIndexes, textfield: self)
    }
}
