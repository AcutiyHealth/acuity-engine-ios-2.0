//
//  BMICalculatorViewController.swift
//  AcuityEngine
//
//  Created by Bhoomi Jagani on 21/09/21.
//

import UIKit
import HealthKit

class BMICalculatorViewController: UIViewController {
    
    @IBOutlet weak var lblTitleBMICalculator: UILabel!
    @IBOutlet weak var lblTitleHeight: UILabel!
    @IBOutlet weak var lblTitleWeight: UILabel!
    @IBOutlet weak var lblTotalBMI: UILabel!
    @IBOutlet weak var txtFieldHeightFeet: UITextField!
    @IBOutlet weak var txtFieldHeightInches: UITextField!
    @IBOutlet weak var txtFieldWeight: UITextField!
    @IBOutlet weak var viewHeightInches: UIView!
    @IBOutlet weak var viewHeightFeet: UIView!
    @IBOutlet weak var viewWeight: UIView!
    
    //Btn for Start and date time
    @IBOutlet weak var viewStart: UIView!
    @IBOutlet weak var btnStart: UIButton!
    @IBOutlet weak var lblStart: UILabel!
    @IBOutlet weak var btnCalculate: SaveButton!
    @IBOutlet weak var btnSave: SaveButton!
    
    var BMIValue = 0.0
    
    var selectedButton: UIButton?
    var startDate:Date?
    var endDate:Date?
    
    //Date picker view...
    @IBOutlet weak var viewDatePicker: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var btnHeightConstraint: NSLayoutConstraint!
    
    //========================================================================================================
    //MARK: viewDidLoad..
    //========================================================================================================
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.maximumDate = Date()
        
        let dateStr = getDateWithTime(date: datePicker.date)
        btnStart.setTitle(dateStr, for: .normal)
        
        //set placeholder
        setPlaceHodlerInTextField()
        //set fonts..
        setFontForLabel()
        //set up UI for buttons....
        setUpDesignForDateButtons()
        //Setup Toolbar For Number Pad...
        setupToolbarForNumberPad()
        
        if !UIDevice.current.hasNotch{
            btnHeightConstraint.constant = 50
        }
        
        lblTitleBMICalculator.text = ScreenTitle.BMIIndexCalculator;
        // Do any additional setup after loading the view.
    }
    //========================================================================================================
    //MARK: Set PlaceHodler In TextField..
    //========================================================================================================
    func setPlaceHodlerInTextField(){
        txtFieldWeight.attributedPlaceholder = setAttributedPlaceHolder(placeholder: "lbs");
        txtFieldHeightFeet.attributedPlaceholder = setAttributedPlaceHolder(placeholder: "ft")
        txtFieldHeightInches.attributedPlaceholder = setAttributedPlaceHolder(placeholder: "inchs")
        
    }
    func setAttributedPlaceHolder(placeholder:String)->NSAttributedString{
        let color = UIColor.white
        return NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : color,NSAttributedString.Key.font : Fonts.kStartEndValueFont])
    }
    //========================================================================================================
    //MARK: Set Font For Label..
    //========================================================================================================
    func setFontForLabel(){
        lblTitleBMICalculator.font = Fonts.kAcuityDetailTitleFont
        lblTitleHeight.font = Fonts.kStartEndTitleFont
        lblTitleWeight.font = Fonts.kStartEndTitleFont
        lblStart.font = Fonts.kStartEndTitleFont
        txtFieldWeight.font = Fonts.kStartEndValueFont
        txtFieldHeightFeet.font = Fonts.kStartEndValueFont
        txtFieldHeightInches.font = Fonts.kStartEndValueFont
        btnStart.titleLabel?.font =  Fonts.kStartEndValueFont
        
        
        setupViewBorderForAddSection(view: viewWeight)
        setupViewBorderForAddSection(view: viewHeightFeet)
        setupViewBorderForAddSection(view: viewHeightInches)
        
    }
    //========================================================================================================
    //MARK: Set Up Design For DateButtons..
    //========================================================================================================
    func setUpDesignForDateButtons(){
        btnStart.layer.cornerRadius = 5;
        btnStart.backgroundColor = UIColor.white.withAlphaComponent(0.2)
    }
    //========================================================================================================
    //MARK:Setup Toolbar For Number Pad.
    //========================================================================================================
    
    func setupToolbarForNumberPad(){
        let numberToolbar: UIToolbar = UIToolbar()
        numberToolbar.barStyle = UIBarStyle.default
        numberToolbar.items=[
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(donebuttonClickedInNumberToolbar))
        ]
        
        numberToolbar.sizeToFit()
        
        txtFieldWeight.inputAccessoryView = numberToolbar //do it for every relevant textfield if there are more than one
        txtFieldHeightFeet.inputAccessoryView = numberToolbar //do it for every relevant textfield if there are more than one
        txtFieldHeightInches.inputAccessoryView = numberToolbar //do it for every relevant textfield if there are more than one
        
    }
    //========================================================================================================
    //MARK: Done button Clicked In NumberToolbar..
    //========================================================================================================
    @objc func donebuttonClickedInNumberToolbar(){
        self.view.endEditing(true)
    }
    //========================================================================================================
    //MARK: editingChanged in Textfield..
    //========================================================================================================
    @IBAction func editingChanged(_ textField: UITextField) {
        if textField.text?.count == 1 {
            if textField.text?.first == " " {
                textField.text = ""
                return
            }
        }
        
        guard
            let txtWeight = txtFieldWeight.text,let txtHeightInches = txtFieldHeightInches.text,let txtHeightFeet = txtFieldHeightFeet.text,!txtWeight.isEmpty,!txtHeightInches.isEmpty,!txtHeightFeet.isEmpty
        else {
            btnCalculate.isEnabled = false
            btnSave.isEnabled = false
            return
        }
        btnCalculate.isEnabled = true
        //btnSave.isEnabled = true
        
    }
    //========================================================================================================
    //MARK: Btn Calculate Click..
    //========================================================================================================
    
    @IBAction func btnCalculateClick(sender:UIButton){
        let feet = Double(txtFieldHeightFeet.text ?? "") ?? 0;
        let inches = Double(txtFieldHeightInches.text ?? "") ?? 0;
        let pounds = Double(txtFieldWeight.text ?? "") ?? 0;
        calcBMI(feet: feet, inches: inches, pounds: pounds)
        
        //Enable Save button....
        btnSave.isEnabled = true
    }
    func calcBMI(feet:Double, inches:Double, pounds:Double) {
        /*
         Formula: weight (lb) / [height (in)]2 x 703
         Calculation: [weight (lb) / height (in) / height (in)] x 703
         */
        let totalInches = (feet*12) + (inches);
        let temp = pounds / (totalInches * totalInches);
        BMIValue = (temp * 703)
        lblTotalBMI.text =  "Your BMI Index: \(String(format: "%.2f", BMIValue))";
    }
    
    //========================================================================================================
    //MARK: Btn Save Click..
    //========================================================================================================
    @IBAction func btnSaveClick(sender:UIButton){
        
        //Create Object For HKWriterManager
        if BMIValue<=0{
            return;
        }
        let objWriterManager = HKWriterManager()
        
        let vitalModel = VitalModel(name: VitalsName.BMI)
        guard let healthQuantityType = vitalModel.healthQuantityType else {return}
        //Authorzie all vital by it's quantityTypeIdentifier
        HKSetupAssistance.authorizeHealthKitForAddVitals(quantityTypeIdentifier: healthQuantityType, completion: { [weak self] (success, error) in
            
            //Authorize successful, then save it in Healthkit...
            //If they didn't authorize show alrert to authorize it from settings..
            if success{
                
                self?.saveVitalsDataInHealthKit(vitalModel: (vitalModel), objWriterManager: objWriterManager, quantityValue: self?.BMIValue ?? 0 , quantityTypeIdentifier: vitalModel.healthQuantityType) { (error) in
                    
                    let message = "\(String(describing: vitalModel.name!.rawValue)) saved in health kit"
                    self?.vitalsSavedSuccessfully(message: message)
                }
                
            }else{
                print(error ?? "")
            }
        })
    }
    
    //========================================================================================================
    //MARK:Save BMI Data..
    //========================================================================================================
    func saveVitalsDataInHealthKit(vitalModel:VitalModel,objWriterManager:HKWriterManager,quantityValue: Double,quantityTypeIdentifier:HKQuantityTypeIdentifier?,completion: @escaping (Error?) -> Swift.Void){
        objWriterManager.saveQuantityData(value: quantityValue, quantityTypeIdentifier: quantityTypeIdentifier, date: self.startDate ?? Date()) {[weak self] (error) in
            
            if (error == nil){
                
                completion(nil)
                
            }else{
                let message = "\(String(describing: vitalModel.name!.rawValue)) is not authorized. You can authorized it by making Turn on from Settings -> Health -> DATA -> \(Key.kAppName) -> Health Data"
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
    //MARK: Get OK Action For VitalList
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
            
            
            
            // Please enable camera access from Settings > AppName > Camera to take photos
            
            let vc = self.parent
            vc?.presentAlert(title: "\(Key.kAppName)",
                             message: message,
                             actions: okAction)
        }
    }
    
}
//========================================================================================================
//MARK: extension BMICalculatorViewController
//========================================================================================================

extension BMICalculatorViewController{
    
    @IBAction func btnStartDateClick(sender:UIButton){
        viewDatePicker.isHidden = false
        selectedButton = btnStart
        guard ((btnStart.titleLabel?.text) != nil) else {
            return
        }
        datePicker.date = getDateFromString(date: btnStart.titleLabel!.text!)
    }
    
    
    @IBAction func cancelBtnClicked(_ button: UIBarButtonItem?) {
        viewDatePicker.isHidden = true
    }
    
    @IBAction func doneBtnClicked(_ button: UIBarButtonItem?) {
        viewDatePicker.isHidden = true
        
        let dateStr = getDateWithTime(date: datePicker.date)
        
        startDate = datePicker.date
        btnStart.setTitle(dateStr, for: .normal)
        
    }
    
}
