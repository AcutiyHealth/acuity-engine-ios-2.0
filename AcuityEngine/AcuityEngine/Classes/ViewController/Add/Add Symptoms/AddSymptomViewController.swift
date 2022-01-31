//
//  ConditionsListViewController.swift
//  AcuityEngine
//
//  Created by Bhoomi Jagani on 04/03/21.
//

import UIKit

class AddSymptomViewController: UIViewController {
    
    @IBOutlet weak var tblSymptoms: UITableView!
    @IBOutlet weak var subview: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    
    //Btn for Start and date time
    @IBOutlet weak var btnStart: UIButton!
    @IBOutlet weak var btnEnd: UIButton!
    @IBOutlet weak var lblStart: UILabel!
    @IBOutlet weak var lblEnd: UILabel!
    @IBOutlet weak var btnSave: SaveButton!
    
    var selectedButton: UIButton?
    var startDate:Date = Date()
    var endDate:Date = Date()
    
    //Date picker view...
    @IBOutlet weak var viewDatePicker: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    @IBOutlet weak var btnHeight: NSLayoutConstraint!
    //List of symptoms type...
    var symptomsArray : [SymptomsTextValue] = [SymptomsTextValue.Severe,SymptomsTextValue.Moderate,SymptomsTextValue.Mild,SymptomsTextValue.Present,SymptomsTextValue.Not_Present]
    var symptomsArrayForSleepChange : [SymptomsTextValue] = [SymptomsTextValue.Present,SymptomsTextValue.Not_Present]
    
    //Selected Sympotms type value....
    var selectedSymptoms = -1
    
    //Get from SymptomsVC for selected symptoms....
    var symptomsModel:Symptoms?{
        didSet{
            loadSymptomsData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.maximumDate = Date()
        
        let dateStr = getDateWithTime(date: datePicker.date)
        btnEnd.setTitle(dateStr, for: .normal)
        btnStart.setTitle(dateStr, for: .normal)
        
        //set fonts..
        setFontForLabel()
        //set rounded corner button.....
        setButtonRadiusAndBackgroundColor()
        //Change Height Of Button For Non Notch Device
        if !UIDevice.current.hasNotch{
            btnHeight .constant = 50
        }
        // Do any additional setup after loading the view.
    }
    
    func setFontForLabel(){
        lblTitle.font = Fonts.kCellTitleFontListInAddSection
        lblStart.font = Fonts.kStartEndTitleFont
        lblEnd.font = Fonts.kStartEndTitleFont
        btnEnd.titleLabel?.font =  Fonts.kStartEndValueFont
        btnStart.titleLabel?.font =  Fonts.kStartEndValueFont
        
    }
    
    func setButtonRadiusAndBackgroundColor(){
        btnEnd.layer.cornerRadius =  5
        btnStart.layer.cornerRadius =  5
        btnStart.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        btnEnd.backgroundColor = UIColor.white.withAlphaComponent(0.2)
    }
    func loadSymptomsData(){
        guard let symptomsModel = symptomsModel else {
            return
        }
        lblTitle.text = symptomsModel.title?.rawValue
        tblSymptoms.reloadData()
        
        //Make btn disable or enable...
        makeSaveBtnEnableOrDisable()
    }
    
    func makeSaveBtnEnableOrDisable(){
        
        if selectedSymptoms < 0{
            btnSave.isEnabled = false
            
        }else{
            btnSave.isEnabled = true
            
        }
        
        let timeInterval = endDate.timeIntervalSince(startDate)
        let days:Int = 24
        let minutes:Int = 60
        let seconds:Int = 60
        let intervalDays = timeInterval > 0 ? Int(timeInterval) / days / minutes / seconds : 0
        guard let symptomsModel = self.symptomsModel else { return  }
        if symptomsModel.title == SymptomsName.chestPain ||
            symptomsModel.title == SymptomsName.bladder_Incontinence ||
            symptomsModel.title == SymptomsName.body_Ache ||
            symptomsModel.title == SymptomsName.chills  ||
            symptomsModel.title == SymptomsName.cough ||
            symptomsModel.title == SymptomsName.dizziness ||
            symptomsModel.title == SymptomsName.fainting ||
            symptomsModel.title == SymptomsName.fever ||
            symptomsModel.title == SymptomsName.hairLoss ||
            symptomsModel.title == SymptomsName.heartburn ||
            symptomsModel.title == SymptomsName.lossOfSmell ||
            symptomsModel.title == SymptomsName.runnyNose ||
            symptomsModel.title == SymptomsName.shortnessOfBreath ||
            symptomsModel.title == SymptomsName.skippedHeartBeat ||
            symptomsModel.title == SymptomsName.soreThroat ||
            symptomsModel.title == SymptomsName.memoryLapse ||
            symptomsModel.title == SymptomsName.vomiting
        {
            
            //For above symptoms days diffrence > 4 is not allowed.
            if intervalDays > 4{
                btnSave.isEnabled = false
            }
        }else{
            //For other symptoms days diffrence > 14 is not allowed.
            if intervalDays > 14{
                btnSave.isEnabled = false
            }
        }
    }
    
    @IBAction func btnSaveClick(sender:UIButton){
        
        //Create Object For HKWriterManager
        if  self.endDate < self.startDate{
            
            let okAction = UIAlertAction(title: AlertMessages.OK, style: .default){_ in
            }
            self.showAlertForDataSaved(message: AlertMessages.STARTDATEGRATETHANENDDATE, okAction: okAction)
            
            return
        }
        
        let objWriterManager = HKWriterManager()
        var symptomValue = symptomsArray[selectedSymptoms]
        if symptomsModel?.title == SymptomsName.sleepChanges || symptomsModel?.title == SymptomsName.moodChanges{
            symptomValue = symptomsArrayForSleepChange[selectedSymptoms]
        }
        guard let symptomsModel = self.symptomsModel else { return  }
        
        HKSetupAssistance.authorizeHealthKitForAddSymptoms(caegoryTypeIdentifier: symptomsModel.healthCategoryType!) { [weak self] (success, error) in
            if success{
                objWriterManager.saveSymptomsData(categoryValue: symptomValue, caegoryTypeIdentifier: symptomsModel.healthCategoryType, startdate: self?.startDate ?? Date(), endDate: self?.endDate ?? Date()) { (error) in
                    guard let name = symptomsModel.title?.rawValue else {return}
                    if (error == nil){
                        //show alert
                        let message = "\(name) saved in health kit"
                        let okAction = self?.getOKActionForSymptomsList()
                        symptomsModel.endTimeStamp = self?.endDate.timeIntervalSince1970 ?? 0
                        self?.saveActiveSymptomsInArray(symptoms: symptomsModel, symptomValue: symptomValue)
                        self?.showAlertForDataSaved(message:message,okAction: okAction!)
                        
                    }else{
                        let message = "\(name) is not authorized.\(AlertMessages.AUTHORIZE_HEALTH_DATA)"
                        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                        self?.showAlertForDataSaved(message:message,okAction: okAction)
                    }
                }
            }else{
                
            }
        }
        
    }
    func getOKActionForSymptomsList()->UIAlertAction{
        let okAction = UIAlertAction(title: "OK", style: .default){ (_) in
            if let parentVC = self.parent {
                if let parentVC = parentVC as? SymptomsListViewController {
                    // parentVC is someViewController
                    parentVC.removeAddSymptomsViewController()
                }
            }
        }
        return okAction
    }
    
    func saveActiveSymptomsInArray(symptoms:Symptoms,symptomValue:SymptomsTextValue){
        //First filter arrayOfActiveSymptoms with current symptoms's healthcategorytype..
        var filterActiveSymptoms =  HKManagerReadSymptoms.sharedManager.arrayOfActiveSymptoms.filter({$0.healthCategoryType==symptoms.healthCategoryType})
        
        if filterActiveSymptoms.count <= 0,symptomValue != .Not_Present{
            HKManagerReadSymptoms.sharedManager.arrayOfActiveSymptoms.append(symptoms)
        }
        else {
            if filterActiveSymptoms.count > 0{
                //If data is already present, filter by endTimeStamp..
                filterActiveSymptoms.sort(by: {$0.endTimeStamp>$1.endTimeStamp})
                let mostRecentActiveSymptoms = filterActiveSymptoms.first!
                //if current symptoms endDate is older than recent symptoms, do nothing....
                if mostRecentActiveSymptoms.endTimeStamp > symptoms.endTimeStamp{
                    return
                }
                //if current symptoms endDate is older than recent symptoms and data for recent symptoms is .Not present..
                //Remove from arrayOfActiveSymptoms to make it unhighlited...
                if symptomValue == .Not_Present{
                    let firstIndexOfSymtom = HKManagerReadSymptoms.sharedManager.arrayOfActiveSymptoms.firstIndex(where: {$0.healthCategoryType==symptoms.healthCategoryType})
                    HKManagerReadSymptoms.sharedManager.arrayOfActiveSymptoms.remove(at: firstIndexOfSymtom!)
                }else{
                    //if current symptoms endDate is grater than recent symptoms and data for recent symptoms is  not .Not present..
                    //add it in arrayOfActiveSymptoms to make it highlited...
                    HKManagerReadSymptoms.sharedManager.arrayOfActiveSymptoms.append(symptoms)
                }
            }
        }
    }
    func showAlertForDataSaved(message:String,okAction:UIAlertAction){
        
        //show alert
        DispatchQueue.main.async {
            
            let vc = self.view.window?.rootViewController
            vc?.presentAlert(title: "\(Key.kAppName)",
                             message: message,
                             actions: okAction)
        }
    }
}

//MARK: Table view
extension AddSymptomViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let symptomsModel = symptomsModel else {
            return symptomsArray.count
        }
        if symptomsModel.title == SymptomsName.sleepChanges || symptomsModel.title == SymptomsName.moodChanges{
            return symptomsArrayForSleepChange.count
        }
        return symptomsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: AddSymptomsCell = tableView.dequeueReusableCell(withIdentifier: "AddSymptomsCell", for: indexPath as IndexPath) as? AddSymptomsCell else {
            fatalError("AcuityDetailDisplayCell cell is not found")
        }
        
        if symptomsModel?.title == SymptomsName.sleepChanges || symptomsModel?.title == SymptomsName.moodChanges{
            let symptom = symptomsArrayForSleepChange[indexPath.row]
            cell.displayData(title: symptom.rawValue )
        }else{
            let symptom = symptomsArray[indexPath.row]
            cell.displayData(title: symptom.rawValue )
        }
        
        cell.setBorderToCell()
        cell.selectionStyle = .none
        cell.tintColor = UIColor.white
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //Remove previously selected cell's accessorytype...
        if selectedSymptoms > -1{
            let previouslySelectedindexPath = IndexPath(row: selectedSymptoms, section: 0)
            if let cell:AddSymptomsCell = tableView.cellForRow(at: previouslySelectedindexPath) as? AddSymptomsCell {
                //cell.accessoryType = .none
                cell.setCellUnSelected()
            }
        }
        //Make new cell's accessoryType to checkmark
        if let cell:AddSymptomsCell = tableView.cellForRow(at: indexPath) as? AddSymptomsCell {
            selectedSymptoms = indexPath.row
            //cell.accessoryType = .checkmark
            cell.setCellSelected()
        }
        //Make save button selected/deselected as per selectedSymptoms's value
        makeSaveBtnEnableOrDisable()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}

//MARK: Date Picker
extension AddSymptomViewController{
    
    @IBAction func btnStartDateClick(sender:UIButton){
        viewDatePicker.isHidden = false
        selectedButton = btnStart
        guard ((btnStart.titleLabel?.text) != nil) else {
            return
        }
        datePicker.date = getDateFromString(date: btnStart.titleLabel!.text!)
    }
    
    @IBAction func btnEndDateClick(sender:UIButton){
        viewDatePicker.isHidden = false
        selectedButton = btnEnd
        guard ((btnEnd.titleLabel?.text) != nil) else {
            return
        }
        datePicker.date = getDateFromString(date: btnEnd.titleLabel!.text!)
    }
    
    @IBAction func cancelBtnClicked(_ button: UIBarButtonItem?) {
        viewDatePicker.isHidden = true
    }
    
    @IBAction func doneBtnClicked(_ button: UIBarButtonItem?) {
        viewDatePicker.isHidden = true
        
        let dateStr = getDateWithTime(date: datePicker.date)
        
        if selectedButton == btnEnd{
            endDate = datePicker.date
            btnEnd.setTitle(dateStr, for: .normal)
            //if let startDate = startDate,let endDate = endDate{
            if endDate<startDate{
                self.startDate = datePicker.date
                btnStart.setTitle(dateStr, for: .normal)
            }
            //}
        }
        else{
            startDate = datePicker.date
            btnStart.setTitle(dateStr, for: .normal)
        }
        
        makeSaveBtnEnableOrDisable()
    }
    
}
