//
//  AcuityDetailValueViewController.swift
//  AcuityEngine
//
//  Created by Bhoomi Jagani on 02/03/21.
//

import UIKit
import SOPullUpView
import SwiftChart
class AcuityDetailValueViewController: UIViewController {
    
    // MARK: - Outlet
    

    @IBOutlet weak var systemMetricsTable: UITableView!
    @IBOutlet weak var titleLbl: UILabel!
  
    @IBOutlet weak var mainView: UIView!
  
    //Condition data
    var arrConditions:[ConditionsModel] = []
    //Symptoms Data
    var arrSymptoms:[SymptomsModel] = []
    //Lab Data
    var arrLabs:[LabModel] = []
    //Vitals
    var arrVitals:[VitalsModel] = []
    
    //viewModel object..
    var viewModelObj = AcuityDetailValueViewModel()
    // MARK: - Properties
    
    //selected metrix from tableview ...We can get it from AcuityDetailPullupViewController
    
    
    var metrixItem:AcuityDetailPulllUpModel?{
        didSet{
            self.showSystemData()
        }
    }
    
    //var systemMetricsData:[String:Any] = ["2/13/21":"132","2/13/21":"134","2/13/21":"130"]
    // MARK: - Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setFontForLabel()
      
    }
    
    
    func setFontForLabel(){
        titleLbl.font = Fonts.kAcuityDetailTitleFont
    }
    

    //MARK: show system data in tableview
    func showSystemData(){
        guard let metrixItem = metrixItem else {
            return
        }
        titleLbl.text = metrixItem.title
        
       
        switch metrixItem.metrixType {
        case .Vitals:
            do{
                arrVitals = viewModelObj.getVitals(title: metrixItem.title!)
            }
        case .Conditions:
            do{
                arrConditions = viewModelObj.getConditionData(title: metrixItem.title!)
            }
        case .Sympotms:
            do{
                arrSymptoms = viewModelObj.getSymptomsData(title: metrixItem.title!)
            }
        case .LabData:
            do{
                arrLabs = viewModelObj.getLabData(title: metrixItem.title!)
            }
        case .none:
            do{
                
            }
        }
        self.reloadTableView()
    }
    
    func reloadTableView(){
        self.systemMetricsTable.reloadData()
    }
   
}

// MARK: - UITableViewDelegate , UITableViewDataSource

extension AcuityDetailValueViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let metrixItem = metrixItem else {
            return 0
        }
        switch metrixItem.metrixType {
        case .Vitals:
            do{
                return arrVitals.count
            }
        case .Conditions:
            do{
                return arrConditions.count
            }
        case .Sympotms:
            do{
                return arrSymptoms.count
            }
        case .LabData:
            do{
                return arrLabs.count
            }
        case .none:
            do{
                
            }
        }
        return 0 
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        guard let cell = (tableView.dequeueReusableCell(withIdentifier: "AcuityDetailValueDisplayCell", for: indexPath as IndexPath) as? AcuityDetailValueDisplayCell)  else {
            fatalError("AcuityDetailDisplayCell cell is not found")
        }
        switch metrixItem?.metrixType {
            case .Vitals:
                do{
                  
                    let item = arrVitals[indexPath.row]
                    cell.displayData(timeStamp: item.startTime, value: "\(String(describing: item.value ?? ""))", color: item.color)
                    cell.selectionStyle = .none
                }
            case .Conditions:
                do{
                   
                    let item = arrConditions[indexPath.row]
                    cell.displayData(timeStamp: item.startTime, value: "\(String(describing: item.value))", color: item.color)
                    cell.selectionStyle = .none
                }
            case .Sympotms:
                do{
                   
                    let item = arrSymptoms[indexPath.row]
                    cell.displayData(timeStamp: item.startTime, value: item.textValue?.rawValue ?? "", color: item.color)
                    cell.selectionStyle = .none
                }
            case .LabData:
                do{
                   
                    let item = arrLabs[indexPath.row]
                    cell.displayData(timeStamp: item.startTime, value: "\(String(describing: item.value ?? ""))", color: item.color)
                    cell.selectionStyle = .none
                }
           
               
        case .none:
            do{
                
            }
        }
           
        cell.backgroundColor = UIColor.clear
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
   
  
}


