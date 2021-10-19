//
//  ProfileViewController.swift
//  AcuityEngine
//
//  Created by Bhoomi Jagani on 01/03/21.
//

import UIKit
import Foundation
import HealthKitReporter
import SOPullUpView
import JGProgressHUD
class ProfileViewController: UIViewController {
    
    // MARK: - Outlet
    @IBOutlet weak var tblProfileData: UITableView!
    @IBOutlet weak var tblHistoryOrMedicationData: UITableView!
    @IBOutlet weak var viewHistoryOrMedicationData: UIView!
    @IBOutlet weak var handleArea: UIView!
    @IBOutlet weak var heightConstraintFortblHistoryOrMedicationDataView: NSLayoutConstraint!
    let labelsAsStringForWeek: Array<String> = dayArray
    var profileViewModel = ProfileViewModel()
    var profileDataArray: [ProfileDataModel] = []
    //var labelsAsStringForMonth: Array<String> = ["Week1","Week2","Week3","Week4"]
    var arrayForTblDataView:[[String:[String]]] = []
    var birthDate:String = "Not Set"
    var sex:String = "Not Set"
    var bloodType:String = "Not Set"
    var progrssHUD:JGProgressHUD = JGProgressHUD()
    
    // MARK: - Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Read Basic Charactristic from Health Kit.....
        readBasicDetails()
        self.tblHistoryOrMedicationData.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
        progrssHUD = showIndicatorInView(view: self.view)
        DispatchQueue.global(qos: .background).async {
       
            self.profileViewModel.fetchHistoryData { success, error, arrayForTblDataView in
            if success{
                self.arrayForTblDataView.append(contentsOf: arrayForTblDataView)
                self.profileViewModel.fetchMedicationData { success, error, arrayForTblDataView in
                    if success{
                        self.arrayForTblDataView.append(contentsOf: arrayForTblDataView)
                        DispatchQueue.main.async {
                            //Hide Progress HUD
                            self.progrssHUD.dismiss(animated: true)
                            self.tblHistoryOrMedicationData.reloadData()
                        }
                    }
                }
            }
        }
        }
        
    }
    
    //========================================================================================================
    //MARK:deinit..
    //========================================================================================================
    deinit {
        self.tblHistoryOrMedicationData.removeObserver(self, forKeyPath: "contentSize")
    }
  
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        tblHistoryOrMedicationData.layer.removeAllAnimations()
        heightConstraintFortblHistoryOrMedicationDataView.constant = tblHistoryOrMedicationData.contentSize.height
            self.updateViewConstraints()
            self.view.layoutIfNeeded()
        
        
    }
    private func readBasicDetails() {
        do {
            let reporter = try HealthKitReporter()
            let characteristic = reporter.reader.characteristics()
            birthDate = ((characteristic.birthday == "na" ? "Not Set":calculateAndDisplayBirthDateAndAge(birthday: characteristic.birthday ?? "")))
            sex = ((characteristic.biologicalSex == "na" ? "Not Set":characteristic.biologicalSex)) ?? ""
            bloodType = ((characteristic.bloodType == "na" ? "Not Set":characteristic.bloodType)) ?? ""
            
            //After fetching data set data to ProfileDataArray....
            setCharactristicDataToArray()
            
        } catch {
            print(error)
        }
    }
    func calculateAndDisplayBirthDateAndAge(birthday:String)->String{
        
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd"
        let birthdayDate = dateFormater.date(from: birthday)
        let calendar: NSCalendar! = NSCalendar(calendarIdentifier: .gregorian)
        let now = Date()
        if let birthdayDate = birthdayDate{
            let calcAge = calendar.components(.year, from: birthdayDate, to: now, options: [])
            let age = calcAge.year
            return "\(birthday)/\(String(describing: age!))"
            
        }
        return "\(birthday)"
        
    }
    func setCharactristicDataToArray(){
        
        let profileData1 = ProfileDataModel(title: "First Name:", value: "Name")
        let profileData2 = ProfileDataModel(title: "Last Name:", value: "Name")
        let profileData3 = ProfileDataModel(title: "Date of Birth:", value: birthDate)
        let profileData4 = ProfileDataModel(title: "Sex:", value: sex)
        let profileData5 = ProfileDataModel(title: "Blood Type:", value: bloodType)
        
        
        profileDataArray = [profileData1,profileData2,profileData3,profileData4,profileData5]
    }
}

// MARK: - SOPullUpViewDelegate

extension ProfileViewController: SOPullUpViewDelegate {
    
    func pullUpViewStatus(_ sender: UIViewController, didChangeTo status: PullUpStatus) {
        switch status {
        case .collapsed:
            do{
                
            }
        /*UIView.animate(withDuration: 0.6)  { [weak self] in
         //self?.titleLbl.alpha = 0
         }*/
        case .expanded:
            do{
                
            }
        /*UIView.animate(withDuration: 0.6) { [weak self] in
         //self?.titleLbl.alpha = 1
         }*/
        }
    }
    
    func pullUpHandleArea(_ sender: UIViewController) -> UIView {
        return handleArea
    }
}

// MARK: - UITableViewDelegate , UITableViewDataSource

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tblProfileData{
        return profileDataArray.count
        }else{
            return arrayForTblDataView.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tblProfileData{
        guard let cell: ProfileViewCell = tableView.dequeueReusableCell(withIdentifier: "ProfileViewCell", for: indexPath as IndexPath) as? ProfileViewCell else {
            fatalError("AcuityDetailDisplayCell cell is not found")
        }
        let profileData = profileDataArray[indexPath.row]
        cell.displayData(title: profileData.title ?? "", value: profileData.value ?? "")
        cell.selectionStyle = .none
        
        return cell
        }else{
            guard let cell: ProfileAddOptionsDataView = tableView.dequeueReusableCell(withIdentifier: "ProfileAddOptionsDataView", for: indexPath as IndexPath) as? ProfileAddOptionsDataView else {
                fatalError("AcuityDetailDisplayCell cell is not found")
            }
           //"test test test test test test test test test test test test test test "
            //cell.arrayOfData = ["test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test ","test","test","test","test"]
        
            //========================================================================//
            /*
             HistoryDataDisplayModel will have [key:value]. Key will be sectionTitle and array will be Data array..
             */
            let txtObject = arrayForTblDataView[indexPath.row];
            cell.lblTitle.text = txtObject.first?.key ?? ""
            cell.arrayOfData = txtObject.first?.value ?? []
            cell.tblData.reloadData()
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
            if tableView == tblHistoryOrMedicationData{
                return HEIGHT_OF_ROW_IN_TBL_INPUT_VIEW;
            }
            return 50;
        
    }
    
}
