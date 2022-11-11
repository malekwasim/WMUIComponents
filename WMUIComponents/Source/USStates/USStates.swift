

import Foundation


public struct USStates {
    var stateId: Int
    var name: String
    var stateCode: String
    var countryId: Int = 1
}

public class USStateHelper {
   private static func createStates() -> [USStates] {
        var states = [USStates]()
        let item1 = USStates(stateId: 1, name: "Alaska", stateCode: "AK")
        let item2 = USStates(stateId: 2, name: "Alabama", stateCode: "AL")
        let item3 = USStates(stateId: 3, name: "Arkansas", stateCode: "AR")
        let item4 = USStates(stateId: 4, name: "Arizona", stateCode: "AZ")
        let item5 = USStates(stateId: 5, name: "California", stateCode: "CA")
        let item6 = USStates(stateId: 6, name: "Colorado", stateCode: "CO")
        let item7 = USStates(stateId: 7, name: "Connecticut", stateCode: "CT")
        let item8 = USStates(stateId: 8, name: "District of Columbia", stateCode: "DC")
        let item9 = USStates(stateId: 9, name: "Delaware", stateCode: "DE")
        let item10 = USStates(stateId: 10, name: "Florida", stateCode: "FL")
        let item11 = USStates(stateId: 11, name: "Georgia", stateCode: "GA")
        let item12 = USStates(stateId: 12, name: "Hawaii", stateCode: "HI")
        let item13 = USStates(stateId: 13, name: "Iowa", stateCode: "IA")
        let item14 = USStates(stateId: 14, name: "Idaho", stateCode: "ID")
        let item15 = USStates(stateId: 15, name: "Illinois", stateCode: "IL")
        let item16 = USStates(stateId: 16, name: "Indiana", stateCode: "IN")
        let item17 = USStates(stateId: 17, name: "Kansas", stateCode: "KS")
        let item18 = USStates(stateId: 18, name: "Kentucky", stateCode: "KY")
        let item19 = USStates(stateId: 19, name: "Louisiana", stateCode: "LA")
        let item20 = USStates(stateId: 20, name: "Massachusetts", stateCode: "MA")
        let item21 = USStates(stateId: 21, name: "Maryland", stateCode: "MD")
        let item22 = USStates(stateId: 22, name: "Maine", stateCode: "ME")
        let item23 = USStates(stateId: 23, name: "Michigan", stateCode: "MI")
        let item24 = USStates(stateId: 24, name: "Minnesota", stateCode: "MN")
        let item25 = USStates(stateId: 25, name: "Missouri", stateCode: "MO")
        let item26 = USStates(stateId: 26, name: "Mississippi", stateCode: "MS")
        let item27 = USStates(stateId: 27, name: "Montana", stateCode: "MT")
        let item28 = USStates(stateId: 28, name: "North Carolina", stateCode: "NC")
        let item29 = USStates(stateId: 29, name: "North Dakota", stateCode: "ND")
        let item30 = USStates(stateId: 30, name: "Nebraska", stateCode: "NE")
        let item31 = USStates(stateId: 31, name: "New Hampshire", stateCode: "NH")
        let item32 = USStates(stateId: 32, name: "New Jersey", stateCode: "NJ")
        let item33 = USStates(stateId: 33, name: "New Mexico", stateCode: "NM")
        let item34 = USStates(stateId: 34, name: "Nevada", stateCode: "NV")
        let item35 = USStates(stateId: 35, name: "New York", stateCode: "NY")
        let item36 = USStates(stateId: 36, name: "Ohio", stateCode: "OH")
        let item37 = USStates(stateId: 37, name: "Oklahoma", stateCode: "OK")
        let item38 = USStates(stateId: 38, name: "Oregon", stateCode: "OR")
        let item39 = USStates(stateId: 39, name: "Pennsylvania", stateCode: "PA")
        let item40 = USStates(stateId: 40, name: "Rhode Island", stateCode: "RI")
        let item41 = USStates(stateId: 41, name: "South Carolina", stateCode: "SC")
        let item42 = USStates(stateId: 42, name: "South Dakota", stateCode: "SD")
        let item43 = USStates(stateId: 43, name: "Tennessee", stateCode: "TN")
        let item44 = USStates(stateId: 44, name: "Texas", stateCode: "TX")
        let item45 = USStates(stateId: 45, name: "Utah", stateCode: "UT")
        let item46 = USStates(stateId: 46, name: "Virginia", stateCode: "VA")
        let item47 = USStates(stateId: 47, name: "Vermont", stateCode: "VT")
        let item48 = USStates(stateId: 48, name: "Washington", stateCode: "WA")
        let item49 = USStates(stateId: 49, name: "Wisconsin", stateCode: "WI")
        let item50 = USStates(stateId: 50, name: "West Virginia", stateCode: "WV")
        let item51 = USStates(stateId: 51, name: "Wyoming", stateCode: "WY")
        
        
        states.append(item1)
        states.append(item2)
        states.append(item3)
        states.append(item4)
        states.append(item5)
        states.append(item6)
        states.append(item7)
        states.append(item8)
        states.append(item9)
        states.append(item10)
        states.append(item11)
        states.append(item12)
        states.append(item13)
        states.append(item14)
        states.append(item15)
        states.append(item16)
        states.append(item17)
        states.append(item18)
        states.append(item19)
        states.append(item20)
        states.append(item21)
        states.append(item22)
        states.append(item23)
        states.append(item24)
        states.append(item25)
        states.append(item26)
        states.append(item27)
        states.append(item28)
        states.append(item29)
        states.append(item30)
        states.append(item31)
        states.append(item32)
        states.append(item33)
        states.append(item34)
        states.append(item35)
        states.append(item36)
        states.append(item37)
        states.append(item38)
        states.append(item39)
        states.append(item40)
        states.append(item41)
        states.append(item42)
        states.append(item43)
        states.append(item44)
        states.append(item45)
        states.append(item46)
        states.append(item47)
        states.append(item48)
        states.append(item49)
        states.append(item50)
        states.append(item51)
        
        return states
    }
    
   public static func getAllStates() -> [USStates] {
        return createStates()
    }
    
    public static func getNewJerseyState() -> USStates {
        return USStates(stateId: 32,
                        name: "New Jersey",
                        stateCode: "NJ")
    }
    public static func getAllStateNames() -> [String] {
        return getAllStates().map({$0.name})
    }
    private static func getAllCities() -> NSArray {
       // let bundle = Bundle(for: USStateHelper.self)
        let frameworkBundle = Bundle(for: WMTextField.self)
        let bundleURL = frameworkBundle.resourceURL?.appendingPathComponent("WMUIComponents.bundle")
        let resourceBundle = Bundle(url: bundleURL!)

        let path = resourceBundle?.path(forResource: "City", ofType: "json")
        let jsonData = try? Data(contentsOf: URL(fileURLWithPath: path!))
        let  jsonResult =  try! JSONSerialization.jsonObject(with: jsonData!, options: []) as? NSDictionary
        let  arrCity = (jsonResult?.value(forKey: "Data") as! NSArray)
        return arrCity
    }
    static func getAllCitiesForState(_ stateId: Int) -> NSArray {
        let  arrCity = getAllCities()
        let predicate:NSPredicate = NSPredicate.init(format:"StateId = %d",stateId)
        return arrCity.filtered(using: predicate) as NSArray
    }
   public static func getIdForCity(_ name: String) -> Int {
        var cityId = 0
        let  arrCity = getAllCities()
        let predicate:NSPredicate = NSPredicate.init(format:"Name = %@",name)
        let filteredArray = arrCity.filtered(using: predicate) as NSArray
        if filteredArray.count > 0 {
            if let cityDic = filteredArray.firstObject as? NSDictionary {
                if let value = cityDic["CityId"] as? Int {
                    cityId = value
                }
            }
        }
        return cityId
    }
}

