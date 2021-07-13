//
//  AddVitalsViewController.swift
//  AcuityEngine
//
//  Created by Bhoomi Jagani on 08/03/21.
//

import UIKit
import HealthKit

class AddVitalsViewController: UIViewController {
    
    @IBOutlet weak var vitalsView: UIView!
    @IBOutlet weak var bloddPressureView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var txtFieldValue: UITextField!
    @IBOutlet weak var viewValue: UIView!
    @IBOutlet weak var txtFieldBP1: UITextField!
    @IBOutlet weak var viewBP1: UIView!
    @IBOutlet weak var txtFieldBP2: UITextField!
    @IBOutlet weak var viewBP2: UIView!
    
    //Btn for Start and date time
    @IBOutlet weak var viewStart: UIView!
    @IBOutlet weak var viewEnd: UIView!
    @IBOutlet weak var btnStart: UIButton!
    @IBOutlet weak var btnEnd: UIButton!
    @IBOutlet weak var lblStart: UILabel!
    @IBOutlet weak var lblEnd: UILabel!
    @IBOutlet weak var btnSave: SaveButton!
    
    @IBOutlet weak var topConstraintForStartEndView: NSLayoutConstraint!
    
    var selectedButton: UIButton?
    var startDate:Date?
    var endDate:Date?
    
    //Date picker view...
    @IBOutlet weak var viewDatePicker: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var btnHeight: NSLayoutConstraint!
    
    //Get from SymptomsVC for selected symptoms....
    var vitalModel:VitalModel?{
        didSet{
            
            loadVitalsData()
            
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
        //set up UI for buttons....
        setUpDesignForDateButtons()
        //Setup Toolbar For Number Pad...
        setupToolbarForNumberPad()
        
        if !UIDevice.current.hasNotch{
            btnHeight.constant = 50
        }
        // Do any additional setup after loading the view.
    }
    func showViewAsPerVital(){
        if vitalModel?.name == VitalsName.bloodPressure {
            vitalsView.isHidden = true
            bloddPressureView.isHidden = false
            viewEnd.isHidden = true
            
        }
        else if vitalModel?.name == VitalsName.heartRate || vitalModel?.name == VitalsName.InhalerUsage || vitalModel?.name == VitalsName.peakflowRate ||  vitalModel?.name == VitalsName.BMI || vitalModel?.name == VitalsName.temperature || vitalModel?.name == VitalsName.weight || vitalModel?.name == VitalsName.bloodSugar || vitalModel?.name == VitalsName.oxygenSaturation || vitalModel?.name == VitalsName.vo2Max || vitalModel?.name == VitalsName.respiratoryRate  || vitalModel?.name == VitalsName.headPhoneAudioLevel || vitalModel?.name == VitalsName.stepLength {
            vitalsView.isHidden = false
            bloddPressureView.isHidden = true
            viewEnd.isHidden = true
            
        }
        else if vitalModel?.name == VitalsName.irregularRhymesNotification || vitalModel?.name == VitalsName.highHeartRate || vitalModel?.name == VitalsName.lowHeartRate{
            vitalsView.isHidden = true
            bloddPressureView.isHidden = true
            viewEnd.isHidden = false
            btnSave.isEnabled = true
            topConstraintForStartEndView.constant = -45
        }
    }
    func setFontForLabel(){
        lblTitle.font = Fonts.kAcuityDetailTitleFont
        lblStart.font = Fonts.kCellTitleFont
        lblEnd.font = Fonts.kCellTitleFont
        txtFieldValue.font = Fonts.kValueFont
        txtFieldBP1.font = Fonts.kValueFont
        txtFieldBP2.font = Fonts.kValueFont
        btnEnd.titleLabel?.font =  Fonts.kValueFont
        btnStart.titleLabel?.font =  Fonts.kValueFont
       
        
        setupViewBorder(view: viewBP1)
        setupViewBorder(view: viewBP2)
        setupViewBorder(view: viewValue)
    }
    
    func setUpDesignForDateButtons(){
        btnEnd.layer.cornerRadius = 5;
        btnStart.layer.cornerRadius = 5;
        btnEnd.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        btnStart.backgroundColor = UIColor.white.withAlphaComponent(0.2)
    }
    
    func setupViewBorder(view:UIView){
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 5
        view.layer.borderColor = UIColor.white.cgColor
        view.backgroundColor = UIColor.white.withAlphaComponent(0.3)
    }
    //MARK:--------------------------------------
    //MARK: Setup Toolbar For Number Pad...
    func setupToolbarForNumberPad(){
        let numberToolbar: UIToolbar = UIToolbar()
        numberToolbar.barStyle = UIBarStyle.default
        numberToolbar.items=[
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(donebuttonClickedInNumberToolbar))
        ]
        
        numberToolbar.sizeToFit()
        
        txtFieldValue.inputAccessoryView = numberToolbar //do it for every relevant textfield if there are more than one
        txtFieldBP1.inputAccessoryView = numberToolbar //do it for every relevant textfield if there are more than one
        txtFieldBP2.inputAccessoryView = numberToolbar //do it for every relevant textfield if there are more than one
    }
    
    @objc func donebuttonClickedInNumberToolbar(){
        self.view.endEditing(true)
    }
    //MARK:--------------------------------------
    func loadVitalsData(){
        guard let vitalModel = vitalModel else {
            return
        }
        switch vitalModel.name {
        case .oxygenSaturation:
            lblTitle.text = String("Oxygen Saturation %")
        default:
            lblTitle.text = vitalModel.name.rawValue
        }
        
        //Make btn disable or enable...
        btnSave.isEnabled = false
        //view will be change as per vital
        showViewAsPerVital()
        
    }
    
    func makeSaveBtnEnableOrDisable(){
        
    }
    
    @IBAction func btnSaveClick(sender:UIButton){
        
        //Create Object For HKWriterManager
        let objWriterManager = HKWriterManager()
        
        //Textfield For all vitals except blood pressure
        let quantityValue = Double(self.txtFieldValue.text ?? "0")
        //Textfiled for blood presure..
        let bpSystolic = Double(self.txtFieldBP1.text ?? "0") ?? 0
        let bpDiastolic = Double(self.txtFieldBP2.text ?? "0") ?? 0
        
        //Get quantityTypeIdentifier for all vital to store and authorize
        guard let healthQuantityType = self.vitalModel?.healthQuantityType else {return}
        guard let vitalModel = self.vitalModel else { return  }
        
        //Authorzie all vital by it's quantityTypeIdentifier
        HKSetupAssistance.authorizeHealthKitForAddVitals(quantityTypeIdentifier: healthQuantityType, completion: { [weak self] (success, error) in
            
            //Authorize successful, then save it in Healthkit...
            //If they didn't authorize show alrert to authorize it from settings..
            if success{
                
                if self?.vitalModel?.name == VitalsName.heartRate ||
                    self?.vitalModel?.name == VitalsName.InhalerUsage ||
                    self?.vitalModel?.name == VitalsName.peakflowRate ||
                    self?.vitalModel?.name == VitalsName.BMI ||
                    self?.vitalModel?.name == VitalsName.temperature ||
                    self?.vitalModel?.name == VitalsName.weight || self?.vitalModel?.name == VitalsName.bloodSugar ||
                    self?.vitalModel?.name == VitalsName.oxygenSaturation ||
                    self?.vitalModel?.name == VitalsName.vo2Max ||
                    self?.vitalModel?.name == VitalsName.respiratoryRate || self?.vitalModel?.name == VitalsName.stepLength {
                    
                    objWriterManager.saveQuantityData(value: quantityValue ?? 0, quantityTypeIdentifier: self?.vitalModel?.healthQuantityType, date: self?.startDate ?? Date()) { (error) in
                        
                        if (error == nil){
                            //show alert
                            let message = "\(String(describing: vitalModel.name!.rawValue)) saved in health kit"
                            let okAction = self?.getOKActionForVitalList()
                            self?.showAlertForDataSaved(message:message,okAction: okAction!)
                            
                        }else{
                            let message = "\(String(describing: vitalModel.name!.rawValue)) is not authorized. You can authorized it by making Turn on from Settings -> Health -> DATA -> \(appName) -> Health Data"
                            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                            self?.showAlertForDataSaved(message:message,okAction: okAction)
                        }
                    }
                    
                }
                //If it's blood pressure....
                //For Systolic current vital model has quantityTypeIdentifier set to Systolic.
                //Blood pressure needs Systolic and Diastolic to save in healthkit
                //Systolic was authorize in first step...Diastolic need to authorize...
                
                else if  self?.vitalModel?.name == VitalsName.bloodPressure  {
                    
                    //bloodPressureDiastolic will authorize...
                    let healthQuantityType:HKQuantityTypeIdentifier = .bloodPressureDiastolic
                    HKSetupAssistance.authorizeHealthKitForAddVitals(quantityTypeIdentifier: healthQuantityType, completion: { [weak self] (success, error) in
                        
                        //If success in authorization..save it in healthkit...
                        //Both bpSystolic and bpDiastolic...
                        if success{
                            
                            objWriterManager.storeBloodPressure(systolic: bpSystolic, diastolic: bpDiastolic, date: self?.startDate ?? Date()) { [self] (error) in
                                if (error == nil){
                                    //show alert
                                    let okAction = self?.getOKActionForVitalList()
                                    self?.showAlertForDataSaved(message: "Blood Pressure saved in health kit",okAction: okAction!)
                                }
                                else{
                                    let message = "\(String(describing: vitalModel.name!.rawValue)) is not authorized. You can authorized it by making Turn on from Settings -> Health -> DATA -> \(appName ) -> Health Data"
                                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                                    self?.showAlertForDataSaved(message:message,okAction: okAction)
                                }
                            }
                        }
                    })
                }
            }else{
                print(error ?? "")
            }
        })
    }
    
    func getOKActionForVitalList()->UIAlertAction{
        let okAction = UIAlertAction(title: "OK", style: .default){ (_) in
            if let parentVC = self.parent {
                if let parentVC = parentVC as? VitalsListViewController {
                    // parentVC is someViewController
                    parentVC.removeAddVitalsViewController()
                }
            }
        }
        return okAction
    }
    
    
    func showAlertForDataSaved(message:String,okAction:UIAlertAction){
        
        //show alert
        DispatchQueue.main.async {
            
            
            
            // Please enable camera access from Settings > AppName > Camera to take photos
            
            let vc = self.parent
            vc?.presentAlert(title: "\(appName)",
                             message: message,
                             actions: okAction)
        }
    }
    @IBAction func editingChanged(_ textField: UITextField) {
        if textField.text?.count == 1 {
            if textField.text?.first == " " {
                textField.text = ""
                return
            }
        }
        if vitalModel?.name == VitalsName.bloodPressure {
            guard
                let _ = txtFieldBP1.text,(txtFieldBP2.text != nil),!txtFieldBP2.text!.isEmpty,!txtFieldBP1.text!.isEmpty
            else {
                btnSave.isEnabled = false
                return
            }
            btnSave.isEnabled = true
        }else{
            guard
                let _ = txtFieldValue.text,!txtFieldValue.text!.isEmpty
            else {
                btnSave.isEnabled = false
                return
            }
            btnSave.isEnabled = true
        }
        
    }
}

//MARK: Date Picker
extension AddVitalsViewController{
    
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
            if let startDate = startDate,let endDate = endDate{
                if endDate<startDate{
                    self.startDate = datePicker.date
                    btnStart.setTitle(dateStr, for: .normal)
                }
            }
        }
        else{
            startDate = datePicker.date
            btnStart.setTitle(dateStr, for: .normal)
            
        }
        
    }
    
}
