//
//  AppleUser.swift
//  AcuityEngine
//
//  Created by Bhoomi Jagani on 10/07/21.
//

import Foundation
import AuthenticationServices
struct AppleUser:Codable{
    let userId:String
    let firstName:String
    let lastName:String
    let email:String
    
    init?(appleIDCredential:ASAuthorizationAppleIDCredential) {
        guard let firstName = appleIDCredential.fullName?.givenName, let lastName = appleIDCredential.fullName?.familyName,let email = appleIDCredential.email else {
             return nil
        }
        self.userId = appleIDCredential.user
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
    }
}
