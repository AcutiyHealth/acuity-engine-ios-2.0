//
//  AddMedicationsViewController.swift
//  AcuityEngine
//
//  Created by Bhoomi Jagani on 24/09/21.
//

import UIKit
import SVProgressHUD


class AddMedicationsViewController: UIViewController {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var tblMedication: UITableView!
    @IBOutlet weak var viewMedication: UIView!
    @IBOutlet weak var txtViewMedication: UITextView!
    @IBOutlet weak var btnSave: SaveButton!
    var arrayForTblDataView:[MedicationDataDisplayModel] = []
    @IBOutlet weak var btnHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set Font For LAbel
        setFontForLabels()
        //
        setupViewBorderForAddSection(view: viewMedication)
        //Change Height Of Button For Non Notch Device
        if !UIDevice.current.hasNotch{
            btnHeight .constant = 50
        }
        //Setup Toolbar For Number Pad...
        setupToolbarForNumberPad()
        //======= Fetch Data from Database for tblMedicationDataView======== //
        fetchMedicationDataFromDatabase()
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
        
        txtViewMedication.inputAccessoryView = numberToolbar //do it for every relevant textfield if there are more than one
        
    }
    //========================================================================================================
    //MARK: Donebutton Clicked In NumberToolbar
    //========================================================================================================
    
    @objc func donebuttonClickedInNumberToolbar(){
        self.view.endEditing(true)
    }
    //========================================================================================================
    //MARK: Set Handler..
    //========================================================================================================
    //    func setHandler(handler: @escaping CompletionhistoryValueListViewOpen){
    //        self.handler = handler
    //    }
    //
    //========================================================================================================
    //MARK: Set Font For Labels..
    //========================================================================================================
    func setFontForLabels(){
        lblTitle.font = Fonts.kCellTitleFontListInAddSection
    }
    //========================================================================================================
    //MARK: Fetch Medication Data From Database..
    //========================================================================================================
    
    func fetchMedicationDataFromDatabase(){
        //Global Queue
        Utility.showSVProgress()
        DispatchQueue.global(qos: .background).async {
            
            //Fetch data......
            
            let medicationData = DBManager.shared.loadMedications()
            //Main Queue......
            DispatchQueue.main.async {
                /*
                 After fetching data from dataabse, prepare array of dicitonary. Dictionary will have key -> title of section and Value -> Array
                 Filter data with Id of Histyory type and fetch Medication Name and MAke it's key. Sp E.g. If id = 1, name will be otherCondition and key will be of other condition. IT will have value which have Id = 1 in database..
                 MedicationDataDisplayModel will have Id,name and textValue and TimeStamp...
                 */
                if (medicationData != nil) && medicationData?.count ?? 0 > 0{
                    self.arrayForTblDataView.append(contentsOf: medicationData!)
                }
                if self.arrayForTblDataView.count <= 0{
                    setNoDataInfoIfRecordsNotExists(tblView: self.tblMedication,font: Fonts.kCellHistoryDataValueFontInAddSection)
                }
                self.tblMedication.reloadData()
                
                SVProgressHUD.dismiss()
            }
            
        }
    }
    //========================================================================================================
    //MARK: Btn Save Click
    //========================================================================================================
    
    @IBAction func btnSaveClick(sender:UIButton){
        let txtStr = (txtViewMedication.text ?? "").trimmingCharacters(in: .whitespaces)
        let medicationModel = MedicationDataDisplayModel(txtValue: txtStr, timeStamp: getTimeStampForCurrenTime())
        addMedication(medicationModel: medicationModel)
    }
    //MARK:- Add History Data
    func addMedication(medicationModel:MedicationDataDisplayModel) {
        //========================================================================//
        self.view.endEditing(true)
        //===========Global Queue========//
        
        Utility.showSVProgress()
        DispatchQueue.global(qos: .background).async {
            DBManager.shared.insertMedicationData(model: medicationModel) { [weak self] (success, error) in
                Utility.hideSVProgress()
                DispatchQueue.main.async {
                    if error == nil && success == true{
                        //show alert
                        self?.arrayForTblDataView.append(medicationModel)
                        let vc = self?.view.window?.rootViewController
                        guard let vc = vc else { return }
                        Utility.showAlertWithOKBtn(onViewController: vc, title: MetricsType.Medication.rawValue, message: AlertMessages.SUCCESS_MEDICATION_SAVE)
                        
                    }else{
                        let vc = self?.view.window?.rootViewController
                        guard let vc = vc else { return }
                        Utility.showAlertWithOKBtn(onViewController: vc, title: MetricsType.Medication.rawValue, message: AlertMessages.ERROR_MEDICATION_SAVE)
                    }
                    self?.reloadTable()
                }
            }
            
        }
    }
    
}

extension AddMedicationsViewController:UITableViewDelegate,UITableViewDataSource,UITextViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayForTblDataView.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return HEIGHT_OF_ROW_IN_TBL_INPUT_VIEW;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:MedicationTextCell = tblMedication.dequeueReusableCell(withIdentifier: "MedicationTextCell", for: indexPath) as! MedicationTextCell
        
        //========================================================================//
        let medicationModel = arrayForTblDataView[indexPath.row]
        cell.btnDeleteCall = {
            if let parentVC = self.view.window?.rootViewController {
                let deleteAction = UIAlertAction(title: Titles.BTN_DELETE, style: .destructive, handler: { (action: UIAlertAction!) in
                    //Delete Medication....
                    self.deleteOne(indexPath, model: medicationModel)
                })
                let cancelAction = UIAlertAction(title: Titles.BTN_CANCEL, style: .default, handler: { (action: UIAlertAction!) in
                    //Hide Alert
                    
                })
                parentVC.presentAlert(title: AlertMessages.DELETE_CONFIRMATION_TITLE, message: AlertMessages.DELETE_CONFIRMATION_MESSAGE, actions: cancelAction,deleteAction)
            }
            
        }
        cell.displayData(medicationTxt: medicationModel.txtValue ?? "")
        
        return cell;
        
    }
    
    //MARK: Delete History Data
    func deleteOne(_ indexPath: IndexPath,model:MedicationDataDisplayModel) {
        
        //===========Global Queue========//
        //==========Add row in table and update table===========//
        Utility.showSVProgress()
        DispatchQueue.global(qos: .background).async {
            let isSuccess = DBManager.shared.deleteMedication(model: model)
            DispatchQueue.main.async {
                if isSuccess{
                    Utility.hideSVProgress()
                    //====== Remove value at index =======//
                    self.arrayForTblDataView.remove(at:indexPath.row)
                    if let parentVC = self.view.window?.rootViewController {
                        Utility.showAlertWithOKBtn(onViewController: parentVC, message: AlertMessages.SUCCESS_MEDICATION_DELETE)
                    }
                    
                    self.perform(#selector(self.reloadTable), with: nil, afterDelay: 1)
                }
                //===========================================//
            }
        }
        
    }
    @objc func reloadTable() {
        DispatchQueue.main.async { //please do all interface updates in main thread only
            self.tblMedication.backgroundView = nil
            if self.arrayForTblDataView.count <= 0{
                setNoDataInfoIfRecordsNotExists(tblView: self.tblMedication,font: Fonts.kCellHistoryDataValueFontInAddSection)
            }
            self.tblMedication.reloadData()
            
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
        
        if textView == self.txtViewMedication {
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





