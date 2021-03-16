//
//  Helper.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 17/02/21.
//

import Foundation

/// Standardize the display of dates within the app.
func createDefaultDateFormatter() -> DateFormatter {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}

/// Used to unescape the FHIR JSON prior to displaying it in the FHIR Source view.
func unescapeJSONString(_ string: String) -> String {
    return string.replacingOccurrences(of: "\\/", with: "/").replacingOccurrences(of: "\\\\", with: "\\")
}

//MARK: Chart Segment Color
func getThemeColor(index: String?,isForWheel:Bool) -> UIColor? {
    let indexValue = Double(index ?? "") ?? 0
    if indexValue > 0 && indexValue <= 75 {
        if isForWheel{
            return WheelColor.REDCOLOR
        }else{
            return ChartColor.REDCOLOR
        }
    } else if indexValue > 75 && indexValue <= 85 {
        if isForWheel{
            return WheelColor.YELLOWCOLOR
        }else{
            return ChartColor.YELLOWCOLOR
        }
        
    } else {
        if isForWheel{
            return WheelColor.GREENCOLOR
        }else{
            return ChartColor.GREENCOLOR
        }
        
    }
}

func isiPhone() -> Bool{
    
    if UIDevice.current.userInterfaceIdiom == .phone {
        return true
    }
    return false
}


func getDateMediumFormat(time:Double)->String{
    
    let date = Date(timeIntervalSince1970: time)
    let dateFormatter = DateFormatter()
    
    dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
    dateFormatter.timeZone = .current
    let localDate = dateFormatter.string(from: date)
    return localDate
    
}

func getDateWithTime(date:Date)->String{
    
    let formatter = DateFormatter()
    formatter.dateFormat = "M/dd/yyyy hh:mm a"
    let localDate = formatter.string(from: date)
    return localDate
    
}
