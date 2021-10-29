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

//MARK: - Detail Screen Of Pullup TableCell
class AcuityDetailValueDisplayCell: UITableViewCell {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var maxScore: UILabel!
    @IBOutlet weak var btnArrowForDetail: UIButton!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        setFontForLabel(font:Fonts.kAcuityDetailCellFont)
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
    func displayValueDataForBPModel(item:VitalsModel){
        titleLabel.text = getDateMediumFormat(time: item.startTime)
        maxScore.textColor = UIColor.white
        maxScore.attributedText = createAttributeStringForBp(item: item)
        
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
    func displayMedicationData(item:MedicationDataDisplayModel){
        titleLabel.text = item.txtValue
        maxScore.isHidden = true
    }
    func displayLabsData(item:LabModel){
        titleLabel.text = item.title
        maxScore.text = item.value
        maxScore.textColor = item.color
    }
    func displayVitals(item:VitalsModel){
    
        if item.isBPModel{
            titleLabel.text = "BP"
            maxScore.textColor = UIColor.white
            maxScore.attributedText = createAttributeStringForBp(item: item)
        }else{
            titleLabel.text = item.title
            maxScore.text = item.value
            maxScore.textColor = item.color
        }
    }
    
    func createAttributeStringForBp(item:VitalsModel)->NSMutableAttributedString{
        //Remove .00 from string In BP...
        let strSystolic = (item.value ?? "").replacingOccurrences(of: ".00", with: "")
        let strDystolic = (item.valueForDiastolic ?? "").replacingOccurrences(of: ".00", with: "")
        let mainString = "\(strSystolic) / \(strDystolic)"
        let rangeSystolic = (mainString as NSString).range(of: strSystolic)
        let rangeDystolic = (mainString as NSString).range(of: strDystolic)
        let mutableAttributedString = NSMutableAttributedString.init(string: mainString)
        mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: item.color, range: rangeSystolic)
        mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: item.colorForDiastolic, range: rangeDystolic)
        
        return mutableAttributedString
    }
}
//MARK: - Detail Screen Of Pullup TableCell
class AcuityPullUpMetricsDisplayCell: AcuityDetailValueDisplayCell {
    
    @IBOutlet weak var imageIcon: UIImageView!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        setFontForLabel(font:Fonts.kAcuityPullUpMetricCellFont)
        // Initialization code
    }
    
    func displaySystemScore(item:[String:Any]){
        
        
        titleLabel.text =  item[Keys.kSystemName] as? String
        titleLabel.font =
            Fonts.kAcuityMyWellTblCellTitleFont
        titleLabel.textColor =  UIColor.white
        maxScore.text = item[Keys.kScore] as? String
        //        if let score = item[Keys.kScore] as? Double{
        //            maxScore.text = getStringToDisplayScore(score: score)
        //        }
        maxScore.font =  Fonts.kAcuityMyWellTblValueFont
        maxScore.textColor =  getThemeColor(index: maxScore.text, isForWheel: false)
        imageIcon.image =  UIImage(named: item[Keys.kImage] as? String ?? "")
    }
}

//==========================================================================================//

//MARK: - Profile Option Selection Cell
class LabelDisplayCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        setFontForLabel(font:Fonts.kCellTitleFont)
        // Initialization code
    }
    
    func setFontForLabel(font:UIFont){
        titleLabel.font = font
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
//==========================================================================================//

//MARK: - Cell of List screen in Add Section
class LabelInListAddSectionCell: LabelDisplayCell {
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        setFontForLabel(font:Fonts.kCellTextFontListInAddSection)
        // Initialization code
    }
    override func displayData(title:String){
        if title == VitalsName.BMI.rawValue{
            titleLabel.text = ScreenTitle.BMIIndexCalculator
        }else{
            titleLabel.text = title
        }
        
    }
}
//MARK: - Add symptoms Selection Cell
class AddSymptomsCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imgViewCheckMark: UIImageView!
    @IBOutlet weak var viewContainer: UIView!
    
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        setFontForLabel()
        // Initialization code
    }
    
    func setFontForLabel(){
        titleLabel.font = Fonts.kAcuitySystemCellFont
    }
    
    func displayData(title:String){
        
        titleLabel.text = title
        
    }
    
    func setBorderToCell(){
        self.viewContainer.layer.borderWidth = 1;
        self.viewContainer.layer.cornerRadius = 5;
        self.viewContainer.layer.borderColor = UIColor.white.cgColor;
        self.setCellUnSelected()
    }
    func setCellUnSelected(){
        self.viewContainer.backgroundColor = UIColor.white.withAlphaComponent(0.15)
        self.imgViewCheckMark.alpha = 0.10
    }
    func setCellSelected(){
        self.viewContainer.backgroundColor = UIColor.white.withAlphaComponent(0.6)
        self.imgViewCheckMark.alpha = 1
    }
}

//==========================================================================================//

//MARK: - Add Condition Selection Cell
class AddConditionCell: LabelDisplayCell {
    
    @IBOutlet weak var yesOrNoSwitch: UISwitch!
    @IBOutlet weak var yesOrNoSegmentControl: UISegmentedControl!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        setFontForLabel(font:Fonts.kCellTextFontListInAddSection)
        setUpSegmentControl(segmentControl: yesOrNoSegmentControl)
        // Initialization code
    }
    
    func displayData(title:String,isOn:Bool){
        if title == "" {
            
        }
        titleLabel.text = title
        
        yesOrNoSegmentControl.selectedSegmentIndex = isOn ? 0 : 1;
    }
    
    func setUpSegmentControl(segmentControl:UISegmentedControl){
        segmentControl.setTitle(SegmentValueForCondition.Yes.rawValue, forSegmentAt: 0)
        segmentControl.setTitle(SegmentValueForCondition.No.rawValue, forSegmentAt: 1)
        segmentControl.defaultConfiguration(font: Fonts.kAcuityDetailSegmentFont, color: UIColor.white)
        segmentControl.selectedConfiguration(font: Fonts.kAcuityDetailSegmentFont, color: UIColor.black)
        segmentControl.selectedSegmentIndex = 1
        //self.segmentClicked(segmentControl)
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
        containerView.backgroundColor = ColorSchema.addOptionGrayColor
    }
    
    func displayData(title:String){
        titleLabel.text = title
        valueLabel.text = "\(title)\(AlertMessages.MESSAGE_IN_ADD_OPTION_SCREEN)"
    }
    
    
}
//==========================================================================================//


