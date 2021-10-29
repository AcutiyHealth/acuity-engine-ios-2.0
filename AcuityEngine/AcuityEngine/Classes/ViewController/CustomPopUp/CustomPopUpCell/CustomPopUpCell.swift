//
//  CustomPopUpCell.swift
//  AcuityEngine
//
//  Created by DevDigital on 13/10/21.
//

import UIKit

class CustomPopUpCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        lblTitle.font = Fonts.kCellProfileDetailFont
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.backgroundColor = selected ? UIColor(white: 0.0, alpha: 0.3) : UIColor.clear
        // Configure the view for the selected state
    }
    
}
