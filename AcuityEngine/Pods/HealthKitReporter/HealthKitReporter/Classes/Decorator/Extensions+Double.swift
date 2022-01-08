//
//  Extensions+Double.swift
//  HealthKitReporter
//
//  Created by Victor on 30.09.20.
//

import Foundation

public extension Double {
    var asDate: Date {
        return Date(timeIntervalSince1970: self)
    }
    
    var secondsSince1970: Double {
        return (self / 1000)
    }
    
    func asString(style: DateComponentsFormatter.UnitsStyle) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second, .nanosecond]
        formatter.unitsStyle = style
        return formatter.string(from: self) ?? ""
    }
    
    func asStringWithHoursAndMinutesOnly(style: DateComponentsFormatter.UnitsStyle) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = style
        return formatter.string(from: self) ?? ""
    }
}
