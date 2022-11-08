//
//  DateFormat.swift
//  KLUIComponents
//
//  Created by Wasim on 22/10/22.
//

import Foundation

public enum DateFormat: String {
    case api = "yyyy-MM-dd HH:mm:ssZ"
    case date_mmddyyy = "MM/dd/yyyy"
    case time_12hour      = "hh:mm a"
    case year = "yyyy"
    
    var format: String {
        return rawValue
    }
}
