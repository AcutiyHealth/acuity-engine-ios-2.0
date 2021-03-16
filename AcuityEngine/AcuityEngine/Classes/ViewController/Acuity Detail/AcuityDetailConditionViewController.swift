//
//  AcuityDetailConditionViewController.swift
//  AcuityEngine
//
//  Created by Bhoomi Jagani on 10/03/21.
//

import UIKit
typealias CompletionDetailConditionViewOpen = (_ open: Bool?) -> Void
class AcuityDetailConditionViewController: UIViewController {
    
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
    var viewModelObj = AcuityDetailConditionViewModel()
    var handler: CompletionDetailConditionViewOpen?
    var detailValueVC: AcuityDetailValueViewController?
    //Get data from parent view controller.
    var systemName:MetricsType?{
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
        guard let systemName = systemName else {
            return
        }
        titleLbl.text = systemName.rawValue
        
        if systemName == .Conditions{
            arrConditions = viewModelObj.getConditionData()
        }
        switch systemName {
        case .Vitals:
            do{
                arrVitals = viewModelObj.getVitals()
            }
        case .Conditions:
            do{
                arrConditions = viewModelObj.getConditionData()
            }
        case .Sympotms:
            do{
                arrSymptoms = viewModelObj.getSymptomsData()
            }
        case .LabData:
            do{
                arrLabs = viewModelObj.getLabData()
            }
        }
        self.reloadTableView()
    }
    
    func reloadTableView(){
        self.systemMetricsTable.reloadData()
    }
    func setHandler(handler: @escaping CompletionDetailConditionViewOpen){
        self.handler = handler
    }
}

// MARK: - UITableViewDelegate , UITableViewDataSource

extension AcuityDetailConditionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let systemName = systemName else {
            return 0
        }
        switch systemName {
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
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard var cell = (tableView.dequeueReusableCell(withIdentifier: "AcuityDetailValueDisplayCell") as? AcuityDetailValueDisplayCell)  else {
            fatalError("AcuityDetailDisplayCell cell is not found")
        }
        switch self.systemName {
        case .Vitals:
            do{
                let item = arrVitals[indexPath.row]
                cell.displayVitals(item: item)
                cell.selectionStyle = .none
            }
        case .Conditions:
            do{
                let item = arrConditions[indexPath.row]
                cell.displayConditionData(item: item)
                cell.selectionStyle = .none
            }
        case .Sympotms:
            do{
                cell = tableView.dequeueReusableCell(withIdentifier: "AcuityDetailValueDisplayCell2") as! AcuityDetailValueDisplayCell
                let item = arrSymptoms[indexPath.row]
                cell.displaySymptomsData(item: item)
                cell.selectionStyle = .none
            }
        case .LabData:
            do{
                let item = arrLabs[indexPath.row]
                cell.displayLabsData(item: item)
                cell.selectionStyle = .none
            }
            return cell
        case .none:
            break
        }
        
        cell.backgroundColor = UIColor.clear
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //open detail value screen
        if indexPath.row == 0{
        openValueDetailScreen()
        switch systemName
        {
        case .Vitals:
            do{
                
                let item = arrVitals[0]
                detailValueVC?.metrixItem = AcuityDetailPulllUpModel(title: item.title ?? "", value: item.value ?? "", metrixType: (systemName ?? .none)!)
            }
        case .Conditions:
            do{
                
                let item = arrConditions[0]
                detailValueVC?.metrixItem = AcuityDetailPulllUpModel(title: item.title ?? "", value: item.textValue, metrixType: (systemName ?? .none)!)
            }
        case .Sympotms:
            do{
                
                let item = arrSymptoms[0]
                detailValueVC?.metrixItem = AcuityDetailPulllUpModel(title: item.title ?? "", value: item.textValue?.rawValue ?? "", metrixType: (systemName ?? .none)!)
            }
        case .LabData:
            do{
                
                let item = arrLabs[0]
                detailValueVC?.metrixItem = AcuityDetailPulllUpModel(title: item.title ?? "", value: item.value ?? "", metrixType: (systemName ?? .none)!)
            }
            
        case .none:
            do{
                
                let item = arrLabs[0]
                detailValueVC?.metrixItem = AcuityDetailPulllUpModel(title: item.title ?? "", value: item.value ?? "", metrixType: (systemName ?? .none)!)
            }
        }
        }
        
    }
    
    func openValueDetailScreen(){
        
        //Add detail value view as child view
        detailValueVC = UIStoryboard(name: Storyboard.acuityDetailPullUp.rawValue, bundle: nil).instantiateViewController(withIdentifier: "AcuityDetailValueViewController") as? AcuityDetailValueViewController
        self.addChild(detailValueVC!)
        detailValueVC?.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        
        self.view.addSubview((detailValueVC?.view)!)
        detailValueVC?.view.setNeedsDisplay()
        detailValueVC?.didMove(toParent: self)
        detailValueVC?.view.tag = 111
        
        //Pass selected Symptoms to AddSymptomViewController
        //        let symptomsData = symptomArray[index]
        //        detailValueVC?.symptomsModel = symptomsData
        //setUpCloseButton(frame:btnFrame , btnImage:btnImage , btnTintColor:btnTintColor! )
        //Hide main view of Detail Pullup class
        
        mainView.isHidden = true
        
        
        if let handler = handler{
            handler(true)
        }
    }
    func removeDetailValueViewController(){
        if detailValueVC != nil{
            mainView.isHidden = false
            detailValueVC?.view.removeFromSuperview()
            detailValueVC?.removeFromParent()
        }
    }
    
}

