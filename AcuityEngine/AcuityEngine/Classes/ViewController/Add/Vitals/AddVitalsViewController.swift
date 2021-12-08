//
//  AddVitalsViewController.swift
//  AcuityEngine
//
//  Created by Bhoomi Jagani on 08/03/21.
//

import UIKit
import HealthKit

class AddVitalsViewController: UIViewController {
    
    @IBOutlet weak var viewVitals: UIView!
    @IBOutlet weak var viewBloodPressure: UIView!
    @IBOutlet weak var viewOxygenSaturation: UIView!
    @IBOutlet weak var lblTitleBloodPressure: UILabel!
    @IBOutlet weak var lblTitleVital: UILabel!
    @IBOutlet weak var lblTitleOxygenSaturation: UILabel!
    @IBOutlet weak var txtFieldVital: UITextField!
    @IBOutlet weak var txtFieldOxygenSaturation: UITextField!
    @IBOutlet weak var viewVitalWithTextField: UIView!
    @IBOutlet weak var viewOxygenSaturationWithTextField: UIView!
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
    @IBOutlet weak var topConstraintForvitalsView: NSLayoutConstraint!
    @IBOutlet weak var heightConstraintForvitalsView: NSLayoutConstraint!
    
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
    //========================================================================================================
    //MARK: viewDidLoad
    //========================================================================================================
    
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
        
        //Setup Height Of Vital View according to device height...
        heightConstraintForvitalsView.constant = heightConstraintForvitalsView.constant + (heightConstraintForvitalsView.constant*(DeviceSize.screenHeight)/CGFloat(Screen.iPhoneSEHeight))/4.5
        // Do any additional setup after loading the view.
    }
    
    //========================================================================================================
    //MARK: Show View As Per Vital
    //========================================================================================================
    
    func showViewAsPerVital(){
        /*
         Note: viewVitals will use for display all other vital except Oxygen Saturation and Blood Pressure
         viewBloodPressure will use for display blood pressure
         viewOxygenSaturation will use for display oxygen saturation..
         */
        if vitalModel?.name == VitalsName.bloodPressure {
            viewVitals.isHidden = false
            viewBloodPressure.isHidden = false
            viewEnd.isHidden = true
            viewOxygenSaturation.isHidden = true
        }
        else if vitalModel?.name == VitalsName.oxygenSaturation {
            viewOxygenSaturation.isHidden = false
            viewVitals.isHidden = false
            viewBloodPressure.isHidden = true
            viewEnd.isHidden = true
        }
        else if vitalModel?.name == VitalsName.heartRate || vitalModel?.name == VitalsName.InhalerUsage || vitalModel?.name == VitalsName.peakflowRate ||  vitalModel?.name == VitalsName.BMI || vitalModel?.name == VitalsName.temperature || vitalModel?.name == VitalsName.weight || vitalModel?.name == VitalsName.bloodSugar || vitalModel?.name == VitalsName.vo2Max || vitalModel?.name == VitalsName.respiratoryRate  || vitalModel?.name == VitalsName.headPhoneAudioLevel || vitalModel?.name == VitalsName.stepLength {
            /*
             Hide BP view and Oxygen Saturation View
             */
            viewVitals.isHidden = false
            viewBloodPressure.isHidden = true
            viewOxygenSaturation.isHidden = true
            viewEnd.isHidden = true
            topConstraintForvitalsView.constant = -(viewBloodPressure.frame.size.height-25)
            
        }
        else if vitalModel?.name == VitalsName.irregularRhymesNotification || vitalModel?.name == VitalsName.highHeartRate || vitalModel?.name == VitalsName.lowHeartRate{
            viewVitals.isHidden = true
            viewBloodPressure.isHidden = true
            viewEnd.isHidden = false
            btnSave.isEnabled = true
            topConstraintForStartEndView.constant = -45
        }
        
    }
    //========================================================================================================
    //MARK: Set Font For Label
    //========================================================================================================
    
    func setFontForLabel(){
        lblTitleBloodPressure.font = Fonts.kAcuityAddDetailTitleFont
        lblTitleVital.font = Fonts.kAcuityAddDetailTitleFont
        lblTitleOxygenSaturation.font = Fonts.kAcuityAddDetailTitleFont
        lblStart.font = Fonts.kStartEndTitleFont
        lblEnd.font = Fonts.kStartEndTitleFont
        txtFieldVital.font = Fonts.kStartEndValueFont
        txtFieldBP1.font = Fonts.kStartEndValueFont
        txtFieldBP2.font = Fonts.kStartEndValueFont
        btnEnd.titleLabel?.font =  Fonts.kStartEndValueFont
        btnStart.titleLabel?.font =  Fonts.kStartEndValueFont
        
        
        setupViewBorderForAddSection(view: viewBP1)
        setupViewBorderForAddSection(view: viewBP2)
        setupViewBorderForAddSection(view: viewVitalWithTextField)
        setupViewBorderForAddSection(view: viewOxygenSaturationWithTextField)
    }
    //========================================================================================================
    //MARK: SetUp Design For Date Buttons
    //========================================================================================================
    
    func setUpDesignForDateButtons(){
        btnEnd.layer.cornerRadius = 5;
        btnStart.layer.cornerRadius = 5;
        btnEnd.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        btnStart.backgroundColor = UIColor.white.withAlphaComponent(0.2)
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
        
        txtFieldVital.inputAccessoryView = numberToolbar //do it for every relevant textfield if there are more than one
        txtFieldBP1.inputAccessoryView = numberToolbar //do it for every relevant textfield if there are more than one
        txtFieldBP2.inputAccessoryView = numberToolbar //do it for every relevant textfield if there are more than one
        txtFieldOxygenSaturation.inputAccessoryView = numberToolbar
    }
    //========================================================================================================
    //MARK: Donebutton Clicked In NumberToolbar
    //========================================================================================================
    
    @objc func donebuttonClickedInNumberToolbar(){
        self.view.endEditing(true)
    }
    //========================================================================================================
    //MARK: Load Vitals Data
    //========================================================================================================
    
    func loadVitalsData(){
        guard let vitalModel = vitalModel else {
            return
        }
        switch vitalModel.name {
        case .oxygenSaturation:
            lblTitleOxygenSaturation.text = String("Oxygen Saturation %")
            lblTitleVital.text = VitalsName.heartRate.rawValue
        case .bloodPressure:
            lblTitleBloodPressure.text = vitalModel.name.rawValue
            lblTitleVital.text = VitalsName.heartRate.rawValue
            
        default:
            lblTitleVital.text = vitalModel.name.rawValue
        }
        
        //Make btn disable or enable...
        btnSave.isEnabled = false
        //view will be change as per vital
        showViewAsPerVital()
        
    }
    
    //========================================================================================================
    //MARK: Btn Save Click
    //========================================================================================================
    
    @IBAction func btnSaveClick(sender:UIButton){
        
        //Create Object For HKWriterManager
        let objWriterManager = HKWriterManager()
        
        //Textfield For all vitals except blood pressure
        let vitalValue = Double(self.txtFieldVital.text ?? "0")
        //Textfield For oxygenSaturation
        let oxygenSaturationValue = Double(self.txtFieldOxygenSaturation.text ?? "0")
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
                    self?.vitalModel?.name == VitalsName.vo2Max ||
                    self?.vitalModel?.name == VitalsName.respiratoryRate || self?.vitalModel?.name == VitalsName.stepLength {
                    
                    self?.saveVitalsDataInHealthKit(vitalModel: (self?.vitalModel)!, objWriterManager: objWriterManager, quantityValue: vitalValue ?? 0, quantityTypeIdentifier: self?.vitalModel?.healthQuantityType) { (error) in
                        
                        let message = "\(String(describing: vitalModel.name!.rawValue)) saved in health kit"
                        self?.vitalsSavedSuccessfully(message: message)
                    }
                    
                }
                else  if
                    self?.vitalModel?.name == VitalsName.oxygenSaturation
                {
                    /*
                     Oxygen Saturation and Heart Rate to save in Healthkit..
                     */
                    self?.saveVitalsDataInHealthKit(vitalModel: (self?.vitalModel)!, objWriterManager: objWriterManager, quantityValue: oxygenSaturationValue ?? 0, quantityTypeIdentifier: self?.vitalModel?.healthQuantityType) { (error) in
                        
                        /*
                         Note: After saving O2 in health kit call Heart Rate to save in Healthkit...
                         */
                        if let vitalValue = vitalValue{
                            let heartRateVitalModel = VitalModel(name: VitalsName.heartRate)
                            heartRateVitalModel.healthQuantityType = .heartRate
                            if error == nil{
                                self?.saveVitalsDataInHealthKit(vitalModel: heartRateVitalModel, objWriterManager: objWriterManager, quantityValue: vitalValue , quantityTypeIdentifier: heartRateVitalModel.healthQuantityType) { (error) in
                                    
                                    if error == nil{
                                        let message = "Oxygen Saturation and Heart Rate saved in health kit"
                                        self?.vitalsSavedSuccessfully(message: message)
                                    }
                                }
                            }
                        }else{
                            let message = "Oxygen Saturation saved in health kit"
                            self?.vitalsSavedSuccessfully(message: message)
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
                            
                            self?.saveBloodPressurexDataInHealthKit(bpSystolic: bpSystolic, bpDiastolic: bpDiastolic, objWriterManager: objWriterManager) { (error) in
                                
                                /*
                                 Note: After saving BP in health kit call Heart Rate to save in Healthkit...
                                 */
                                if let vitalValue = vitalValue{
                                    let heartRateVitalModel = VitalModel(name: VitalsName.heartRate)
                                    heartRateVitalModel.healthQuantityType = .heartRate
                                    if error == nil{
                                        self?.saveVitalsDataInHealthKit(vitalModel: (heartRateVitalModel), objWriterManager: objWriterManager, quantityValue: vitalValue, quantityTypeIdentifier: heartRateVitalModel.healthQuantityType) { (error) in
                                            
                                            if error == nil{
                                                let message = "Blood Pressure and Heart Rate saved in health kit"
                                                self?.vitalsSavedSuccessfully(message: message)
                                            }
                                        }
                                    }
                                }else{
                                    let message = "Blood Pressure saved in health kit"
                                    self?.vitalsSavedSuccessfully(message: message)
                                }
                            }
                            
                            
                            //Save Heart Rate Data.....
                        }
                    })
                }
            }else{
                print(error ?? "")
            }
        })
    }
    //========================================================================================================
    //MARK: Save Vitals Data except Blood Pressure
    //========================================================================================================
    
    
    func saveVitalsDataInHealthKit(vitalModel:VitalModel,objWriterManager:HKWriterManager,quantityValue: Double,quantityTypeIdentifier:HKQuantityTypeIdentifier?,completion: @escaping (Error?) -> Swift.Void){
        objWriterManager.saveQuantityData(value: quantityValue, quantityTypeIdentifier: quantityTypeIdentifier, date: self.startDate ?? Date()) {[weak self] (error) in
            
            if (error == nil){
                
                completion(nil)
                
            }else{
                let message = "\(String(describing: vitalModel.name!.rawValue)) is not authorized. \(AlertMessages.AUTHORIZE_HEALTH_DATA)"
                self?.vitalsSavedFailed(message: message)
                completion(error)
            }
        }
    }
    //========================================================================================================
    //MARK: Save Vitals Blood Pressure
    //========================================================================================================
    
    
    func saveBloodPressurexDataInHealthKit(bpSystolic:Double,bpDiastolic:Double,objWriterManager:HKWriterManager,completion: @escaping (Error?) -> Swift.Void){
        objWriterManager.storeBloodPressure(systolic: bpSystolic, diastolic: bpDiastolic, date: self.startDate ?? Date()) { [weak self] (error) in
            if (error == nil){
                completion(nil)
            }
            else{
                let message = "\(String(describing: VitalsName.bloodPressure.rawValue)) is not authorized. \(AlertMessages.AUTHORIZE_HEALTH_DATA)"
                self?.vitalsSavedFailed(message: message)
                completion(error)
            }
        }
    }
    //========================================================================================================
    //MARK: Show Alert For Success of Data Save in Healthkit
    //========================================================================================================
    func vitalsSavedSuccessfully(message:String){
        let okAction = self.getOKActionForVitalList()
        self.showAlertForDataSaved(message:message,okAction: okAction)
    }
    //========================================================================================================
    //MARK: Show Alert For Fail of Data Save in Healthkit
    //========================================================================================================
    
    func vitalsSavedFailed(message:String){
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        self.showAlertForDataSaved(message:message,okAction: okAction)
    }
    
    //========================================================================================================
    //MARK:Get OK Action For VitalList
    //========================================================================================================
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
    //MARK: editingChanged in Textfield
    //========================================================================================================
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
        }else if vitalModel?.name == VitalsName.oxygenSaturation {
            guard
                let _ = txtFieldOxygenSaturation.text,(txtFieldOxygenSaturation.text != nil),!txtFieldOxygenSaturation.text!.isEmpty
            else {
                btnSave.isEnabled = false
                return
            }
            btnSave.isEnabled = true
        }
        else{
            guard
                let _ = txtFieldVital.text,!txtFieldVital.text!.isEmpty
            else {
                btnSave.isEnabled = false
                return
            }
            btnSave.isEnabled = true
        }
        
    }
}
//========================================================================================================
//MARK: extension AddVitalsViewController
//========================================================================================================

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
