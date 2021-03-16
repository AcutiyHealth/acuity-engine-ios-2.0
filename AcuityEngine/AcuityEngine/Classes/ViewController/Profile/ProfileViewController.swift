//
//  ProfileViewController.swift
//  AcuityEngine
//
//  Created by Bhoomi Jagani on 01/03/21.
//

import UIKit
import Foundation

import SOPullUpView

class ProfileViewController: UIViewController {
    
    // MARK: - Outlet
    @IBOutlet weak var systemMetricsTable: UITableView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var scoreLbl: UILabel!
    @IBOutlet weak var handleArea: UIView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var btnClose: UIButton!
    let labelsAsStringForWeek: Array<String> = dayArray
    
    var profileDataArray: [ProfileDataModel] = []
    //var labelsAsStringForMonth: Array<String> = ["Week1","Week2","Week3","Week4"]
   
   
    var systemMetricsData:[[String:Any]]?
    // MARK: - Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        let profileData1 = ProfileDataModel(title: "First Name:", value: "Name")
        let profileData2 = ProfileDataModel(title: "Last Name:", value: "Name")
        let profileData3 = ProfileDataModel(title: "Date of Birth:", value: "1/7/22")
        let profileData4 = ProfileDataModel(title: "Sex:", value: "Female")
        let profileData5 = ProfileDataModel(title: "Blood Type:", value: "B+")
       
    
        profileDataArray = [profileData1,profileData2,profileData3,profileData4,profileData5]
    }
    
    
  
}

// MARK: - SOPullUpViewDelegate

extension ProfileViewController: SOPullUpViewDelegate {
    
    func pullUpViewStatus(_ sender: UIViewController, didChangeTo status: PullUpStatus) {
        switch status {
        case .collapsed:
            UIView.animate(withDuration: 0.6)  { [weak self] in
                //self?.titleLbl.alpha = 0
            }
        case .expanded:
            UIView.animate(withDuration: 0.6) { [weak self] in
                //self?.titleLbl.alpha = 1
            }
        }
    }
    
    func pullUpHandleArea(_ sender: UIViewController) -> UIView {
        return handleArea
    }
}

// MARK: - UITableViewDelegate , UITableViewDataSource

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: ProfileViewCell = tableView.dequeueReusableCell(withIdentifier: "ProfileViewCell", for: indexPath as IndexPath) as? ProfileViewCell else {
            fatalError("AcuityDetailDisplayCell cell is not found")
        }
        let profileData = profileDataArray[indexPath.row]
        cell.displayData(title: profileData.title ?? "", value: profileData.value ?? "")
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}
