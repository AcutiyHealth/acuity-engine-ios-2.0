//
//  ConditionsListViewController.swift
//  AcuityEngine
//
//  Created by Bhoomi Jagani on 04/03/21.
//

import UIKit

class ConditionsListViewController: UIViewController {
    
    @IBOutlet weak var tblConditions: UITableView!
    var arrayOfFetchedConditionFromDatabase: [ConditionsModel] = []
    var conditionArray : [ConditionsModel] = []
    
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set font for title
        setFontForLabel()
        
        // Do any additional setup after loading the view.
    }
    /**
     Logic : Here we prepare conditionArray from Global condition array data....
     First, we fetch data from Database and compare all that Ids with Global condition data's Ids. Whose IDs are match that model will have isOn = true and that entry will display in table switch value.
     When switch ON from table, insert that condition Id in Database.
     When switch Off from table, remove that condition Id in Database.
     */
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if conditionArray.count == 0{
            print("loadConditionsData");
            loadConditionsData()
        }
        
    }
    
    //========================================================================================================
    //MARK:Set Font For Label..
    //========================================================================================================
    func setFontForLabel() {
        self.lblTitle.font = Fonts.kCellTitleFontListInAddSection
    }
    
    //========================================================================================================
    //MARK: load Conditions Data From Database..
    //========================================================================================================
    
    func loadConditionsData(){
        DispatchQueue.global().async {
            self.fetchConditionsDataFromDatabase()
        }
    }
    
    //========================================================================================================
    //MARK: Fetch Conditions Data From Database..
    //========================================================================================================
    
    func fetchConditionsDataFromDatabase(){
        self.arrayOfFetchedConditionFromDatabase = DBManager.shared.loadConditions();
        
        self.createConditionArray()
        
        DispatchQueue.main.async {
            
            self.tblConditions.reloadData()
        }
    }
    
    
    //========================================================================================================
    //MARK:Create Condition Array For Table Data..
    //========================================================================================================
    func createConditionArray(){
        for item in arrConditionData.sorted(by: {$0.value.rawValue < $1.value.rawValue}){
            let id:Int = item.key
            let title:String = item.value.rawValue
            let filterArray = arrayOfFetchedConditionFromDatabase.filter({$0.id == id})
            var valueYesOrNo:ConditionValue = .No
            if filterArray.count>0{
                valueYesOrNo = .Yes
            }
            let model = ConditionsModel(title:title , value: valueYesOrNo, conditionId: id)
            conditionArray.append(model)
            
        }
    }
}
//========================================================================================================
//MARK: Extension of ConditionsListViewController.
//========================================================================================================

extension ConditionsListViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conditionArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: AddConditionCell = tableView.dequeueReusableCell(withIdentifier: "AddConditionCell", for: indexPath as IndexPath) as? AddConditionCell else {
            fatalError("AcuityDetailDisplayCell cell is not found")
        }
        let conditionData = conditionArray[indexPath.row]
        cell.yesOrNoSegmentControl.tag = indexPath.row
        cell.yesOrNoSegmentControl.addTarget(self, action: #selector(changeSegmentControlStatus(yesNoSegment:)), for: UIControl.Event.valueChanged)
        
        cell.displayData(title: conditionData.title ?? "",isOn:conditionData.isOn ?? false)
        cell.selectionStyle = .none
        
        return cell
    }
    
    @objc func changeSegmentControlStatus(yesNoSegment:UISegmentedControl){
        
        let tag = yesNoSegment.tag
        let conditionData = conditionArray[tag]
        let isConditionYes = yesNoSegment.selectedSegmentIndex == 0
        conditionData.isOn = isConditionYes
        conditionData.value = isConditionYes ? ConditionValue.Yes : ConditionValue.No
        let timeStamp:Double = getTimeStampForCurrenTime()
        
        //==========If Switch On Insert that Entry with ID in Database.....==========//
        if isConditionYes{
            DBManager.shared.insertSingleCondition(withID: conditionData.id, timeStamp: timeStamp) { (success, error) in
            }
        }else{
            //==========If Switch Off Delete that Entry with ID in Database.....==========//
            let _ =  DBManager.shared.deleteCondition(withID: conditionData.id)
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}



