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
func getThemeColor(index: String?) -> UIColor? {
    let indexValue = Int(index ?? "") ?? 0
    if indexValue > 0 && indexValue <= 75 {
        return ChartColor.REDCOLOR
    } else if indexValue > 75 && indexValue <= 85 {
        return ChartColor.YELLOWCOLOR
    } else {
        return ChartColor.GREENCOLOR
    }
}

 func isiPhone() -> Bool{
    
    if UIDevice.current.userInterfaceIdiom == .phone {
        return true
    }
    return false
}
