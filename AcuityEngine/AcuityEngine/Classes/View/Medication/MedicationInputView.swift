//
//  DemoHeaderView.swift
//  CustomHeaderDemo
//
//  Created by Macintosh HD on 11/24/17.
//  Copyright © 2017 iOS-Tutorial. All rights reserved.
//

import UIKit

class MedicationInputView: UITableViewCell,UITextFieldDelegate {
    
    @IBOutlet weak var btnAdd:UIButton!
    @IBOutlet weak var lblMedicationText:UILabel!
    @IBOutlet weak var lblMedicationDescription:UILabel!
    @IBOutlet weak var txtFieldMedicationText:UITextField!
    @IBOutlet weak var viewTxtFieldMedication: UIView!
    
    // Declare callback function variable
    var returnValue: ((_ value: String)->())?
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        setFontForLabel()
        //
        btnAdd.isEnabled = false
        //
        txtFieldMedicationText.delegate = self
        //Set border view......
        setupViewBorderForAddSection(view: viewTxtFieldMedication)
        //setupViewBorderForAddSection(view: btnAdd)
        btnAdd.layer.addBorder(edge: UIRectEdge.left, color: UIColor.white, thickness: 0.5)
        //Set Font For textfield and button......
        txtFieldMedicationText.font = Fonts.kStartEndValueFont
        btnAdd.titleLabel?.font = Fonts.kAcuityBtnAdd
        btnAdd.backgroundColor = UIColor.darkGray
        //Set Btn Font Color....
        btnAdd.tintColor = UIColor.white
        //Add button and textfield target....
        txtFieldMedicationText.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        btnAdd.addTarget(self, action: #selector(addMedicationText), for: UIControl.Event.touchUpInside)
        
    }
    //========================================================================================================
    //MARK: Set Font For Label
    //========================================================================================================
    func setFontForLabel(){
        lblMedicationDescription.font = Fonts.kCellHistoryDescriptionFontInAddSection
        lblMedicationText.font = Fonts.kCellHistoryTitleFontInAddSection
    }
    //MARK: Text Editing methods...
    func textFieldDidEndEditing(_ textField: UITextField) {
        //returnValue?(txtFieldMedicationText.text ?? "") // Use callback to return data
    }
    //========================================================================================================
    //MARK: Text Delegate..
    //========================================================================================================
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.superview?.endEditing(true)
        return false
    }
    @objc func editingChanged(_ textField: UITextField) {
        if textField.text?.count == 1 {
            if textField.text?.first == " " {
                textField.text = ""
                return
            }
        }
        guard
            let medicin = txtFieldMedicationText.text, !medicin.isEmpty
        
        else {
            btnAdd.isEnabled = false
            return
        }
        btnAdd.isEnabled = true
    }
    //MARK:- Button methods....
    @objc func addMedicationText()  {
        btnAdd.isEnabled = false
        let  medicationTxt = txtFieldMedicationText.text?.replacingOccurrences(of: "/s", with: "'s") ?? "";
        returnValue?( medicationTxt) //
    }
    //========================================================================================================
    //MARK: Display Data..
    //========================================================================================================
    func displayData(model:MedicationInputModel){
        let  medicationTxt = model.name?.rawValue ?? ""
        lblMedicationText.text =  medicationTxt.replacingOccurrences(of: "/s", with: "'s");
        lblMedicationDescription.text = model.description ?? ""
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
}


class  MedicationTextCell: UITableViewCell,UITextFieldDelegate {
    
    @IBOutlet weak var lblMedicationText:UILabel!
    @IBOutlet weak var btnDelete:UIButton!
    // Declare callback function variable
    var btnDeleteCall: (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        btnDelete.addTarget(self, action: #selector(deleteMedicationText), for: UIControl.Event.touchUpInside)
    }
    //========================================================================================================
    //MARK: Delete Medication Text..
    //========================================================================================================
    @objc func deleteMedicationText()  {
        btnDeleteCall?() //
    }
    //========================================================================================================
    //MARK: Display Data..
    //========================================================================================================
    func displayData( medicationTxt:String){
        lblMedicationText.text =  medicationTxt.replacingOccurrences(of: "/s", with: "'s");
        lblMedicationText.font = Fonts.kCellHistoryDataValueFontInAddSection
        btnDelete.titleLabel?.font = Fonts.kCellHistoryDataValueFontInAddSection
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
