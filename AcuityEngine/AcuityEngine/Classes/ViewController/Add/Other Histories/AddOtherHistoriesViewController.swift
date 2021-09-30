//
//  AddOtherHistoriesViewController.swift
//  AcuityEngine
//
//  Created by Bhoomi Jagani on 24/09/21.
//

import UIKit
import JGProgressHUD

let HEIGHT_OF_ROW_IN_TBL_INPUT_VIEW:CGFloat = UITableView.automaticDimension;
let HEIGHT_OF_ROW_IN_TBL_DATA_VIEW:CGFloat = 50;
class AddOtherHistoriesViewController:UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var tblOtherHistoryInputView: UITableView!
    @IBOutlet weak var tblOtherHistoryDataView: UITableView!
    var progrssHUD:JGProgressHUD = JGProgressHUD()
    
    var arrayForTblInputView:[HistoryInputModel] = []
    var arrayForTblDataView:[[OtherHistory:[HistoryDataDisplayModel]]] = []
    
    var arraySectionTitle = [OtherHistory.otherConditions,OtherHistory.familyHistory,OtherHistory.surgicalHistory,OtherHistory.socialHistory,OtherHistory.allergies];
    
    
    @IBOutlet weak var heightConstraintFortblOtherHistoryInputView: NSLayoutConstraint!
    @IBOutlet weak var heightConstraintFortblOtherHistoryDataView: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set Font For LAbel
        setFontForLabels()
        //======= Register HEader For Section in tblOtherHistoryDataView....======= //
        let headerNib = UINib.init(nibName: "OtherHistoryDataTableHeaderView", bundle: Bundle.main)
        tblOtherHistoryDataView.register(headerNib, forHeaderFooterViewReuseIdentifier: "OtherHistoryDataTableHeaderView")
        //======= Register HEader For Section in tblOtherHistoryDataView....======= //
        self.tblOtherHistoryDataView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
        self.tblOtherHistoryInputView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
        
        //======= Prepare array for table input view=======//
        
        arrayForTblInputView.append(HistoryInputModel(id: OtherHistoryId.otherConditionsId, name: OtherHistory.otherConditions, description: ""))
        arrayForTblInputView.append(HistoryInputModel(id: OtherHistoryId.familyHistoryId, name: OtherHistory.familyHistory, description: ""))
        arrayForTblInputView.append(HistoryInputModel(id: OtherHistoryId.surgicalHistoryId, name: OtherHistory.surgicalHistory, description: ""))
        arrayForTblInputView.append(HistoryInputModel(id: OtherHistoryId.socialHistoryId, name: OtherHistory.socialHistory, description: ""))
        arrayForTblInputView.append(HistoryInputModel(id: OtherHistoryId.allergiesId, name: OtherHistory.allergies, description: ""))
        
        //======= Fetch Data from Database for tblOtherHistoryDataView======== //
        fetchHistoryDataFromDatabase()
    }
    //========================================================================================================
    //MARK:Set Font For Labels..
    //========================================================================================================
    func setFontForLabels(){
        lblTitle.font = Fonts.kCellTitleFontListInAddSection
    }
    //========================================================================================================
    //MARK:Fetch History Data From Database..
    //========================================================================================================
    
    func fetchHistoryDataFromDatabase(){
        //Global Queue
        progrssHUD = showIndicatorInView(view: self.view)
        DispatchQueue.global(qos: .background).async {
            
            let isTableCreated = DBManager.shared.createTableOtherHistory()
            //Fetch data......
            if isTableCreated{
                let historyData = DBManager.shared.loadHistories()
                //Main Queue......
                DispatchQueue.main.async {
                    /*
                     After fetching data from dataabse, prepare array of dicitonary. Dictionary will have key -> title of section and Value -> Array
                     Filter data with Id of Histyory type and fetch History Name and MAke it's key. Sp E.g. If id = 1, name will be otherCondition and key will be of other condition. IT will have value which have Id = 1 in database..
                     HistoryDataDisplayModel will have Id,name and textValue and TimeStamp...
                     */
                    for id in OtherHistoryId.allCases {
                        let filteredIdData = historyData?.filter{$0.id == id}
                        if filteredIdData?.count ?? 0>0{
                            //Get name of filter data...
                            let name = filteredIdData?.first?.name ?? OtherHistory(rawValue: "none")
                            self.arrayForTblDataView.append([name!:filteredIdData!])
                        }
                        else{
                            let name = getHistoryName(id: id)
                            self.arrayForTblDataView.append([name:[]])
                        }
                    }
                    self.tblOtherHistoryDataView.reloadData()
                    self.tblOtherHistoryInputView.reloadData()
                    //Hide Progress HUD
                    self.progrssHUD.dismiss(animated: true)
                }
            }
        }
        /*
         Ex. of arrayForTblDataView = [[AcuityEngine.OtherHistory.otherConditions: [AcuityEngine.HistoryDataDisplayModel]], [AcuityEngine.OtherHistory.surgicalHistory: []],
         [AcuityEngine.OtherHistory.familyHistory: [AcuityEngine.HistoryDataDisplayModel]],
         [AcuityEngine.OtherHistory.socialHistory: []],
         [AcuityEngine.OtherHistory.allergies: [AcuityEngine.HistoryDataDisplayModel]]]
         It has key of Section Title and Value are Array Of Input Data in Textfield which convert into model and save in database..
         */
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        tblOtherHistoryInputView.layer.removeAllAnimations()
        heightConstraintFortblOtherHistoryInputView.constant = tblOtherHistoryInputView.contentSize.height
        tblOtherHistoryDataView.layer.removeAllAnimations()
        heightConstraintFortblOtherHistoryDataView.constant = tblOtherHistoryDataView.contentSize.height
        UIView.animate(withDuration: 0.5) {
            self.updateViewConstraints()
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MRK:- TABLEVIEW METHODS....
    //UITableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case tblOtherHistoryInputView:
            do{
                return arrayForTblInputView.count;
            }
            
        case tblOtherHistoryDataView:
            do{
                // Return the number of rows in the section.
                let sectionTitle:OtherHistory = arraySectionTitle[section];
                /*
                 arrayForTblDataView will have [key = sectionTitle and value = Array of model]...
                 So, first fetch key and then value for key...so number of rows in section will have count of array for key(sectionTitle)
                 */
                for item in arrayForTblDataView {
                    if item.first?.key == sectionTitle{
                        return item.first?.value.count ?? 0
                    }
                }
                
            }
            
        default:
            break
        }
        return 0
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == tblOtherHistoryDataView{
            return arraySectionTitle.count
        }
        return 1;
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView == tblOtherHistoryDataView{
            return HEIGHT_OF_ROW_IN_TBL_DATA_VIEW
        }
        return 0
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if tableView == tblOtherHistoryDataView{
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "OtherHistoryDataTableHeaderView") as! OtherHistoryDataTableHeaderView
            
            print("section---\(section)")
            print("arraySectionTitle[section].rawValue---\(arraySectionTitle[section].rawValue)")
            headerView.lblTitle.text = arraySectionTitle[section].rawValue;
            return headerView
        }
        return UIView()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == tblOtherHistoryInputView{
            return HEIGHT_OF_ROW_IN_TBL_INPUT_VIEW;
        }
        return HEIGHT_OF_ROW_IN_TBL_DATA_VIEW;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        switch tableView {
        case tblOtherHistoryInputView:
            do{
                let cell:OtherHistoryInputView  = tblOtherHistoryInputView.dequeueReusableCell(withIdentifier: "OtherHistoryInputView", for: indexPath) as! OtherHistoryInputView
                //========================================================================//
                let historyModel:HistoryInputModel = arrayForTblInputView[indexPath.row];
                cell.displayData(model:historyModel);
                
                //========================================================================//
                //return value from callback
                cell.returnValue = {[weak self] value in
                    //=======convert HistoryInputModel to HistoryDataDisplayModel and Save it to database====//
                    let id = (historyModel.id ?? OtherHistoryId(rawValue: 0))
                    let name = (historyModel.name ?? OtherHistory(rawValue: "none"))
                    self?.addHistory(HistoryDataDisplayModel(id: id!,name: name!, txtValue: value, timeStamp: getTimeStampForCurrenTime()),indexPath: indexPath)
                    cell.txtFieldHistoryText.text = ""
                }
                //========================================================================//
                return cell
                
            }
            
        case tblOtherHistoryDataView:
            do{
                let cell:OtherHistoryTextCell = tblOtherHistoryDataView.dequeueReusableCell(withIdentifier: "OtherHistoryTextCell", for: indexPath) as! OtherHistoryTextCell
                //========================================================================//
                /*
                 HistoryDataDisplayModel will have [key:value]. Key will be sectionTitle and array will be Data array..
                 */
                let sectionTitle:OtherHistory = arraySectionTitle[indexPath.section];
                
                var arrHistoryDataDisplayModel:[HistoryDataDisplayModel] = []
                for item in arrayForTblDataView {
                    if item.first?.key == sectionTitle{
                        arrHistoryDataDisplayModel = item.first?.value ?? []
                        
                        break;
                    }
                }
                //========================================================================//
                let historyModel = arrHistoryDataDisplayModel[indexPath.row]
                cell.btnDeleteCall = {
                    self.deleteOne(indexPath, model: historyModel)
                }
                cell.displayData(historyTxt: historyModel.txtValue ?? "")
                //========================================================================//
                return cell;
            }
        default:
            break;
        }
        
        return cell;
        
    }
    //MARK:- Add History Data
    func addHistory(_ model: HistoryDataDisplayModel,indexPath:IndexPath) {
        
        //========================================================================//
        //Find index of model name as key from array.....
        let index =  self.arrayForTblDataView.firstIndex{$0.first?.key == model.name}
        //let index =  indexPath.section
        //========================================================================//
        if let index = index, arrayForTblDataView.count>index ,(arrayForTblDataView[index].first != nil),(model.name != nil){
            //====== Fetch array of model from arrayForTblDataView at Index =======//
            var historyDatarray =  arrayForTblDataView[index ].first?.value
            //===== Append new model to arrayOfModel======//
            historyDatarray?.append(model)
            //====== Replace Key-Value pair with new array of model======//
            arrayForTblDataView[index] = [model.name!:historyDatarray!];
            
            //===========Global Queue========//
            //==========Add row in table and update table===========//
            progrssHUD = showIndicatorInView(view: self.view)
            DispatchQueue.global(qos: .background).async {
                DBManager.shared.insertHistoryData(model: model) { [weak self] (success, error) in
                    if error == nil && success == true{
                        DispatchQueue.main.async {
                            //========== Reload Table =========//
                            if let count = historyDatarray?.count,count>0{
//                                self?.tblOtherHistoryDataView.beginUpdates()
//                                self?.tblOtherHistoryDataView.insertRows(at:[IndexPath(row: count-1, section: index)], with: .fade)
//                                self?.tblOtherHistoryDataView.endUpdates()
                                self?.perform(#selector(self?.reloadTable), with: nil, afterDelay: 1)
                                
                            }
                            //===========================================//
                        }
                    }
                }
            }
        }
        print("arrayForTblDataView",arrayForTblDataView)
        
    }
    //MARK: Delete History Data
    func deleteOne(_ indexPath: IndexPath,model:HistoryDataDisplayModel) {
        //===== Get index from section======//
        let index =  self.arrayForTblDataView.firstIndex{$0.first?.key == model.name}
        if let index = index,arrayForTblDataView.count>index,(arrayForTblDataView[index].first != nil){
            //====== Get value from [Dictionary] at index ======//
            var historyDatarray =  arrayForTblDataView[index].first?.value
            guard historyDatarray?.count ?? 0>=indexPath.row else {
                return;
            }
            //====== Remove value at index =======//
            historyDatarray?.remove(at:indexPath.row)
            let modelName = arrayForTblDataView[index].first?.key
            //====== Replace Key-Value pair with new array of model======//
            arrayForTblDataView[index] = [modelName!:historyDatarray!];
            
            //===========Global Queue========//
            //==========Add row in table and update table===========//
            progrssHUD = showIndicatorInView(view: self.view)
            DispatchQueue.global(qos: .background).async {
                let isSuccess = DBManager.shared.deleteHistory(model: model)
                DispatchQueue.main.async {
                    if isSuccess{
//                        self.tblOtherHistoryDataView.beginUpdates()
//                        self.tblOtherHistoryDataView.deleteRows(at:[indexPath], with: .fade)
//                        self.tblOtherHistoryDataView.endUpdates()
                        self.perform(#selector(self.reloadTable), with: nil, afterDelay: 1)
                    }
                    //===========================================//
                }
            }
        }
        
    }
    @objc func reloadTable() {
        DispatchQueue.main.async { //please do all interface updates in main thread only
            self.tblOtherHistoryDataView.reloadData()
            
            //Hide Progress HUD
            self.progrssHUD.dismiss(animated: true)
            
        }
    }
}

