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
        
        if !UIDevice.current.hasNotch{
            btnHeight.constant = 50
        }
        // Do any additional setup after loading the view.
    }
    func showViewAsPerVital(){
        if vitalModel?.name == VitalsName.BloodPressure {
            vitalsView.isHidden = true
            bloddPressureView.isHidden = false
            viewEnd.isHidden = true
            
        }
        else if vitalModel?.name == VitalsName.heartRate || vitalModel?.name == VitalsName.InhalerUsage || vitalModel?.name == VitalsName.peakflowRate ||  vitalModel?.name == VitalsName.BMI || vitalModel?.name == VitalsName.Temperature || vitalModel?.name == VitalsName.weight || vitalModel?.name == VitalsName.bloodSuger || vitalModel?.name == VitalsName.OxygenSaturation || vitalModel?.name == VitalsName.vo2Max || vitalModel?.name == VitalsName.respiratoryRate  || vitalModel?.name == VitalsName.headPhoneAudioLevel || vitalModel?.name == VitalsName.stepLength {
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
    
    func setupViewBorder(view:UIView){
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.white.cgColor
    }
    func loadVitalsData(){
        guard let vitalModel = vitalModel else {
            return
        }
        lblTitle.text = vitalModel.name.rawValue
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
        
        //Get value of textfield in variable...
        let quantityValue = Double(self.txtFieldValue.text ?? "0")
        let bpSystolic = Double(self.txtFieldBP1.text ?? "0") ?? 0
        let bpDiastolic = Double(self.txtFieldBP2.text ?? "0") ?? 0
        HKSetupAssistance.authorizeHealthKitForAddVitals { [weak self] (success, error) in
            
            if success{
                
                if self?.vitalModel?.name == VitalsName.heartRate ||
                    self?.vitalModel?.name == VitalsName.InhalerUsage ||
                    self?.vitalModel?.name == VitalsName.peakflowRate ||
                    self?.vitalModel?.name == VitalsName.BMI ||
                    self?.vitalModel?.name == VitalsName.Temperature ||
                    self?.vitalModel?.name == VitalsName.weight || self?.vitalModel?.name == VitalsName.bloodSuger ||
                    self?.vitalModel?.name == VitalsName.OxygenSaturation ||
                    self?.vitalModel?.name == VitalsName.vo2Max ||
                    self?.vitalModel?.name == VitalsName.respiratoryRate || self?.vitalModel?.name == VitalsName.stepLength {
                    
                    objWriterManager.saveQuantityData(value: quantityValue ?? 0, quantityTypeIdentifier: self?.vitalModel?.healthQuantityType, date: self?.startDate ?? Date()) { (error) in
                        guard let vitalModel = self?.vitalModel else { return  }
                        if (error == nil){
                            //show alert
                            let message = "\(String(describing: vitalModel.name!.rawValue)) saved in health kit"
                            self?.showAlertForDataSaved(message:message)
                            
                        }else{
                            let message = "\(String(describing: vitalModel.name!.rawValue)) is not authorized. You can authorized it by making Turn on from Settings -> Health -> DATA -> \(appName) -> Health Data"
                            self?.showAlertForDataSaved(message:message)
                        }
                    }
                    
                }
                else if  self?.vitalModel?.name == VitalsName.BloodPressure  {
                    objWriterManager.storeBloodPressure(systolic: bpSystolic, diastolic: bpDiastolic, date: self?.startDate ?? Date()) { (error) in
                        if (error == nil){
                            //show alert
                            self?.showAlertForDataSaved(message: "Blood Pressure saved in health kit")
                        }
                    }
                }
            }else{
                print(error ?? "")
            }
        }
    }
    
    func showAlertForDataSaved(message:String){
        
        //show alert
        DispatchQueue.main.async {
            
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            
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
        if vitalModel?.name == VitalsName.BloodPressure {
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
    }
    
    @IBAction func btnEndDateClick(sender:UIButton){
        viewDatePicker.isHidden = false
        selectedButton = btnEnd
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
