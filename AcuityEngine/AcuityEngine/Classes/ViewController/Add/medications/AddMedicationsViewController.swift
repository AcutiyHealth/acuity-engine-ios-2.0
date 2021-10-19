//
//  AddMedicationsViewController.swift
//  AcuityEngine
//
//  Created by Bhoomi Jagani on 24/09/21.
//

import UIKit
import JGProgressHUD


var arrayMedicationSectionTitle = [Medication.vitamin,Medication.diabetes];

class AddMedicationsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var tblMedicationInputView: UITableView!
    @IBOutlet weak var tblMedicationDataView: UITableView!
    var progrssHUD:JGProgressHUD = JGProgressHUD()
    
    var arrayForTblInputView:[MedicationInputModel] = []
    var arrayForTblDataView:[[Medication:[MedicationDataDisplayModel]]] = []

    
    @IBOutlet weak var heightConstraintFortblMedicationInputView: NSLayoutConstraint!
    @IBOutlet weak var heightConstraintFortblMedicationDataView: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set Font For LAbel
        setFontForLabels()
        //======= Register HEader For Section in tblMedicationDataView....======= //
        let headerNib = UINib.init(nibName: "MedicationDataTableHeaderView", bundle: Bundle.main)
        tblMedicationDataView.register(headerNib, forHeaderFooterViewReuseIdentifier: "MedicationDataTableHeaderView")
        //======= Register HEader For Section in tblMedicationDataView....======= //
        self.tblMedicationDataView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
        self.tblMedicationInputView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
        
        //======= Prepare array for table input view=======//
        
        arrayForTblInputView.append(MedicationInputModel(id: MedicationId.vitaminId, name: Medication.vitamin, description: ""))
        arrayForTblInputView.append(MedicationInputModel(id: MedicationId.diabetesId, name: Medication.diabetes, description: ""))

        //======= Fetch Data from Database for tblMedicationDataView======== //
        fetchMedicationDataFromDatabase()
    }
    //========================================================================================================
    //MARK:deinit..
    //========================================================================================================
    deinit {
        self.tblMedicationDataView.removeObserver(self, forKeyPath: "contentSize")
        self.tblMedicationInputView.removeObserver(self, forKeyPath: "contentSize")
    }
    //========================================================================================================
    //MARK:Set Font For Labels..
    //========================================================================================================
    func setFontForLabels(){
        lblTitle.font = Fonts.kCellTitleFontListInAddSection
    }
    //========================================================================================================
    //MARK:Fetch Medication Data From Database..
    //========================================================================================================
 
    func fetchMedicationDataFromDatabase(){
        //Global Queue
        progrssHUD = showIndicatorInView(view: self.view)
        DispatchQueue.global(qos: .background).async {
       
            //Fetch data......
        
                let medicationData = DBManager.shared.loadMedications()
                //Main Queue......
                DispatchQueue.main.async {
                    /*
                     After fetching data from dataabse, prepare array of dicitonary. Dictionary will have key -> title of section and Value -> Array
                     Filter data with Id of Histyory type and fetch Medication Name and MAke it's key. Sp E.g. If id = 1, name will be otherCondition and key will be of other condition. IT will have value which have Id = 1 in database..
                     MedicationDataDisplayModel will have Id,name and textValue and TimeStamp...
                     */
                    for id in MedicationId.allCases {
                        let filteredIdData = medicationData?.filter{$0.id == id}
                        if filteredIdData?.count ?? 0>0{
                            //Get name of filter data...
                            let name = filteredIdData?.first?.name ?? Medication(rawValue: "none")
                            self.arrayForTblDataView.append([name!:filteredIdData!])
                        }
                        else{
                            let name = getMedicationName(id: id)
                            self.arrayForTblDataView.append([name:[]])
                        }
                    }
                    self.tblMedicationDataView.reloadData()
                    self.tblMedicationInputView.reloadData()
                    //Hide Progress HUD
                    self.progrssHUD.dismiss(animated: true)
                }
            
        }
        /*
         Ex. of arrayForTblDataView = [[AcuityEngine.Medication.otherConditions: [AcuityEngine.MedicationDataDisplayModel]], [AcuityEngine.Medication.surgicalMedication: []],
         [AcuityEngine.Medication.familyMedication: [AcuityEngine.MedicationDataDisplayModel]],
         [AcuityEngine.Medication.socialMedication: []],
         [AcuityEngine.Medication.allergies: [AcuityEngine.MedicationDataDisplayModel]]]
         It has key of Section Title and Value are Array Of Input Data in Textfield which convert into model and save in database..
         */
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        tblMedicationInputView.layer.removeAllAnimations()
        heightConstraintFortblMedicationInputView.constant = tblMedicationInputView.contentSize.height
        tblMedicationDataView.layer.removeAllAnimations()
        heightConstraintFortblMedicationDataView.constant = tblMedicationDataView.contentSize.height
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
        case tblMedicationInputView:
            do{
                return arrayForTblInputView.count;
            }
            
        case tblMedicationDataView:
            do{
                // Return the number of rows in the section.
                let sectionTitle:Medication = arrayMedicationSectionTitle[section];
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
        if tableView == tblMedicationDataView{
            return arrayMedicationSectionTitle.count
        }
        return 1;
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView == tblMedicationDataView{
            return HEIGHT_OF_ROW_IN_TBL_DATA_VIEW
        }
        return 0
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if tableView == tblMedicationDataView{
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "MedicationDataTableHeaderView") as! MedicationDataTableHeaderView
            
            print("section---\(section)")
            print("arrayMedicationSectionTitle[section].rawValue---\(arrayMedicationSectionTitle[section].rawValue)")
            headerView.lblTitle.text = arrayMedicationSectionTitle[section].rawValue;
            return headerView
        }
        return UIView()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == tblMedicationInputView{
            return HEIGHT_OF_ROW_IN_TBL_INPUT_VIEW;
        }
        return HEIGHT_OF_ROW_IN_TBL_DATA_VIEW;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        switch tableView {
        case tblMedicationInputView:
            do{
                let cell:MedicationInputView  = tblMedicationInputView.dequeueReusableCell(withIdentifier: "MedicationInputView", for: indexPath) as! MedicationInputView
                //========================================================================//
                let medicationModel:MedicationInputModel = arrayForTblInputView[indexPath.row];
                cell.displayData(model:medicationModel);
                
                //========================================================================//
                //return value from callback
                cell.returnValue = {[weak self] value in
                    //=======convert MedicationInputModel to MedicationDataDisplayModel and Save it to database====//
                    let id = (medicationModel.id ?? MedicationId(rawValue: 0))
                    self?.addMedication(MedicationDataDisplayModel(id: id!, txtValue: value, timeStamp: getTimeStampForCurrenTime()),indexPath: indexPath)
                    cell.txtFieldMedicationText.text = ""
                }
                //========================================================================//
                return cell
                
            }
            
        case tblMedicationDataView:
            do{
                let cell:MedicationTextCell = tblMedicationDataView.dequeueReusableCell(withIdentifier: "MedicationTextCell", for: indexPath) as! MedicationTextCell
                //========================================================================//
                /*
                 MedicationDataDisplayModel will have [key:value]. Key will be sectionTitle and array will be Data array..
                 */
                let sectionTitle:Medication = arrayMedicationSectionTitle[indexPath.section];
                
                var arrMedicationDataDisplayModel:[MedicationDataDisplayModel] = []
                for item in arrayForTblDataView {
                    if item.first?.key == sectionTitle{
                        arrMedicationDataDisplayModel = item.first?.value ?? []
                        
                        break;
                    }
                }
                //========================================================================//
                let medicationModel = arrMedicationDataDisplayModel[indexPath.row]
                cell.btnDeleteCall = {
                    self.deleteOne(indexPath, model: medicationModel)
                }
                cell.displayData(medicationTxt: medicationModel.txtValue ?? "")
                //========================================================================//
                return cell;
            }
        default:
            break;
        }
        
        return cell;
        
    }
    //MARK:- Add Medication Data
    func addMedication(_ model: MedicationDataDisplayModel,indexPath:IndexPath) {
        //========================================================================//
        self.view.endEditing(true)
        //========================================================================//
        //Find index of model name as key from array.....
        let index =  self.arrayForTblDataView.firstIndex{$0.first?.key == model.name}
        //let index =  indexPath.section
        //========================================================================//
        if let index = index, arrayForTblDataView.count>index ,(arrayForTblDataView[index].first != nil),(model.name != nil){
            //====== Fetch array of model from arrayForTblDataView at Index =======//
            var medicationDatarray =  arrayForTblDataView[index ].first?.value
            //===== Append new model to arrayOfModel======//
            medicationDatarray?.append(model)
            //====== Replace Key-Value pair with new array of model======//
            arrayForTblDataView[index] = [model.name!:medicationDatarray!];
            
            //===========Global Queue========//
            //==========Add row in table and update table===========//
            progrssHUD = showIndicatorInView(view: self.view)
            DispatchQueue.global(qos: .background).async {
                DBManager.shared.insertMedicationData(model: model) { [weak self] (success, error) in
                    if error == nil && success == true{
                        DispatchQueue.main.async {
                            //========== Reload Table =========//
                            if let count = medicationDatarray?.count,count>0{
                                //                                self?.tblMedicationDataView.beginUpdates()
                                //                                self?.tblMedicationDataView.insertRows(at:[IndexPath(row: count-1, section: index)], with: .fade)
                                //                                self?.tblMedicationDataView.endUpdates()
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
    //MARK: Delete Medication Data
    func deleteOne(_ indexPath: IndexPath,model:MedicationDataDisplayModel) {
        //===== Get index from section======//
        let index =  self.arrayForTblDataView.firstIndex{$0.first?.key == model.name}
        if let index = index,arrayForTblDataView.count>index,(arrayForTblDataView[index].first != nil){
            //====== Get value from [Dictionary] at index ======//
            var medicationDatarray =  arrayForTblDataView[index].first?.value
            guard medicationDatarray?.count ?? 0>=indexPath.row else {
                return;
            }
            //====== Remove value at index =======//
            medicationDatarray?.remove(at:indexPath.row)
            let modelName = arrayForTblDataView[index].first?.key
            //====== Replace Key-Value pair with new array of model======//
            arrayForTblDataView[index] = [modelName!:medicationDatarray!];
            
            //===========Global Queue========//
            //==========Add row in table and update table===========//
            progrssHUD = showIndicatorInView(view: self.view)
            DispatchQueue.global(qos: .background).async {
                let isSuccess = DBManager.shared.deleteMedication(model: model)
                DispatchQueue.main.async {
                    if isSuccess{
                        //                        self.tblMedicationDataView.beginUpdates()
                        //                        self.tblMedicationDataView.deleteRows(at:[indexPath], with: .fade)
                        //                        self.tblMedicationDataView.endUpdates()
                        self.perform(#selector(self.reloadTable), with: nil, afterDelay: 1)
                    }
                    //===========================================//
                }
            }
        }
        
    }
    @objc func reloadTable() {
        DispatchQueue.main.async { //please do all interface updates in main thread only
            self.tblMedicationDataView.reloadData()
            
            //Hide Progress HUD
            self.progrssHUD.dismiss(animated: true)
            
        }
    }
    
}


