//
//  Utility.swift
//  AYMTechnicalAssessment
//
//  Created by Waseem Shahzad on 9/2/18.
//  Copyright © 2018 Waseem Shahzad. All rights reserved.
//

import Foundation
import UIKit
struct Utility {
    
    static func kelvinToCelsius(_ degrees: Double) -> Double {
        return round(degrees - 273.15)
    }
    
    static func kelvinToFahrenheit(_ degrees: Double) -> Double {
        return round(degrees * 9 / 5 - 459.67)
    }
    static func fahrenheitToCelsius(_ degrees: Double) -> Double {
        return round((degrees - 32) / 1.8)
    }
    
    static func celsiusToFahrenheit(_ degrees: Double) -> Double {
        return round((degrees * 1.8) + 32)
    }
    
    static func getMutableAttributedString(leftString: String, rightString: String ) ->NSMutableAttributedString {
        let mutableAttributedString = NSMutableAttributedString()
        let leftAttrString = NSAttributedString(string: leftString)
        let atrribute = [NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 12)]
        let rightAtrrString = NSAttributedString(string:rightString, attributes: atrribute)
        mutableAttributedString.append(leftAttrString)
        mutableAttributedString.append(rightAtrrString)
        return mutableAttributedString
    }
    static func getDifferentColorsOfString(leftString:String,rightString:String) ->NSMutableAttributedString {
        let mutableAttributedString = NSMutableAttributedString()
        let leftAttrString = NSAttributedString(string: leftString)
        let attribute = [NSAttributedStringKey.foregroundColor : UIColor.lightGray]
        let rightAtrrString = NSAttributedString(string:rightString, attributes: attribute)
        mutableAttributedString.append(leftAttrString)
        mutableAttributedString.append(rightAtrrString)
        return mutableAttributedString
    }
}
struct ForecastDateTime {
    let rawDate: Double
    let timeZone: TimeZone
    
    init(date: Double, timeZone: TimeZone) {
        self.timeZone = timeZone
        self.rawDate = date
    }
    
    var weekDay: String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = timeZone
        dateFormatter.dateFormat = "EEEE"
        let date = Date(timeIntervalSince1970: rawDate)
        return dateFormatter.string(from: date)
    }
    var shortWeekDay: String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = timeZone
        dateFormatter.dateFormat = "EEE"
        let date = Date(timeIntervalSince1970: rawDate)
        return dateFormatter.string(from: date)
    }
    var time: String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = timeZone
        dateFormatter.dateFormat = "HH:MM a"
        let date = Date(timeIntervalSince1970: rawDate)
        return dateFormatter.string(from: date)
    }
}


extension UIStackView {
    
    func addBackground(color: UIColor) {
        let subView = UIView(frame: bounds)
        subView.backgroundColor = color
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(subView, at: 0)
    }
    
}
