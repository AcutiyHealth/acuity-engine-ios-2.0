//
//  combine+Extensions.swift
//  AcuityEngine
//
//  Created by Bhoomi Jagani on 29/04/21.
//

import Foundation
extension String {
    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return predicate.evaluate(with: self)
    }
    
    var validOptionalString: String? {
        let condition = self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        return condition ? nil : self
    }
}

extension Int {

    var bool: Bool {
        return self == 1 ? true : false
    }
}
