//
//  String+Extensions.swift
//  learnIt
//
//  Created by TRT-IOS-1 on 12/12/19.
//  Copyright © 2019 TechGadol. All rights reserved.
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
