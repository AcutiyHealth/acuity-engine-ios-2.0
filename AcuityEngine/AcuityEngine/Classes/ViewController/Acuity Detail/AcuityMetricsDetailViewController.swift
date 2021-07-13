//
//  AcuityMetricsDetailViewController.swift
//  AcuityEngine
//
//  Created by Bhoomi Jagani on 10/03/21.
//

import UIKit
typealias CompletionDetailConditionViewOpen = (_ open: Bool?) -> Void
class AcuityMetricsDetailViewController: UIViewController {
    
    // MARK: - Outlet
    
    
    @IBOutlet weak var tblSystemMetrics: UITableView!
    @IBOutlet weak var lblTitle: UILabel!
    
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
    var viewModelObj = AcuityMetricsDetailViewModel()
    var handler: CompletionDetailConditionViewOpen?
    var detailValueVC: AcuityMetricsValueViewController?
    //Get data from parent view controller.
    var metrixType:MetricsType?{
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
        lblTitle.font = Fonts.kAcuityDetailTitleFont
    }
    
    
    //MARK: show system data in tableview
    func showSystemData(){
        guard let metrixType = metrixType else {
            return
        }
        lblTitle.text = metrixType.rawValue
        /*
         
         switch metrixType {
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
         }*/
        self.reloadTableView()
    }
    
    func reloadTableView(){
        self.tblSystemMetrics.reloadData()
    }
    func setHandler(handler: @escaping CompletionDetailConditionViewOpen){
        self.handler = handler
    }
}

// MARK: - UITableViewDelegate , UITableViewDataSource

extension AcuityMetricsDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let metrixType = metrixType else {
            return 0
        }
        switch metrixType {
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
        switch self.metrixType {
        case .Vitals:
            do{
                let item = arrVitals[indexPath.row]
                cell.displayVitals(item: item)
                cell.selectionStyle = .none
            }
        case .Conditions:
            do{
                cell = tableView.dequeueReusableCell(withIdentifier: "AcuityDetailValueDisplayCellConditions") as! AcuityDetailValueDisplayCell
                let item = arrConditions[indexPath.row]
                cell.displayConditionData(item: item)
                cell.selectionStyle = .none
            }
        case .Sympotms:
            do{
                cell = tableView.dequeueReusableCell(withIdentifier: "AcuityDetailValueDisplayCellSymptoms") as! AcuityDetailValueDisplayCell
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
        //If metrixType is condition, don't go in detail screen.
        if metrixType == .Conditions{
            return
        }
        //open detail screen for other metrics..
        openValueDetailScreen()
        switch metrixType
        {
        case .Vitals:
            do{
                
                let item = arrVitals[indexPath.row]
                detailValueVC?.metrixItem = AcuityDetailPulllUpModel(title: item.title ?? "", value: item.value ?? "", metrixType: (metrixType ?? .none)!)
            }
            
        case .Sympotms:
            do{
                
                let item = arrSymptoms[indexPath.row]
                detailValueVC?.metrixItem = AcuityDetailPulllUpModel(title: item.title ?? "", value: item.textValue?.rawValue ?? "", metrixType: (metrixType ?? .none)!)
            }
        case .LabData:
            do{
                
                let item = arrLabs[indexPath.row]
                detailValueVC?.metrixItem = AcuityDetailPulllUpModel(title: item.title ?? "", value: item.value ?? "", metrixType: (metrixType ?? .none)!)
            }
        /*case .Conditions:
         do{
         
         let item = arrConditions[indexPath.row]
         detailValueVC?.metrixItem = AcuityDetailPulllUpModel(title: item.title ?? "", value: item.textValue, metrixType: (metrixType ?? .none)!)
         }*/
        default:
            break;
        }
        //}
        
    }
    
    func openValueDetailScreen(){
        
        //Add detail value view as child view
        detailValueVC = UIStoryboard(name: Storyboard.acuityDetailPullUp.rawValue, bundle: nil).instantiateViewController(withIdentifier: "AcuityMetricsValueViewController") as? AcuityMetricsValueViewController
        self.addChild(detailValueVC!)
        detailValueVC?.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        //Show animation when view added.....
        animationForDetailViewWhenAdded(subviewToAdd: (detailValueVC?.view)!, in: self.view)
        
        detailValueVC?.view.setNeedsDisplay()
        detailValueVC?.didMove(toParent: self)
        detailValueVC?.view.tag = 111
        
        //Main view of Self class needs to be hidden to show subve=iew..
        mainView.isHidden = true
        
        if let handler = handler{
            handler(true)
        }
    }
    func removeDetailValueViewController(){
        if detailValueVC != nil{
            animationForDetailViewWhenRemoved(from: self.view)
            mainView.isHidden = false
            detailValueVC?.view.removeFromSuperview()
            detailValueVC?.removeFromParent()
        }
    }
   
}

