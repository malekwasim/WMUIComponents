//
//  KLStateTextField.swift
//  KinderLink
//
//  Created by Wasim on 28/07/22.
//  Copyright © 2022 Diptesh Patel. All rights reserved.
//

import UIKit

public class WMStateTextField: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet public weak var txtState: WMTextField!
    @IBOutlet public  weak var txtCity: WMTextField!
    @IBOutlet public weak var txtZip: WMTextField!
    var arrState = [USStates]()
    var selectedState = ""
    public var stateID:Int = 0
    var arrCity:NSArray!
    var selectedCity = ""
    public var cityID:Int!
    var baseViewController: UIViewController?
    var selectedStateIndex: Int?
    var selectedCityIndex: Int?
    public var isRequired:Bool = false {
        didSet {
            setRequiredLabel()
        }
    }
    
    static let defaultSelectedState = USStateHelper.getNewJerseyState()
    static let defaultSelectedCity = "Bridgewater"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Utility.bundle()?.loadNibNamed("WMStateTextField", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.backgroundColor = self.backgroundColor
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        setupStates()
    }
    
    func setRequiredLabel() {
        if isRequired == true {
            txtState.isRequired = isRequired
            txtCity.isRequired = isRequired
            txtZip.isRequired = isRequired
        }
    }
    public func setupBaseView(_ baseVC: UIViewController?) {
        txtState.textField.baseVC = baseVC
        txtCity.textField.baseVC = baseVC
    }
    
    private func setupStates() {
        txtZip.setTextPadtype()
        txtState.setRightView(UIImage(named: "ic_arrow_drop_down"))
        txtCity.setRightView(UIImage(named: "ic_arrow_drop_down"))
        arrState = USStateHelper.getAllStates()
        selectedState.removeAll()
        selectedCity.removeAll()
        selectedState.append(WMStateTextField.defaultSelectedState.name)
        stateID = WMStateTextField.defaultSelectedState.stateId
        selectedState = WMStateTextField.defaultSelectedState.name
        txtState?.setText(selectedState)
        selectedCity.append(WMStateTextField.defaultSelectedCity)
        txtCity.setText(WMStateTextField.defaultSelectedCity)
        setupTextField()
        arrCity = USStateHelper.getAllCitiesForState(stateID)
        setupCities()
        cityID = USStateHelper.getIdForCity(WMStateTextField.defaultSelectedCity)
        txtZip.textField.delegate = self
        txtState.textField.delegate = self
    }
    
    private func setupTextField() {
        let stateNames = arrState.map({$0.name})
        txtState.textField.showSingleValueSelectionPopup(stateNames,
                                                         selectedIndex: selectedStateIndex,
                                                         popupMode: .singleIndexSelection, didSelect: { (index, state) in
                                                            self.setSelectedState(state, index: index)
                                                         }, isFullscreen: false,
                                                         setTitle: "Select State")
    }
    
    private func setupCities() {
        txtCity.textField.delegate = self
    }
    
    private func setSelectedState(_ state: String, index: Int) {
        selectedState = state
        selectedStateIndex = index
        txtState.textField.text = selectedState
        let filterStateArray = arrState.filter({$0.name == txtState.text})
        
        if(filterStateArray.count > 0){
            stateID = filterStateArray[0].stateId
        }
        if stateID != WMStateTextField.defaultSelectedState.stateId {
            txtCity.setText("")
            arrCity = USStateHelper.getAllCitiesForState(stateID)
        }
    }
    private func setSelectedCity(_ city: String, index: Int) {
        selectedCity = city
        selectedCityIndex = index
        self.txtCity.setText(selectedCity)
        let cityPredicate:NSPredicate = NSPredicate.init(format: "Name = %@ AND StateId = %@", argumentArray: [selectedCity, stateID])
         let filteredCityArray = arrCity.filtered(using: cityPredicate)
        if filteredCityArray.count > 0 {
            if let dicCity = filteredCityArray[0] as? NSDictionary {
                cityID = dicCity.value(forKey: "CityId")  as? Int
            }
        }
    }
    
}

extension WMStateTextField: UITextFieldDelegate {
    func selectCities() -> Bool {
        guard let cities = arrCity.value(forKey: "Name") as? [String] else {
            return false
        }
        txtCity.textField.showSingleValueSelectionPopup(cities,
                                                        selectedIndex: selectedCityIndex, popupMode: .singleIndexSelection, didSelect: { (index, city) in
                                                            self.setSelectedCity(city, index: index)
                                                        },
                                                        isFullscreen: false,
                                                        setTitle: "Select City")
        return false
    }
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == txtCity.textField {
          return selectCities()
        }
        if textField == txtState.textField {
            setupTextField()
        }
        if textField == txtZip.textField {
            return true
        }
        return false
    }
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
      if textField == txtZip.textField {
            let str = (textField.text ?? "") as NSString
            let result = str.replacingCharacters(in: range, with: string)
            let numbersOnly = NSCharacterSet.init(charactersIn: "0123456789")
            let textFieldChars = NSCharacterSet.init(charactersIn: result)
            
            if !numbersOnly.isSuperset(of: textFieldChars as CharacterSet) {
                return false
            }
            textField.text = result.formatString([5], seprator: "")
        }
        return false
    }
}
