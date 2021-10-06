//
//  DemoHeaderView.swift
//  CustomHeaderDemo
//
//  Created by Macintosh HD on 11/24/17.
//  Copyright © 2017 iOS-Tutorial. All rights reserved.
//

import UIKit

class OtherHistoryInputView: UITableViewCell,UITextFieldDelegate {
    
    @IBOutlet weak var btnAdd:UIButton!
    @IBOutlet weak var lblHistoryText:UILabel!
    @IBOutlet weak var lblHistoryDescription:UILabel!
    @IBOutlet weak var txtFieldHistoryText:UITextField!
    @IBOutlet weak var viewTxtFieldHistory: UIView!
    
    // Declare callback function variable
    var returnValue: ((_ value: String)->())?
    override func awakeFromNib() {
        super.awakeFromNib()
    
        // Initialization code
        setFontForLabel()
        //
        btnAdd.isEnabled = false
        //
        txtFieldHistoryText.delegate = self
        //Set border view......
        setupViewBorderForAddSection(view: viewTxtFieldHistory)
        //Set Font For textfield and button......
        txtFieldHistoryText.font = Fonts.kStartEndValueFont
        btnAdd.titleLabel?.font = Fonts.kAcuityBtnAdd
        //Set Btn Font Color....
        btnAdd.tintColor = UIColor.white
        //Add button and textfield target....
        txtFieldHistoryText.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        btnAdd.addTarget(self, action: #selector(addHistoryText), for: UIControl.Event.touchUpInside)
        
    }
    //========================================================================================================
    //MARK: Set Font For Label
    //========================================================================================================
    func setFontForLabel(){
        lblHistoryDescription.font = Fonts.kCellHistoryDescriptionFontInAddSection
        lblHistoryText.font = Fonts.kCellHistoryTitleFontInAddSection
    }
    //MARK: Text Editing methods...
    func textFieldDidEndEditing(_ textField: UITextField) {
        //returnValue?(txtFieldHistoryText.text ?? "") // Use callback to return data
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
            let medicin = txtFieldHistoryText.text, !medicin.isEmpty
        
        else {
            btnAdd.isEnabled = false
            return
        }
        btnAdd.isEnabled = true
    }
    //MARK:- Button methods....
    @objc func addHistoryText()  {
        btnAdd.isEnabled = false
        let historyTxt = txtFieldHistoryText.text?.replacingOccurrences(of: "/s", with: "'s") ?? "";
        returnValue?(historyTxt) //
    }
    //========================================================================================================
    //MARK: Display Data..
    //========================================================================================================
    func displayData(model:HistoryInputModel){
        let historyTxt = model.name?.rawValue ?? ""
        lblHistoryText.text = historyTxt.replacingOccurrences(of: "/s", with: "'s");
        lblHistoryDescription.text = model.description ?? ""
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
  
}


class OtherHistoryTextCell: UITableViewCell,UITextFieldDelegate {

    @IBOutlet weak var lblHistoryText:UILabel!
    @IBOutlet weak var btnDelete:UIButton!
    // Declare callback function variable
    var btnDeleteCall: (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        btnDelete.addTarget(self, action: #selector(deleteHistoryText), for: UIControl.Event.touchUpInside)
    }
    //========================================================================================================
    //MARK: Delete History Text..
    //========================================================================================================
    @objc func deleteHistoryText()  {
        btnDeleteCall?() //
    }
    //========================================================================================================
    //MARK: Display Data..
    //========================================================================================================
    func displayData(historyTxt:String){
        lblHistoryText.text = historyTxt.replacingOccurrences(of: "/s", with: "'s");
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
   
}
