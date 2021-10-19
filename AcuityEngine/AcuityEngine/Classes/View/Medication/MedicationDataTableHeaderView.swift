//
//  DemoHeaderView.swift
//  CustomHeaderDemo
//
//  Created by Macintosh HD on 11/24/17.
//  Copyright © 2017 iOS-Tutorial. All rights reserved.
//

import UIKit

class MedicationDataTableHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var lblTitle: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        viewBg.backgroundColor = ColorSchema.addOptionGrayColor
        lblTitle.font = Fonts.kCellHistoryDataTitleFontInAddSection
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
