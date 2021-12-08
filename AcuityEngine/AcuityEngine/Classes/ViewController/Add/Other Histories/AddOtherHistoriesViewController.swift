//
//  AddOtherHistoriesViewController.swift
//  AcuityEngine
//
//  Created by Bhoomi Jagani on 24/09/21.
//

import UIKit
import SVProgressHUD

typealias completionOfHistoryAdded = (_ model: HistoryDataDisplayModel?) -> Void

class AddOtherHistoriesViewController:UIViewController,UITextViewDelegate {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblMaxLimit: UILabel!
    @IBOutlet weak var txtViewHistory: UITextView!
    @IBOutlet weak var viewHistory: UIView!
    @IBOutlet weak var btnSave:SaveButton!
    var modelFromSuperView: HistoryDataDisplayModel?
    var handler: completionOfHistoryAdded?
    @IBOutlet weak var btnHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set Font For LAbel
        setFontForLabels()
        //Setup Toolbar For Number Pad...
        setupToolbarForNumberPad()
        //
        setupViewBorderForAddSection(view: viewHistory)
        //Change Height Of Button For Non Notch Device
        if !UIDevice.current.hasNotch{
            btnHeight .constant = 50
        }
    }
    //========================================================================================================
    //MARK: Set Font For Labels..
    //========================================================================================================
    func setFontForLabels(){
        lblTitle.font = Fonts.kCellTitleFontListInAddSection
        txtViewHistory.font = Fonts.kStartEndValueFont
        lblMaxLimit.font = Fonts.kAcuityAddOptionMaxLimitFont
    }
    //========================================================================================================
    //MARK: setHandler..
    //========================================================================================================
    func setHandler(handler: @escaping completionOfHistoryAdded){
        self.handler = handler
    }
    //========================================================================================================
    //MARK: Setup Toolbar For Number Pad...
    //========================================================================================================
    
    func setupToolbarForNumberPad(){
        let numberToolbar: UIToolbar = UIToolbar()
        numberToolbar.barStyle = UIBarStyle.default
        numberToolbar.items=[
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(donebuttonClickedInNumberToolbar))
        ]
        
        numberToolbar.sizeToFit()
        
        txtViewHistory.inputAccessoryView = numberToolbar //do it for every relevant textfield if there are more than one
        
    }
    //========================================================================================================
    //MARK: Donebutton Clicked In NumberToolbar
    //========================================================================================================
    
    @objc func donebuttonClickedInNumberToolbar(){
        self.view.endEditing(true)
    }
    //========================================================================================================
    //MARK: Btn Save Click
    //========================================================================================================
    
    @IBAction func btnSaveClick(sender:UIButton){
        guard let _ = modelFromSuperView else { return }
        modelFromSuperView?.txtValue = txtViewHistory.text.trimmingCharacters(in: .whitespaces)
        modelFromSuperView?.timeStamp = getTimeStampForCurrenTime()
        addHistory()
    }
    //MARK:- Add History Data
    func addHistory() {
        //========================================================================//
        self.view.endEditing(true)
        //===========Global Queue========//
        
        Utility.showSVProgress()
        DispatchQueue.global(qos: .background).async {
            DBManager.shared.insertHistoryData(model: self.modelFromSuperView!) { [weak self] (success, error) in
                Utility.hideSVProgress()
                DispatchQueue.main.async {
                    if error == nil && success == true{
                        
                        if let handler = self?.handler{
                            handler((self?.modelFromSuperView)! as HistoryDataDisplayModel)
                        }
                        self?.historysSavedSuccessfully(message: AlertMessages.SUCCESS_HISTORY_SAVE)
                    }else{
                        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                        self?.showAlertForDataSaved(message:AlertMessages.ERROR_HISTORY_SAVE,okAction: okAction)
                    }
                }
            }
            
        }
    }
    //========================================================================================================
    //MARK: Show Alert For Success of Data Save in Healthkit
    //========================================================================================================
    func historysSavedSuccessfully(message:String){
        let okAction = self.getOKActionForhistoryList()
        self.showAlertForDataSaved(message:message,okAction: okAction)
    }
    //========================================================================================================
    //MARK:Get OK Action For historyList
    //========================================================================================================
    func getOKActionForhistoryList()->UIAlertAction{
        let okAction = UIAlertAction(title: "OK", style: .default){ (_) in
            if let parentVC = self.parent {
                if let parentVC = parentVC as? HistoryValueListViewController {
                    parentVC.removeAddHistoryViewController()
                }
            }
        }
        return okAction
    }
    //========================================================================================================
    //MARK: Show Alert For Data Saved
    //========================================================================================================
    func showAlertForDataSaved(message:String,okAction:UIAlertAction){
        
        //show alert
        DispatchQueue.main.async {
            
            let vc = self.view.window?.rootViewController
            vc?.presentAlert(title: "\(Key.kAppName)",
                             message: message,
                             actions: okAction)
        }
    }
    //========================================================================================================
    //MARK: Textview Delegate
    //========================================================================================================
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return textView.text.count + (text.count - range.length) <= 250
    }
    func textViewDidChange(_ textView: UITextView)  {
        if textView.text?.count == 1 {
            if textView.text?.first == " " {
                textView.text = ""
                return
            }
        }
        
        if textView == self.txtViewHistory {
            self.btnSave.isEnabled = !textView.text.isEmpty
        }
        
    }
    func textView(textView: UITextView, range: NSRange, replacementText text: String) -> Bool
    {
        if (!textView.text.isEmpty) {
            btnSave.isEnabled = true
        } else {
            btnSave.isEnabled = false
        }
        return true
    }
}
