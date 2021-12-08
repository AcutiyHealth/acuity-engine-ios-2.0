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
import SVProgressHUD
class ProfileViewController: UIViewController {
    
    // MARK: - Outlet
    @IBOutlet weak var tblProfileData: UITableView!
    @IBOutlet weak var tblHistoryOrMedicationData: UITableView!
    @IBOutlet weak var viewHistoryOrMedicationData: UIView!
    @IBOutlet weak var handleArea: UIView!
    @IBOutlet weak var heightConstraintFortblHistoryOrMedicationDataView: NSLayoutConstraint!
    @IBOutlet weak var heightConstraintFortblProfileDataView: NSLayoutConstraint!
    let labelsAsStringForWeek: Array<String> = dayArray
    var profileViewModel = ProfileViewModel()
    var profileDataArray: [ProfileDataModel] = []
    //var labelsAsStringForMonth: Array<String> = ["Week1","Week2","Week3","Week4"]
    var arrayForTblDataView:[[String:[String]]] = []
    var birthDate:String = "Not Set"
    var sex:String = "Not Set"
    var bloodType:String = "Not Set"
    let HEIGHT_OF_ROW_IN_PROFILE_TBL = 50
    // MARK: - Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Read Basic Charactristic from Health Kit.....
        readBasicDetails()
        //===== Set Height of tblHistoryOrMedicationData as per ContentSize =========//
        self.tblHistoryOrMedicationData.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
        self.fetchHistoryAndMedicationData()
    }
    
    //========================================================================================================
    //MARK: Fetch History And Medication Data..
    //========================================================================================================
    func fetchHistoryAndMedicationData(){
        Utility.showSVProgress()
        DispatchQueue.global(qos: .background).async {
            
            self.profileViewModel.fetchHistoryData { success, error, arrayForTblDataView in
                if success{
                    self.arrayForTblDataView.append(contentsOf: arrayForTblDataView)
                    self.profileViewModel.fetchMedicationData { success, error, arrayForTblDataView in
                        if success{
                            self.arrayForTblDataView.append(contentsOf: arrayForTblDataView)
                            DispatchQueue.main.async {
                                //Hide Progress HUD
                                SVProgressHUD.dismiss()
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
    //========================================================================================================
    //MARK: observeValue of Content size..
    //========================================================================================================
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        tblHistoryOrMedicationData.layer.removeAllAnimations()
        heightConstraintFortblHistoryOrMedicationDataView.constant = tblHistoryOrMedicationData.contentSize.height
        self.updateViewConstraints()
        self.view.layoutIfNeeded()
        
        
    }
    //========================================================================================================
    //MARK: Read Basic Details..
    //========================================================================================================
    private func readBasicDetails() {
        do {
            let reporter = try HealthKitReporter()
            let characteristic = reporter.reader.characteristics()
            var birthDay = characteristic.birthday ?? ""
            let age = calculateAgeFromBirthDate(birthday: birthDay)
            
            if age > 0{
                birthDay = "\(birthDay)/\(String(describing: age))"
            }
            birthDate = characteristic.birthday == "na" ? "Not Set":birthDay
            sex = ((characteristic.biologicalSex == "na" ? "Not Set":characteristic.biologicalSex)) ?? ""
            bloodType = ((characteristic.bloodType == "na" ? "Not Set":characteristic.bloodType)) ?? ""
            
            //After fetching data set data to ProfileDataArray....
            setCharactristicDataToArray()
            //Set Height Of TableView
            heightConstraintFortblProfileDataView.constant = CGFloat(profileDataArray.count * HEIGHT_OF_ROW_IN_PROFILE_TBL)
            tblProfileData.reloadData()
        } catch {
            print(error)
        }
    }
    
    func setCharactristicDataToArray(){
        
        let firstName = getFromKeyChain(key: Key.kAppleFirstName)
        let lastName = getFromKeyChain(key: Key.kAppleLastName)
        if firstName != ""{
            let profileData1 = ProfileDataModel(title: "First Name:", value: firstName)
            profileDataArray.append(profileData1)
        }
        if lastName != ""{
            let profileData1 = ProfileDataModel(title: "Last Name:", value: lastName)
            profileDataArray.append(profileData1)
        }
        let profileData3 = ProfileDataModel(title: "Date of Birth:", value: birthDate)
        let profileData4 = ProfileDataModel(title: "Sex:", value: sex)
        let profileData5 = ProfileDataModel(title: "Blood Type:", value: bloodType)
        profileDataArray.append(profileData3)
        profileDataArray.append(profileData4)
        profileDataArray.append(profileData5)
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
            guard let cell: ProfileAddOptionsDataCell = tableView.dequeueReusableCell(withIdentifier: "ProfileAddOptionsDataCell", for: indexPath as IndexPath) as? ProfileAddOptionsDataCell else {
                fatalError("AcuityDetailDisplayCell cell is not found")
            }
            
            //========================================================================//
            /*
             ProfileAddOptionsDataCell will have [key:value]. Key will be Title and array will be Data array..
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
        return CGFloat(HEIGHT_OF_ROW_IN_PROFILE_TBL);
        
    }
    
}
