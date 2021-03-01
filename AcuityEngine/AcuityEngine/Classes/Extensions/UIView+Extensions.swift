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
    
}
