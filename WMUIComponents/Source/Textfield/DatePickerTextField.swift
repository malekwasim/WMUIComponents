

import Foundation

import UIKit

typealias datePickerToolbarHandler = (_ isDone:Bool,_ selectedDate:Date?,_ strDate:String?) -> Void


class DatePickerTextField: UITextField,
                            UITextFieldDelegate {
    @IBInspectable var borderColor:UIColor = .platinum
    @IBInspectable var activeBgColor:UIColor = UIColor.white
    
    let defaultColor = UIColor.platinum
    var pickerValues:NSArray?
    private var pickerView:UIDatePicker = UIDatePicker.init()
    var oldValue:NSString?
    var currentRow:NSInteger?
    var datePickerBlock:datePickerToolbarHandler!
    
    override func draw(_ rect: CGRect) {
        self.addBorder(width: 1, radius: 5, color: borderColor)
//        pickerView = UIDatePicker.init()
        pickerView.datePickerMode = UIDatePicker.Mode.date
        
//        pickerView!.addTarget(self,
//                              action: #selector(DatePickerTextField.changedAction),
//                              for: UIControlEvents.valueChanged)
    
        pickerView.maximumDate = Date.init()
//        if(self.text?.length == 0){
//            
//            let formatter:NSDateFormatter = NSDateFormatter.init()
//            formatter.dateFormat = DATE_FORMAT_API
//            
//            let dateStart:NSDate = NSDate()
//            formatter.timeZone = NSTimeZone.localTimeZone()
//            formatter.locale =  NSLocale(localeIdentifier: "en_US_POSIX")
//            formatter.dateFormat = DATE_FORMAT_DATE
        //            self.text = formatter.stringFromDate(dateStart)
        //        }
        if #available(iOS 14, *) {
            pickerView.preferredDatePickerStyle = .wheels
        }
        self.inputView = pickerView
        self.addToolBar(textField: self)
    }
    
    func addToolBar(textField: UITextField){
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.black
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(donePressed))
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(cancelPressed))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        
        textField.delegate = self
        textField.inputAccessoryView = toolBar
    }
    
    @objc func donePressed() {
        
        self.changedAction()
    }
    
    @objc func cancelPressed() {
        if (self.datePickerBlock != nil) {
            
            self.datePickerBlock(false, nil, nil)
        }
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {

        return super.canPerformAction(action, withSender: sender)
    }

    @objc func changedAction() {
        
        let formatter:DateFormatter = DateFormatter.init()
        formatter.dateFormat = DateFormat.api.format
        
        let dateStart:Date = (pickerView.date)
        formatter.timeZone = TimeZone.autoupdatingCurrent
        formatter.locale =  Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = DateFormat.date_mmddyyy.format
        let stringDate = formatter.string(from: dateStart)
        if (datePickerBlock != nil) {
            self.datePickerBlock(true,dateStart,stringDate)
        }
    }
    
    func isNotEmpty(_ retVal:Bool) -> Bool {
        
        if (self.text?.isEmpty)! {
            self.showErrorBorder()
            return false
        } else {
            self.hideErrorBorder()
            return retVal
        }
    }
    
    func showError() {
        if self.rightView != nil {
            self.showErrorBorder()
            return
        }
        let imageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 40, height: 30))
        imageView.image = #imageLiteral(resourceName: "error")
        imageView.contentMode = .left
        self.rightView = imageView
        self.rightViewMode = .always
        borderColor = UIColor.red
        self.layer.borderColor = borderColor.cgColor
    }
    
    func hideError() {
        self.rightView = nil
        self.rightViewMode = .never
        borderColor = defaultColor
        self.layer.borderColor = borderColor.cgColor
    }
    
    func showErrorBorder() {
        borderColor = UIColor.red
        self.layer.borderColor = borderColor.cgColor
    }
    
    func hideErrorBorder() {
        borderColor = defaultColor
        self.layer.borderColor = borderColor.cgColor
    }
}
