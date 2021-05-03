//
//  ConditionsListViewController.swift
//  AcuityEngine
//
//  Created by Bhoomi Jagani on 04/03/21.
//

import UIKit

class ConditionsListViewController: UIViewController {
    
    @IBOutlet weak var tblConditions: UITableView!
    var arrayOfStringsCondition: [String] = []
    var conditionArray : [ConditionsModel] = []
    
    @IBOutlet weak var btnClose: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadConditionsData()
        
        // Do any additional setup after loading the view.
    }
    func loadConditionsData(){
        DispatchQueue.global().async {
            do {
                // Fetch data from Txt file and convert it in array to display in tableview
                if  let isConditionDataAdded = UserDefaults.standard.string(forKey: "isConditionDataAdded"){
                    if isConditionDataAdded == "Yes"{
                        self.fetchConditionsDataFromDatabase()
                    }
                }else{
                    //save condition data in database
                    DBManager.shared.insertConditionData(completionHandler: { (sucess,error) in
                        if sucess{
                            UserDefaults.standard.set("Yes", forKey: "isConditionDataAdded") //String
                            self.fetchConditionsDataFromDatabase()
                        }
                    })
                }
                
            }
        }
    }
    
    func fetchConditionsDataFromDatabase(){
        guard let conditionArray = DBManager.shared.loadConditions() else { return }
        self.conditionArray.append(contentsOf: conditionArray)
        DispatchQueue.main.async {
            
            self.tblConditions.reloadData()
        }
        
    }
}
extension ConditionsListViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conditionArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: AddConditionCell = tableView.dequeueReusableCell(withIdentifier: "AddConditionCell", for: indexPath as IndexPath) as? AddConditionCell else {
            fatalError("AcuityDetailDisplayCell cell is not found")
        }
        let conditionData = conditionArray[indexPath.row]
        cell.yesOrNoSwitch.tag = indexPath.row
        cell.yesOrNoSwitch.addTarget(self, action: #selector(changeSwitchStatus(onOffSwitch:)), for: UIControl.Event.touchUpInside)
        cell.displayData(title: conditionData.title ?? "",isOn:conditionData.isOn ?? false)
        cell.selectionStyle = .none
        
        return cell
    }
    @objc func changeSwitchStatus(onOffSwitch:UISwitch){
        let tag = onOffSwitch.tag
        let conditionData = conditionArray[tag]
        conditionData.isOn = onOffSwitch.isOn
        conditionData.value = onOffSwitch.isOn ? ConditionValue.Yes : ConditionValue.No
//        if let row = self.conditionArray.firstIndex(where: {$0.id == tag}) {
//            conditionArray[row] = conditionData
//        }
        DBManager.shared.updateCondition(withID: conditionData.id, isSelected: onOffSwitch.isOn)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}


