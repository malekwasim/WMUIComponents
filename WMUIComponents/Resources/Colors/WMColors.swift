//
//  KLColors.swift
//  KLUIComponents
//
//  Created by Wasim on 22/10/22.
//

import UIKit

extension UIColor {

    convenience init(hex: String) {
        self.init(hex: hex, alpha:1)
    }

    convenience init(hex: String, alpha: CGFloat) {
        let hexString: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
    
    var rgbComponents:(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        if getRed(&r, green: &g, blue: &b, alpha: &a) {
            return (r,g,b,a)
        }
        return (0,0,0,0)
    }
    // hue, saturation, brightness and alpha components from UIColor**
    var hsbComponents:(hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat) {
        var hue:CGFloat = 0
        var saturation:CGFloat = 0
        var brightness:CGFloat = 0
        var alpha:CGFloat = 0
        if getHue(&hue,
                  saturation: &saturation,
                  brightness: &brightness,
                  alpha: &alpha){
            return (hue,saturation,brightness,alpha)
        }
        return (0,0,0,0)
    }
    
    var htmlRGBColor:String {
        return String(format: "#%02x%02x%02x",
                      Int(rgbComponents.red * 255),
                      Int(rgbComponents.green * 255),
                      Int(rgbComponents.blue * 255))
    }
    
    static func infoBlueColor() -> UIColor {
        return UIColor.init(hex: "2D76BA")
    }
    static func successGreenColor() -> UIColor {
        return UIColor.init(hex: "009800")
    }
    static func errorRedColor() -> UIColor {
        return UIColor.init(hex: "F0513B")
    }
    static func confirmBlackColor() -> UIColor {
        return UIColor.init(hex: "424242")
    }
    static func warningOrangeColor() -> UIColor {
        return UIColor.init(hex: "f48f03")
    }
    static func violetColor() -> UIColor {
        return UIColor.init(hex: "5A62A9")
    }
    static var DEDEDE: UIColor {
        return UIColor.init(hex: "#DEDEDE")
    }
    static var F5F4F5: UIColor {
        return UIColor.init(hex: "#F5F4F5")
    }
    static var submitGreen: UIColor {
        return UIColor.init(hex: "#009900")
    }
    static var cancelRed: UIColor {
        return UIColor.init(hex: "#E42D3E")
    }
    static var appblue: UIColor {
        return UIColor.init(hex: "#01B5DE")
    }
    static var E2E5EA: UIColor {
        return UIColor.init(hex: "#E2E5EA")
    }
    static var FEF5CE: UIColor {
        return UIColor.init(hex: "#FEF5CE")
    }
    static var A8DCE2: UIColor {
        return UIColor.init(hex: "#A8DCE2")
    }
    
    //WEB
    static var colr_739bd1: UIColor {
        return UIColor.init(hex: "#739bd1")
    }
    //OLD MOBILE UI COLOR
    static var colr_02B6DE: UIColor {
        return UIColor.init(hex: "#02B6DE")
    }
    public static var platinum: UIColor {
        return UIColor(hex: "E3E3E3")
    }
   
}
