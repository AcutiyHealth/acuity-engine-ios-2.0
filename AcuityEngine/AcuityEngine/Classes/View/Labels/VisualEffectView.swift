//
//  LabelTitle.swift
//  learnIt
//
//  Created by Yashesh Chauhan on 22/01/20.
//  Copyright © 2020 TechGadol. All rights reserved.
//

import UIKit

//MARK:VisulaEffectView

class VisualEffectView: UIVisualEffectView {
    
    override init(effect: UIVisualEffect?) {
        super.init(effect: effect)
        
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    
    func setup() {
        
        for view in self.subviews{
            view.backgroundColor = ColorSchema.kMainThemeColorForPullup
        }
        
    }
}
