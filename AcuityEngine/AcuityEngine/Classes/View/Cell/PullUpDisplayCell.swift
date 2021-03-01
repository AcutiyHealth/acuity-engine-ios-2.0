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
        else if cardioData.isKind(of: RespiratoryData.self){
            let respiratoryData = cardioData as? RespiratoryData
            titleLabel.text = "Respiratory"
            relativeImportance.text = "Relative Importance: \(String(describing: respiratoryData!.respiratoryRelativeImportance))"
            systemScore.text = String(format: "System Score: %.2f", (respiratoryData?.respiratorySystemScore)!)
            weightedSystemScore.text = String(format: "Weighted System Score: %.2f", (respiratoryData?.respiratoryWeightedSystemScore)!)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

//MARK: - Picked Pullup TableCell
class PullUpDisplayCell: UITableViewCell {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var maxScore: UILabel!

    
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
       
        // Initialization code
    }
    func displayData(metrixItem:[String:Any]){
       
        guard  metrixItem.count>0 else {
            return
        }
        titleLabel.text = Array(metrixItem)[0].key
        maxScore.text = Array(metrixItem)[0].value as? String
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
