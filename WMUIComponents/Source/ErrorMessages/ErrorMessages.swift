//
//  ErrorMessages.swift
//  KLUIComponents
//
//  Created by Wasim on 23/10/22.
//

import Foundation

enum ErrorMessages: String {
    case socialSecurity = "Please enter proper social security number"
    case validEmailAddress = "Please enter valid email address"
    case homePhoneNumber = "Please enter proper home phone number"
    var error: String {
        return rawValue
    }
}
