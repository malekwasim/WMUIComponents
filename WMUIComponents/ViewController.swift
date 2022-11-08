//
//  ViewController.swift
//  WMUIComponents
//
//  Created by Wasim on 08/11/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var txtYear: WMYearTextField!
    @IBOutlet weak var txtSSN: WMPhoneTextField!
    @IBOutlet weak var txtDate: WMDateTextField!
    @IBOutlet weak var viewState: WMStateTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        txtYear.textField.baseVC = self
        txtSSN.isSSN = true
        txtDate.textField.baseVC = self
        viewState.setupBaseView(self)
    }


}

