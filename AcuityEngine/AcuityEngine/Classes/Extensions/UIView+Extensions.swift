//
//  UIView+Extensions.swift
//  learnIt
//
//  Created by Yashesh Chauhan on 20/12/19.
//  Copyright © 2019 TechGadol. All rights reserved.
//

import UIKit

extension UIView {
    
    func addCornerRadius(corderRadius: CGFloat) {
        self.layer.cornerRadius = corderRadius
        self.layer.masksToBounds = true
    }
    
    func addBorder(width: CGFloat, color: UIColor) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
    public func removeAllConstraints() {
           var _superview = self.superview
           
           while let superview = _superview {
               for constraint in superview.constraints {
                   
                   if let first = constraint.firstItem as? UIView, first == self {
                       superview.removeConstraint(constraint)
                   }
                   
                   if let second = constraint.secondItem as? UIView, second == self {
                       superview.removeConstraint(constraint)
                   }
               }
               
               _superview = superview.superview
           }
           
           self.removeConstraints(self.constraints)
           self.translatesAutoresizingMaskIntoConstraints = true
       }
}

