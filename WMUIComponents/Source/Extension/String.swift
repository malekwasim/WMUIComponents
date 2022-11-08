//
//  String.swift
//  KLUIComponents
//
//  Created by Wasim on 22/10/22.
//

import Foundation

extension String {
    static func className(_ aClass: AnyClass) -> String {
        return NSStringFromClass(aClass).components(separatedBy: ".").last!
    }
    //Validate Email
    var isEmail: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
            return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count)) != nil
        } catch {
            return false
        }
    }
    func formatString(_ sectionArray:[Int], seprator:String) -> String {
        
        var result = ""
        var strInput = self
        var totalLength = 0
        var processedLength = 0

        strInput = strInput.replacingOccurrences(of: seprator, with: "")
        let count = strInput.count
        
        var lastIndex = Int(0)
        for section in sectionArray {
            
            if count <= processedLength + section  {
                strInput = strInput.substring(processedLength)
                result = [result,strInput].joined()
                return result
            }
            
            let range = NSRange(location: lastIndex, length: section)
            let substring = (strInput as NSString).substring(with: range)
            
            lastIndex = lastIndex + section
            totalLength = totalLength + section + 1
            processedLength = processedLength + section
            result = [result,substring,seprator].joined()
            
        }
        totalLength = totalLength - 1
        if result.count > totalLength {
            result = (result as NSString).substring(with: NSRange(location: 0, length: totalLength))
        }
        
        return result
    }
    func substring(_ from: Int) -> String {
        let endOfSentence = self.index(startIndex, offsetBy: from)
        let firstSentence = self[endOfSentence...]
        return String(firstSentence)
//        return self.substring(from: self.index(self.startIndex, offsetBy: from))
    }
    
    func dateFromStringDate(_ dateFormat:String) -> Date {
        let formatter:DateFormatter = DateFormatter.init()
        formatter.dateFormat = dateFormat
        formatter.locale =  Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone.init(secondsFromGMT: 0)
        
        var newDate = Date()
        
        if let getDate = formatter.date(from: self) {
            newDate = getDate
        }
        return newDate
    }
    
}
