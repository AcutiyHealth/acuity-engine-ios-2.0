//
//  ProfileSharedData.swift
//  AcuityEngine
//
//  Created by Bhoomi Jagani on 14/01/22.
//

import Foundation
import HealthKitReporter

class ProfileSharedData {
    //UserDefaults
    static let shared = ProfileSharedData()
    var birthDate = ""
    var sex = ""
    var bloodType = ""
    var age = 0
     func readBasicDetails() {
        do {
            let reporter = try HealthKitReporter()
            let characteristic = reporter.reader.characteristics()
            let birthDay = characteristic.birthday ?? ""
            let age = Utility.calculateAgeFromBirthDate(birthday: birthDay)
         
            self.age = age
            self.birthDate = characteristic.birthday == "na" ? "":birthDay
            self.sex = ((characteristic.biologicalSex == "na" ? "":characteristic.biologicalSex)) ?? ""
            self.bloodType = ((characteristic.bloodType == "na" ? "":characteristic.bloodType)) ?? ""
         
        } catch {
            print(error)
        }
    }
}
