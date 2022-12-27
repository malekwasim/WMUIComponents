

import UIKit

typealias didSelectedDate = (_ strdate:String,_ date:Date) -> Void
typealias didMultiSelectPoupItem = (_ indexes:[Int]) -> Void
typealias didIndexSelectPoupItem = (_ index:Int, _ value: String) -> Void
typealias didIndexSortPoupItem = (_ index:Int, _ value: String, _ isAscending: Bool) -> Void

let KEY_DATE_PICKER         = "DatePicker"

public class BorderdTextField: UITextField,UITextFieldDelegate {
    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10);
    
    @IBInspectable var borderColor:UIColor = .platinum
    @IBInspectable var activeBgColor:UIColor = UIColor.white
    
    public let defaultColor = UIColor.platinum
    public var minimumDate : Date? = nil
    public var maximumDate : Date? = nil
   public var startTime : Date? = nil
    public var endTime : Date? = nil
    var storyBoard:UIStoryboard?
    var popupTableView:PopOverViewController?
    var popupDate:PopOverViewController?
    var popupSorted:PopOverViewController?
    var baseVC:UIViewController?
    
    public override func draw(_ rect: CGRect) {
        self.addBorder(width: 1, radius: 5, color: borderColor)
        storyBoard = UIStoryboard.init(name: "Popup", bundle: Utility.bundle())
        popupTableView = storyBoard?.instantiateViewController(withIdentifier: "PopOverViewController_WithTableView") as? PopOverViewController
        
        popupDate = storyBoard?.instantiateViewController(withIdentifier: "PopOverViewController_WithDatePicker") as? PopOverViewController
        
        popupSorted = storyBoard?.instantiateViewController(withIdentifier: "PopOverViewController_WithSortOptions") as? PopOverViewController
        
        
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
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
    
    public func showErrorBorder() {
        borderColor = UIColor.red
        self.layer.borderColor = borderColor.cgColor
    }
    
    public func hideErrorBorder() {
        borderColor = defaultColor
        self.layer.borderColor = borderColor.cgColor
    }
    
    
    public override func textRect(forBounds bounds: CGRect) -> CGRect {
        return self.newBounds(bounds)
    }
    
    public override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return self.newBounds(bounds)
    }
    
    public override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return self.newBounds(bounds)
    }
    
    fileprivate func newBounds(_ bounds: CGRect) -> CGRect {
        var newBounds = bounds
        newBounds.origin.x += padding.left
        newBounds.origin.y += padding.top
        newBounds.size.height -= padding.top + padding.bottom
        newBounds.size.width -= padding.left + padding.right
        return newBounds
    }
    
    func showMultiSelectionPopup(_ values:[String],
                                 selectedValues:[Int],
                                 popupMode: PopupType,
                                 didSelect:@escaping didMultiSelectPoupItem,
                                 setTitle: String? = "Select from options") {
        if storyBoard == nil {
            storyBoard = UIStoryboard.init(name: "Popup", bundle: Utility.bundle())
        }
        popupTableView = storyBoard?.instantiateViewController(withIdentifier: "PopOverViewController_WithTableView") as? PopOverViewController

        popupTableView?.showMultiSelectionPopup(values,
                                                selectedValues: selectedValues,
                                                popupMode:popupMode,
                                                callBack: didSelect,
                                                setTitle: setTitle!)
        
        let popover = setupPopupPresentation(popupTableView)
        
        let width: CGFloat = self.frame.size.width > 300 ? 100 : self.frame.size.width
        
        popover?.sourceRect = CGRect.init(x: 0, y: 0, width: width, height: self.frame.size.height)
        
        showPopup(popupTableView)
    }
    
    func showDatePickerView(_ pickerMode:UIDatePicker.Mode,
                            minuteInterval : Int,
                            currentDate:Date,
                            didSelect:@escaping didSelectedDate,
                            skipWeekends: Bool? = false,
                            minimumdatelead:Date? = nil){
        
        if popupDate == nil {
            storyBoard = UIStoryboard.init(name: "Popup", bundle: Utility.bundle())
            popupDate = (storyBoard?.instantiateViewController(withIdentifier: "PopOverViewController_WithDatePicker") as! PopOverViewController)
        }
        if minimumDate != nil {
            popupDate?.minimumDate = minimumDate
        }
        if minimumdatelead != nil {
            popupDate?.minimumDate = minimumdatelead
        }
        if maximumDate != nil {
            popupDate?.maximumDate = maximumDate
        }
        
        popupDate?.showDatePickerPopup(pickerMode,
                                       minuteInterval: minuteInterval,
                                       currentDate:currentDate,
                                       popupMode: .datePicker,
                                       callBack: didSelect,
                                       skipWeekEnds: skipWeekends)
        setupPopupPresentation(popupDate)
        showPopup(popupDate)
    }
    
    func showSingleValueSelectionPopup(_ values:[String],
                                       selectedIndex:Int?,
                                       popupMode: PopupType,
                                       didSelect:@escaping didIndexSelectPoupItem,
                                       isFullscreen: Bool = false,
                                       setTitle: String? = "Select from options") {
        if popupTableView == nil {
            popupTableView = storyBoard?.instantiateViewController(withIdentifier: "PopOverViewController_WithTableView") as? PopOverViewController
        }
        popupTableView?.showSingleSelectionPopup(values,
                                                 selectedIndex: selectedIndex,
                                                 popupMode:popupMode,
                                                 callBack: didSelect,
                                                 setTitle: setTitle!)
        
        let popover = setupPopupPresentation(popupTableView)
        
        if isFullscreen {
            popover?.sourceRect = CGRect.init(x: 0, y: 0, width: (self.frame.size.width), height: self.frame.size.height)
            popupTableView?.preferredContentSize = CGSize(width: 600, height: 400)/// For attendance lesson plan size increased
            popupTableView?.isFullScreen = true
        } else {
            let width: CGFloat = self.frame.size.width > 300 ? 100 : self.frame.size.width
            popover?.sourceRect = CGRect.init(x: 0, y: 0, width: width , height: self.frame.size.height)
            popupTableView?.isFullScreen = false
        }
        showPopup(popupTableView)
    }
    
    func showSortValueSelectionPopup(_ values:[String], selectedIndex:Int,popupMode: PopupType, isAscending : Bool, didSelect:@escaping didIndexSortPoupItem) {
        popupSorted = storyBoard?.instantiateViewController(withIdentifier: "PopOverViewController_WithSortOptions") as? PopOverViewController
        popupSorted?.isAscending = isAscending
        if selectedIndex != -1 {
            popupSorted?.arrSelectedIndex.append(selectedIndex)
            popupSorted?.singleSelectedIndex = selectedIndex
        }
        popupSorted?.showSortSelectionPopup(values,
                                            selectedIndex: selectedIndex,
                                            popupMode: popupMode,
                                            isAscending: isAscending,
                                            callBack: didSelect)
        
        setupPopupPresentation(popupSorted)
        showPopup(popupSorted)
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        self.backgroundColor = activeBgColor
    }
    @discardableResult
    private func setupPopupPresentation(_ popupOver: PopOverViewController?) -> UIPopoverPresentationController? {
        guard let popup = popupOver else {
            return nil
        }
        popup.modalPresentationStyle = UIModalPresentationStyle.popover
        let popover: UIPopoverPresentationController = popup.popoverPresentationController!
        popover.sourceView = self
        popover.permittedArrowDirections = .any
        popover.sourceRect = CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        return popover
    }
    private func showPopup(_ popupOver: PopOverViewController?) {
        DispatchQueue.main.async(execute: {
            if let base = self.baseVC, let popup = popupOver {
                base.present(popup, animated: true, completion: nil)
            }
        })
        
    }
    
}
