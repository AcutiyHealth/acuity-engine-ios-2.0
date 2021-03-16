//
//  LabelTitle.swift
//  learnIt
//
//  Created by Yashesh Chauhan on 22/01/20.
//  Copyright © 2020 TechGadol. All rights reserved.
//

import UIKit

//MARK:BaseLabel
class BaseLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
   
}


//MARK:LabelTitle
@IBDesignable
class LabelTitle: BaseLabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
       
        //font = UIFont.SFProDisplayTitle()
        //textColor = ColorSchema.titleLabelColor
    }
    @IBInspectable var sizeOfFont: CGFloat = 18 {
        didSet {
            font = UIFont.SFProDisplayBold(of: sizeOfFont)
        }
    }
}

//MARK:LabelSmallTitle
class LabelSmallTitle: BaseLabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
       
    }
    @IBInspectable var sizeOfFont: CGFloat = 18 {
        didSet {
            font = UIFont.SFProDisplayBoldItalic(of: sizeOfFont)
        }
    }
}

//MARK:LabelDetail
class LabelDetail: BaseLabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        font = UIFont.SFProDisplayMedium()
        textColor = ColorSchema.detailLabelColor
    }

}
