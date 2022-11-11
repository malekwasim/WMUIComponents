

import UIKit

protocol PickerSelectDelegate {
    func didSelectPickerOption(_ selection:String, atIndex:Int)
}


class PickerTextField: UITextField, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10);
    var pickerValues: [String] = [String]()
    var pickerDelegate: PickerSelectDelegate?
    
    var pickerView : UIPickerView?
    var oldValue : NSString?
    var currentRow : NSInteger?
    var isCurrentEmployee : Bool?
    
    @IBInspectable var borderColor:UIColor = .platinum
    let defaultColor = UIColor.platinum
    
    override func draw(_ rect : CGRect) {
        self.addBorder(width: 1, radius: 5, color: borderColor)
        self.layer.masksToBounds = true
        self.delegate = self
        pickerView = UIPickerView.init()
        pickerView?.delegate = self
        pickerView?.dataSource = self
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
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return self.newBounds(bounds)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return self.newBounds(bounds)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return self.newBounds(bounds)
    }
    
    fileprivate func newBounds(_ bounds: CGRect) -> CGRect {
        //        return bounds
        var newBounds = bounds
        newBounds.origin.x += padding.left
        newBounds.origin.y += padding.top
        newBounds.size.height -= padding.top + padding.bottom
        newBounds.size.width -= padding.left + padding.right
        return newBounds
    }
    
    @objc func cancelButtonTapped(button:UIBarButtonItem) -> Void {
        // do you stuff with done here
        self.endEditing(true)
    }
    
    @objc func doneButtonTapped(button:UIBarButtonItem) -> Void {
        // do you stuff with done here
        if currentRow == nil && pickerValues.count != 0 {
            self.text = pickerValues.first
        } else {
            let selectedRow:Int = currentRow!
            self.text = pickerValues[selectedRow]
            pickerDelegate?.didSelectPickerOption(self.text!, atIndex: selectedRow)
        }
        self.endEditing(true)
    }
    override func canPerformAction(_ action : Selector, withSender sender : Any?)->Bool {
        if (action == Selector(("_paste:")) || action == Selector(("_cut:")) || action == Selector(("_promptForReplace:"))) {
            return false
        }
        return super.canPerformAction(action, withSender: sender)
    }
    
    //MARK: PickerView
    func numberOfComponents(in pickerView : UIPickerView)->Int
    {
        return 1;
    }
    
    func pickerView(_ pickerView : UIPickerView, numberOfRowsInComponent component : Int)->Int
    {
        if (pickerValues.count == 0) {
            self.resignFirstResponder()
        }
        return (pickerValues.count);
    }
    
    func pickerView(_ pickerView : UIPickerView, titleForRow row : Int, forComponent component : Int)->String? {
        
        return pickerValues[row]
    }
    
    func pickerView(_ pickerView : UIPickerView, didSelectRow row : Int, inComponent component : Int) {
        currentRow = row
    }
}

extension PickerTextField : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if isCurrentEmployee == true {
            
            self.inputView = pickerView
            let bar = UIToolbar()
            let cancel = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.cancel,  target: self, action: #selector(cancelButtonTapped))
            let space = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
            
            let done = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(doneButtonTapped))
            
            
            bar.items = [cancel,space,done]
            bar.sizeToFit()
            self.inputAccessoryView = bar
        } else {
            
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.inputView = nil
        self.inputAccessoryView = nil
    }
}
