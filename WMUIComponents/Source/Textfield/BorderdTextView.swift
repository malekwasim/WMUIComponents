

import UIKit

class BorderdTextView: UITextView,UITextViewDelegate {
    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 5);
    @IBInspectable var borderColor:UIColor = .platinum
    let defaultColor = UIColor.platinum
    @IBInspectable var activeBgColor:UIColor = UIColor.white
    override func draw(_ rect: CGRect) {
        addBorder(width: 1, radius: 5, color: .platinum)
        self.backgroundColor = activeBgColor
    }
    fileprivate func newBounds(_ bounds: CGRect) -> CGRect {
        
        var newBounds = bounds
        newBounds.origin.x += padding.left
        newBounds.origin.y += padding.top
        newBounds.size.height -= padding.top + padding.bottom
        newBounds.size.width -= padding.left + padding.right
        return newBounds
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.backgroundColor = activeBgColor
    }
    
    func isEmpty(_ retVal:Bool) -> Bool {
        
        if (self.text?.isEmpty)! {
            self.showErrorBorder()
            return false
        } else {
            self.hideErrorBorder()
            return retVal
        }
    }
    
    func showError() {
        borderColor = UIColor.red
        self.layer.borderColor = borderColor.cgColor
    }
    
    func hideError() {

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
