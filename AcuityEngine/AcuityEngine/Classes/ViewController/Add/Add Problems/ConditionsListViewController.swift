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
    var ConditionArray : [ConditionsModel] = []
    
    @IBOutlet weak var btnClose: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadConditionsData()
        
        tblConditions.reloadData()
        // Do any additional setup after loading the view.
    }
    func loadConditionsData(){
        
           do {
               // Fetch data from Txt file and convert it in array to display in tableview
               if let path = Bundle.main.path(forResource: "Conditions", ofType: "txt"){
                   let data = try String(contentsOfFile:path, encoding: String.Encoding.utf8)
                arrayOfStringsCondition = data.components(separatedBy: "\n")
                
               }
           } catch let err as NSError {
               // do something with Error
               print(err)
           }
     
        
        for item in arrayOfStringsCondition{
            let Condition = ConditionsModel(title: item, isOn: false)
            ConditionArray.append(Condition)
        }
       
    }

}
extension ConditionsListViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ConditionArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: AddConditionCell = tableView.dequeueReusableCell(withIdentifier: "AddConditionCell", for: indexPath as IndexPath) as? AddConditionCell else {
            fatalError("AcuityDetailDisplayCell cell is not found")
        }
        let ConditionData = ConditionArray[indexPath.row]
        cell.displayData(title: ConditionData.title ?? "")
        cell.selectionStyle = .none
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}


