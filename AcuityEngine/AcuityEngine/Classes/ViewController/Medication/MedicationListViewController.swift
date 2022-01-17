//
//  MedicationViewController.swift
//  AcuityEngine
//
//  Created by Bhoomi Jagani on 17/11/21.
//


import Foundation
import UIKit
import SOPullUpView

class MedicationListViewController:UIViewController{
    
    // MARK: - Outlet
    
    @IBOutlet weak var handleArea: HandleView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var visualEffectView: UIView!
    @IBOutlet weak var tblTitle: UITableView!{
        didSet{
            setTbl()
        }
    }
    
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    
    var arrMedications = [MedicationDataDisplayModel]()
    var arrTitle = [String]()
    var btnCloseClickedCallback: (() -> Void)!
    
    // MARK: - Properties
    
    var pullUpControl: SOPullUpControl? {
        didSet {
            pullUpControl?.delegate = self
        }
    }
    
    // MARK: - Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tblTitle.delegate = self
        tblTitle.dataSource = self
        
        lblTitle.text = MetricsType.Medication.rawValue
        lblTitle.font = Fonts.kAcuityAddDetailTitleFont
        lblTitle.textColor = UIColor.white
        
        arrMedications = AppDelegate.shared.arrMedications
        
        self.view.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        
        if self.arrMedications.count <= 0{
            tblTitle.separatorColor = UIColor.clear
            setNoDataInfoIfRecordsNotExists(tblView: self.tblTitle,font: Fonts.kCellHistoryDataValueFontInAddSection)
        }
        //Reload
        tblTitle.reloadData()
    }
    func setTbl(){
        tblTitle.register(UINib(nibName: "CustomPopUpCell", bundle: nil), forCellReuseIdentifier: NSStringFromClass(CustomPopUpCell.classForCoder()))
    }
}

extension MedicationListViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMedications.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblTitle.dequeueReusableCell(withIdentifier: NSStringFromClass(CustomPopUpCell.classForCoder()), for: indexPath) as! CustomPopUpCell
        cell.lblTitle.text = arrMedications[indexPath.row].txtValue ?? ""
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension;
    }
    
}




// MARK: - SOPullUpViewDelegate

extension MedicationListViewController: SOPullUpViewDelegate {
    func pullUpViewStatus(_ sender: UIViewController, didChangeTo status: PullUpStatus) {
        switch status {
        case .collapsed:
            UIView.animate(withDuration: 0.9) {
                self.view.alpha = 0.2
            }
            NotificationCenter.default.post(name: Notification.Name(NSNotificationName.pullUpClose.rawValue), object: nil)
            NotificationCenter.default.post(name:Notification.Name(NSNotificationName.showAcuityDetailPopup.rawValue), object: nil)
        case .expanded: break
        default:break
        }
        
    }
    
    func pullUpHandleArea(_ sender: UIViewController) -> UIView {
        return handleArea
    }
}
