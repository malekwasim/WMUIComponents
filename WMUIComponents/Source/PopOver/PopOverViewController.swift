
import UIKit

public enum PopupType {
    case datePicker
    case sortView
    case multiSelection
    case singleSelection
    case singleIndexSelection
}

class PopOverViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var btnDone: UIButton!
    @IBOutlet var navItem: UINavigationItem!
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var sortOption: UISegmentedControl!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var datePickerView: UIDatePicker!
    @IBOutlet var btnRetake: UIButton!
    @IBOutlet var btnDelete: UIButton!
    @IBOutlet var btnSelectAll: UIButton!
    
    //MARK - Properties
    var arrData:[String] = []
    var popupType: PopupType?
    var arrSearchedSelectedIndex = [Int]()
    var arrSelectedIndex:[Int] = [Int]()
    var arrSelectedData:[String] = [String]()
    var singleSelectedIndex: Int?
    var multiSelectcallBack:didMultiSelectPoupItem?
    var selectedDateCallBack:didSelectedDate?
    var singleSelectCallBack:didIndexSelectPoupItem?
    var sortSelectCallBack:didIndexSortPoupItem?
    var minimumDate : Date? = nil
    var maximumDate : Date? = nil
    var pickerMode:UIDatePicker.Mode = .date
    var currentDate:Date?
    var minuteInterval: Int = 0
    var skipWeekEnds: Bool = false
    var isAscending : Bool = true
    var titleIs: String = "Select from options"
    var isFullScreen = false
    var searching = false
    var searchedData = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    
    //MARK: setupView
    func setupView(){
        btnSelectAll.isHidden = true
        if(popupType == .datePicker) {
            datePickerView?.datePickerMode = pickerMode
            datePickerView?.minuteInterval = self.minuteInterval
            if datePickerView.datePickerMode == .time {
                navItem.title = "Select Time"
            } else {
                navItem.title = "Select Date"
                if self.skipWeekEnds == true { // This is to make sure that if user select Saturday Or Sunday then Make Saturday -> Friday and Sunday -> Monday
                    self.datePickerView.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
                }
            }
            
            if minimumDate != nil {
                self.datePickerView.minimumDate = minimumDate
            }
            
            if maximumDate != nil {
                self.datePickerView.maximumDate = maximumDate
            }
            if #available(iOS 14, *) {
                datePickerView.preferredDatePickerStyle = .wheels
            }
            if let date = currentDate {
                datePickerView.setDate(date, animated: true)
            }
            
        } else if popupType == .sortView {
            if isAscending == true {
                self.sortOption.selectedSegmentIndex = 0
            } else {
                self.sortOption.selectedSegmentIndex = 1
            }
            self.tableView.reloadData()
        } else if (popupType == .singleSelection) {
//            print("3_setTitle: \(titleIs)")
            navItem.title = titleIs
        } else if (popupType == .multiSelection) {
            btnSelectAll.isHidden = false
            btnSelectAll.setTitle("Select All", for: .normal)
            if isAllDataSelected() {
                btnSelectAll.setTitle("Remove All", for: .normal)
            }
            navItem.title = titleIs
        } else if popupType == .singleIndexSelection{
            navItem.title = titleIs
        } else {
            
        }
        if searchBar != nil {
            searchBar.delegate = self
            searchBar.showsCancelButton = true
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if(popupType == .sortView ||
            popupType == .singleSelection ||
            popupType == .multiSelection ||
            popupType == .singleIndexSelection) {
            self.tableView.reloadData()
        }
        
    }
    //MARK:- DatePicker Value Change Function called
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {// This is to make sure that if user select Saturday Or Sunday then Make Saturday -> Friday and Sunday -> Monday
        let calender: Calendar = Calendar(identifier: .gregorian)
        let weekday = calender.component(.weekday, from: sender.date)
        //sunday
        if weekday == 1 {
            self.datePickerView.setDate(Date(timeInterval: 60*60*24*1, since: sender.date), animated: true)
        } else if weekday == 7 { // Saturday
            self.datePickerView.setDate(Date(timeInterval: 60*60*24*(-1), since: sender.date), animated: true)
        }
    }
    
    //MARK: Show multi selection popup
    func showMultiSelectionPopup(_ arrData:[String],
                                 selectedValues:[Int],
                                 popupMode:PopupType,
                                 callBack: @escaping didMultiSelectPoupItem,
                                 setTitle: String? = "Select from options") {
        multiSelectcallBack = callBack
        
        titleIs = setTitle!
        self.arrData = []
        self.arrSelectedIndex.removeAll()
        
        self.arrData = arrData
        popupType = popupMode
        
        if arrData.count > 0 {
            if selectedValues.count > 0 {
                arrSelectedIndex = selectedValues
            }
        }
        
    }
    
    //MARK: Show date picker view
    func showDatePickerPopup(_ pickerMode:UIDatePicker.Mode,
                             minuteInterval : Int,
                             currentDate:Date,
                             popupMode:PopupType,
                             callBack: @escaping didSelectedDate,
                             skipWeekEnds: Bool? = false ) {

        self.minuteInterval = minuteInterval
        self.skipWeekEnds = skipWeekEnds!
        selectedDateCallBack = callBack
        popupType = popupMode
        self.currentDate = currentDate
        self.pickerMode = pickerMode
        if pickerMode == .time {
            
        }
    }
    //MARK: Show single selection popup
    func showSingleSelectionPopup(_ arrData:[String],
                                  selectedIndex:Int?,
                                  popupMode:PopupType,
                                  callBack: @escaping didIndexSelectPoupItem,
                                  setTitle:String? = "Select from options") {
        titleIs = setTitle!
        
        singleSelectCallBack = callBack
        self.arrData = arrData
        popupType = popupMode
        self.arrSelectedIndex.removeAll()
        if let index = selectedIndex {
            arrSelectedIndex.append(index)
            singleSelectedIndex = index
        }
    }
    
    //MARK: Show single selection popup
    func showSortSelectionPopup(_ arrData:[String],
                                selectedIndex:Int,
                                popupMode:PopupType,
                                isAscending : Bool,
                                callBack: @escaping didIndexSortPoupItem) {
        sortSelectCallBack = callBack
        self.arrData = arrData
        popupType = popupMode
        self.arrSelectedIndex.append(selectedIndex)
        self.isAscending = isAscending
    }
    
    
    // MARK: - Button Clicks
    @IBAction func btnDone_Tapped(_ sender: Any) {
        searching = false
        if(btnDelete != nil && btnRetake != nil){
            btnRetake.setTitle("Retake", for: .normal)
            btnDelete.setTitle("Delete", for: .normal)
        }
        if btnDone != nil {
            btnDone.setTitle("Done", for: .normal)
        }
        
        if(popupType == .multiSelection){
            setMultiSelectCallback()
            
        }else if(popupType == .datePicker){
            let formatter:DateFormatter = DateFormatter.init()
            let dateStart:Date = (datePickerView?.date)!
            formatter.timeZone = TimeZone.autoupdatingCurrent
            formatter.locale =  Locale(identifier: "en_US_POSIX")
            if(datePickerView.datePickerMode == .time){
                formatter.dateFormat = DateFormat.time_12hour.format
            }else{
                formatter.dateFormat = DateFormat.date_mmddyyy.format
            }
            selectedDateCallBack?(formatter.string(from: dateStart), dateStart)
        } else if popupType == .sortView {
            var selectedValue = ""
            if let index = singleSelectedIndex {
                let value = arrData[index]
                selectedValue = value
                sortSelectCallBack?(index,selectedValue, isAscending)
            }
            
        } else {
            if arrData.count > 0 {
                if let index = singleSelectedIndex {
                    tableView.selectRow(at: IndexPath.init(row: index, section: 0),
                                        animated: true,
                                        scrollPosition: .middle)
                    tableView.delegate?.tableView!(tableView,
                                                   didSelectRowAt: IndexPath.init(row: index, section: 0))
                } else {
                    print("Just close the pop Up")
                }
                
            }
        }
        
        self.dismiss(animated: true) { () -> Void in}
    }
    private func setMultiSelectCallback() {
        var arrValues : [String] = [String]()
        for strid in self.arrSelectedIndex{
            arrValues.append(self.arrData[strid] )
        }
        multiSelectcallBack?(arrSelectedIndex)
    }
    
    @IBAction func btnSelectAll_Tapped(_ sender: UIButton) {
        if isAllDataSelected() {
            //all data are selected then remove
            arrSelectedIndex.removeAll()
        } else {
            arrSelectedIndex.removeAll()
            for (index, _) in arrData.enumerated() {
                arrSelectedIndex.append(index)
            }
        }
        multiSelectcallBack?(arrSelectedIndex)
        dismiss(animated: true)
    }
    private func isAllDataSelected() -> Bool {
        return arrSelectedIndex.count == arrData.count
    }
    
    
    @IBAction func sortOptionsChangedForSort(_ sender: Any) {
        
        if self.sortOption.selectedSegmentIndex == 0 {
            self.isAscending = true
        } else {
            self.isAscending = false
        }
    }
}

extension PopOverViewController : UITableViewDelegate, UITableViewDataSource {
    // MARK: - TableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return searchedData.count
        }
        return arrData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIndentifier:String = "cellIdentifier"
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIndentifier)!
        
        var finalData = arrData
        if searching {
            finalData = searchedData
        }
       let stringValue = (finalData.count >  indexPath.row) ? finalData[indexPath.row]  : ""
        if isFullScreen == true {
            
            let fullActivity = stringValue.components(separatedBy: " - ")
            if fullActivity.count > 0 {
                let activityName = fullActivity[0]
                let string_to_changeFont = activityName
                let font = UIFont.boldSystemFont(ofSize: 22)
                
                let range = (stringValue as NSString).range(of: string_to_changeFont)
                let attributeString = NSMutableAttributedString.init(string: stringValue)
                attributeString.addAttribute(NSAttributedString.Key.font, value: font, range: range)
                cell.textLabel?.attributedText = attributeString
            }
            
        } else {
            cell.textLabel?.text = stringValue
        }
        cell.accessoryType = .none
        if(arrSelectedIndex.count != 0) {
             if(arrSelectedIndex.contains(indexPath.row) == true){
                cell.accessoryType = .checkmark
             }
        }
        
        if searching  {
            if arrSearchedSelectedIndex.contains(indexPath.row) {
                cell.accessoryType = .checkmark
            }
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let finalData = arrData
        var currentIndex = indexPath.row
        if searching {
            let selectedValue = searchedData[indexPath.row]
            if arrSearchedSelectedIndex.contains(indexPath.row) {
                if let index = arrSearchedSelectedIndex.firstIndex(of: indexPath.row) {
                    arrSearchedSelectedIndex.remove(at: index)
                }
            } else {
                arrSearchedSelectedIndex.append(indexPath.row)
            }
            currentIndex = arrData.firstIndex(where: {$0 == selectedValue}) ?? indexPath.row
        }
        
        if popupType == .singleIndexSelection {
            self.singleSelectedIndex = currentIndex
            if let index = singleSelectedIndex {
                singleSelectCallBack?(index ,finalData[index])
            }
            
            tableView.reloadData()
            self.dismiss(animated: true) { () -> Void in
            }
        } else if(popupType == .multiSelection){
            if(arrSelectedIndex.count != 0){
                if(arrSelectedIndex.contains(currentIndex) == true){
                    if let index = arrSelectedIndex.firstIndex(of: currentIndex) {
                        arrSelectedIndex.remove(at: index)
                    }
                }else{
                    arrSelectedIndex.append(currentIndex)
                }
            }else{
                arrSelectedIndex.append(currentIndex)
            }
            tableView.reloadData()
            
        } else if popupType == .sortView {
            arrSelectedIndex.removeAll()
            self.singleSelectedIndex = currentIndex
            arrSelectedIndex.append(currentIndex)
            tableView.reloadData()
        } else {
            arrSelectedIndex.removeAll()
            arrSelectedIndex.append(currentIndex)
            
            multiSelectcallBack?(arrSelectedIndex)
            self.dismiss(animated: true) { () -> Void in
                
            }
        }
    }

}
extension PopOverViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchedData = arrData.filter { $0.lowercased().prefix(searchText.count) == searchText.lowercased() }
        searching = true
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        tableView.reloadData()
    }
}
