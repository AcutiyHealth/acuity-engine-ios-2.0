//
//  AddOptionViewController.swift
//  AcuityEngine
//
//  Created by Bhoomi Jagani on 04/03/21.
//

import Foundation
import UIKit
import SVProgressHUD
import SwiftUI

class AddPreventionFromListViewController:UIViewController{
    
    // MARK: - Outlet
    
    @IBOutlet weak var preventionView: UIView!
    @IBOutlet weak var tblPreventionTracker: UITableView!
    @IBOutlet weak var segmentControl:UISegmentedControl!
    @IBOutlet weak var lblTitle: UILabel!
    var arrRecommondetions:[PreventionTrackerModel] = []
    var filteredArrRecommondetions:[PreventionTrackerModel] = []
    var btnCloseClickedCallback: (() -> Void)!
    
    
    // MARK: - Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //====================================================================================================//
        tblPreventionTracker.delegate = self
        tblPreventionTracker.dataSource = self
        //====================================================================================================//
        setUpUIAndFont()
        //====================================================================================================//
        callApiForPreventionData()
    }
    
    func setUpUIAndFont(){
        lblTitle.text = "USPSTF Prevention Recommendations By Grade"
        lblTitle.font = Fonts.kAcuityAddOptionTitleFont
        lblTitle.textColor = UIColor.white
        setUpSegmentControl(segmentControl: segmentControl)
    }
    func setUpSegmentControl(segmentControl:UISegmentedControl){
        segmentControl.defaultConfiguration(font: Fonts.kAcuityDetailSegmentFont, color: UIColor.white)
        segmentControl.selectedConfiguration(font: Fonts.kAcuityDetailSegmentFont, color: UIColor.black)
        segmentControl.selectedSegmentIndex = 0
    }
    
    func callApiForPreventionData(){
        let age = ProfileSharedData.shared.age
        let gender = ProfileSharedData.shared.sex
        if age > 0 && gender != ""{
            if Reachability.isConnectedToNetwork(){
                /*
                 Check if last sync data is more than 3 moths old then again call api to sync data...
                 else load from database....
                 */
               
                let timeStampOfDataSync = Utility.fetchDouble(forKey: Key.kPreventionDataSyncDateInApp)
                let dateOf3MonthsBackData = Utility.getDateForDayOrMonth(from: Date(), component: .month, numberOfBeforeOrAfterDays: -3)
                let timeStampOf3MonthsBackData = dateOf3MonthsBackData.timeIntervalSince1970
                
                let yesNoData = DBManager.shared.loadYesAndNOPreventionsOnly()
                let data = DBManager.shared.loadAllPreventionData()
                
                if data.count>0 && timeStampOfDataSync>timeStampOf3MonthsBackData{
                    arrRecommondetions =  Utility.shared.filterPreventionDataForAgeAndGender(preventionData: data, age: age, gender: gender)
                    for objYesNoData in yesNoData{
                        let _ =  arrRecommondetions.map { objArrRecommondetions in
                            if objArrRecommondetions.specificRecommendation?.id == objYesNoData.specificRecommendation?.id{
                                objArrRecommondetions.selectedValue = objYesNoData.selectedValue
                            }
                        }
                    }
                    filterARecommondetions()
                    
                }else{
                    self.callApiForPreventionList(age: age, gender: gender)
                }
                
                
            }else{
                //noInternetAlert?(true)
                Utility.showAlertWithOKBtn(onViewController: self, title: AlertMessages.TITLE_NETWORK_PROBLEM, message: AlertMessages.NETWORK_PROBLEM_MESSAGE)
            }
        }else{
            Utility.showAlertWithOKBtn(onViewController: self, title: AlertMessages.TITLE_NO_AGE_SET, message: AlertMessages.DESCIPTION_NO_AGE_SET)
        }
        
    }
    func callApiForPreventionList(age:Int,gender:String) {
        Utility.showSVProgress()
        PreventionManager.shared.callPreventionWebserviceMethod { (responseModel) in
            SVProgressHUD.dismiss()
            switch responseModel.responseType {
            case .success:
                let preventionData = PreventionManager.shared.prevention
                if let _ = preventionData,preventionData!.specificRecommendations != nil{
                    //=========Prepare array of PreventionTrackerModel........=========//
                    self.arrRecommondetions = []
                    //=========convert specificRecommendations to [PreventionTrackerModel]......=========//
                    for specificRecommendation in preventionData!.specificRecommendations!{
                        let prevention = PreventionTrackerModel(specificRecommendation: specificRecommendation, selectedValue: .NotApplicable)
                        self.arrRecommondetions.append(prevention)
                    }
                    PreventionManager.shared.prevention = nil
                    //=========Filter specificRecommendations according to age and gender....=========//
                    self.arrRecommondetions =  Utility.shared.filterPreventionDataForAgeAndGender(preventionData: self.arrRecommondetions, age: age, gender: gender)
                    //=========Load A recommondetions and reload table.........=========//
                    self.filterARecommondetions()
                    self.tblPreventionTracker.reloadData()
                    //Save data to database......
                    DispatchQueue.global().async{
                        DBManager.shared.insertPreventionData(arrPreventionTracker: self.arrRecommondetions) { success, error in
                            if success{
                                print("data insert for specificRecommendations")
                                //=========Save current date in userdefault============//
                                let dateTimeStamp = Date().timeIntervalSince1970
                                Utility.setDoubleForKey(dateTimeStamp, key: Key.kPreventionDataSyncDateInApp)
                            }
                        }
                    }
                }
                break
            case .error:
                Utility.showAlertWithOKBtn(onViewController: self, title: AlertMessages.TITLE_ERROR, message: responseModel.errorMessage ?? "error")
                break
            case .failure:
                Utility.showAlertWithOKBtn(onViewController: self, title: AlertMessages.TITLE_ERROR, message: responseModel.failureMessage ?? "failure")
                break
            case .none:
                break
            }
        }
    }
    func loadFirstRecommondetion(){
        arrRecommondetions = DBManager.shared.loadAllPreventionData()
        filterARecommondetions()
    }
    @IBAction func btnCloseClicked(sender:UIButton){
        if let _ = btnCloseClickedCallback{
            (self.btnCloseClickedCallback)()
        }
    }
    
    @IBAction func changeSegmentControlStatus(segmentRecommondetions:UISegmentedControl){
        if segmentRecommondetions.selectedSegmentIndex == 0{
            filterARecommondetions()
        }else{
            filterBRecommondetions()
        }
        
    }
    func filterARecommondetions(){
        filteredArrRecommondetions = []
        for obj in 0..<(arrRecommondetions.count ) {
            let objPreventionModel = arrRecommondetions[obj]
            guard let data = objPreventionModel.specificRecommendation else { return  }
            //let _ = data.ageRange?.map{ _ in
            if  data.grade == "A"{
                filteredArrRecommondetions.append(objPreventionModel)
            }
            //}
        }
        self.tblPreventionTracker.reloadData()
    }
    
    func filterBRecommondetions(){
        filteredArrRecommondetions = []
        for obj in 0..<(arrRecommondetions.count ) {
            let objPreventionModel = arrRecommondetions[obj]
            guard let data = objPreventionModel.specificRecommendation else { return  }
            //let _ = data.ageRange?.map{ _ in
            if  data.grade == "B"{
                filteredArrRecommondetions.append(objPreventionModel)
            }
            //}
            
        }
        self.tblPreventionTracker.reloadData()
    }
}

extension AddPreventionFromListViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredArrRecommondetions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: AddPreventionTrackerSelectionCell = tableView.dequeueReusableCell(withIdentifier: "AddPreventionTrackerSelectionCell", for: indexPath as IndexPath) as? AddPreventionTrackerSelectionCell else {
            fatalError("AcuityDetailDisplayCell cell is not found")
        }
        let objPrevention = filteredArrRecommondetions[indexPath.row]
        let specificRecommendation = objPrevention.specificRecommendation
        if specificRecommendation != nil{
            cell.displayData(title: specificRecommendation?.title ?? "", preventionTrackerValue: objPrevention.selectedValue)
            cell.valueSegmentControl.tag = indexPath.row
            cell.valueSegmentControl.addTarget(self, action: #selector(changeSegmentControlStatus(yesNoSegment:)), for: UIControl.Event.valueChanged)
        }
        return cell
    }
    
    @objc func changeSegmentControlStatus(yesNoSegment:UISegmentedControl){
        
        let trackerObject = filteredArrRecommondetions[yesNoSegment.tag]
        guard let specificRecommendation = trackerObject.specificRecommendation, specificRecommendation.id != nil else { return  }
        switch yesNoSegment.selectedSegmentIndex {
        case 0:
            do{
                trackerObject.selectedValue = PreventionTrackerValue(rawValue: 2)! // Yes
                DBManager.shared.insertOrReplacePreventionTrackerSelectionalue(withID: specificRecommendation.id!, selectedValue: trackerObject.selectedValue)
            }
        case 1:
            do{
                trackerObject.selectedValue = PreventionTrackerValue(rawValue: 1)! // No
                DBManager.shared.insertOrReplacePreventionTrackerSelectionalue(withID: specificRecommendation.id!, selectedValue: trackerObject.selectedValue)
            }
        case 2:
            do{
                trackerObject.selectedValue = PreventionTrackerValue(rawValue: 0)! // No Applicable
                let _ = DBManager.shared.deleteFromSelectedPrenevetionTracker(withID: specificRecommendation.id!)
            }
        default:break
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension;
    }
    
}
