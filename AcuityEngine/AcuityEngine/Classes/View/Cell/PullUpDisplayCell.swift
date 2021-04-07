//
//  DataDisplayCell.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/02/21.
//

import Foundation
import UIKit

//MARK: - ViewController TableCell
class DataDisplayCell: UITableViewCell {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var relativeImportance: UILabel!
    
    @IBOutlet weak var systemScore: UILabel!
    @IBOutlet weak var weightedSystemScore: UILabel!
    
    @IBOutlet weak var maxScore: UILabel!
    
    
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        // Initialization code
    }
    func displayData(cardioData: AnyObject){
        if cardioData.isKind(of: CardioData.self){
            let cardioData = cardioData as? CardioData
            titleLabel.text = "Cardio"
            relativeImportance.text = "Relative Importance: \(String(describing: cardioData!.cardioRelativeImportance))"
            systemScore.text = String(format: "System Score: %.2f", (cardioData?.cardioSystemScore)!)
            weightedSystemScore.text = String(format: "Weighted System Score: %.2f", (cardioData?.cardioWeightedSystemScore)!)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

//MARK: - Picked Pullup TableCell
class AcuityDetailDisplayCell: UITableViewCell {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var maxScore: UILabel!
    @IBOutlet weak var disclousreButton: UIButton!
    
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        setFontForLabel()
        // Initialization code
    }
    
    func setFontForLabel(){
        titleLabel.font = Fonts.kAcuityDetailCellFont
        maxScore.font = Fonts.kAcuityDetailCellFont
    }
    
    func displayData(metrixItem:AcuityDetailPulllUpModel){
        
        titleLabel.text = metrixItem.title
        maxScore.text = metrixItem.value 
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

//MARK: - Picked Pullup TableCell
class AcuityDetailValueDisplayCell: UITableViewCell {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var maxScore: UILabel!
    
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        setFontForLabel(font:Fonts.kAcuitySystemCellFont)
        // Initialization code
    }
    
    func setFontForLabel(font:UIFont){
        titleLabel.font = font
        maxScore.font = font
    }
    
    func displayData(timeStamp:Double,value:String,color:UIColor){
        titleLabel.text = getDateMediumFormat(time: timeStamp)
        maxScore.text = value
        maxScore.textColor = color
    }
    
    func displayConditionData(item:ConditionsModel){
        titleLabel.text = item.title
        maxScore.textColor = item.color
        switch item.value {
        case .Yes:
            maxScore.text = ConditionValueText.Yes.rawValue
        default:
            maxScore.text = ConditionValueText.No.rawValue
        }
        
    }
    func displaySymptomsData(item:SymptomsModel){
        titleLabel.text = item.title
        maxScore.text = item.textValue?.rawValue
        maxScore.textColor = item.color
    }
    func displayLabsData(item:LabModel){
        titleLabel.text = item.title
        maxScore.text = item.value
        maxScore.textColor = item.color
    }
    func displayVitals(item:VitalsModel){
        titleLabel.text = item.title
        maxScore.text = item.value
        maxScore.textColor = item.color
        
    }
    
}
//==========================================================================================//

//MARK: - Profile Option Selection Cell
class LabelDisplayCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        setFontForLabel()
        // Initialization code
    }
    
    func setFontForLabel(){
        titleLabel.font = Fonts.kCellTitleFont
    }
    
    func displayData(title:String){
        
        titleLabel.text = title
        
    }
    
    
}

class ProfileViewCell: UITableViewCell{
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        setFontForLabel()
        // Initialization code
    }
    
    func setFontForLabel(){
        titleLabel.font = Fonts.kCellTitleFont
        valueLabel.font = Fonts.kValueFont
    }
    
    func displayData(title:String,value:String){
        titleLabel.text = title
        valueLabel.text = value
    }
    
    
}
//==========================================================================================//

//MARK: - Add Condition Selection Cell
class AddConditionCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yesOrNoSwitch: UISwitch!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        setFontForLabel()
        // Initialization code
    }
    
    func setFontForLabel(){
        titleLabel.font = Fonts.kCellTitleFont
    }
    
    func displayData(title:String){
        titleLabel.text = title
    }
    
    
}
//MARK: - Add Condition Selection Cell
class AddOptionCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    override func awakeFromNib() {
        
        super.awakeFromNib()
        setFontForLabel()
        // Initialization code
    }
    
    func setFontForLabel(){
        titleLabel.font = Fonts.kAcuityAddOptionTitleFont
        valueLabel.font = Fonts.kAcuityAddOptionValueFont
        valueLabel.numberOfLines = 0
        valueLabel.sizeToFit()
        containerView.layer.cornerRadius = 20
    }
    
    func displayData(title:String){
        titleLabel.text = title
        valueLabel.text = "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."
    }
    
    
}
//==========================================================================================//


