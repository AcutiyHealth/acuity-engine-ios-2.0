//
//  HistoryValueListController.swift
//  AcuityEngine
//
//  Created by Bhoomi Jagani on 13/11/21.
//

import Foundation

import UIKit
import SVProgressHUD

typealias CompletionAddOtherHistoriesViewOpen = (_ open: Bool?) -> Void
class HistoryValueListViewController: UIViewController {
    var otherHistoryFromSuperView:[OtherHistory:OtherHistoryId]?{
        didSet{
            //======= Fetch Data from Database for tblOtherHistoryDataView======== //
            fetchHistoryDataFromDatabase()
        }
    }
    
    @IBOutlet weak var tblHistory: UITableView!
    var addHistoryVC : AddOtherHistoriesViewController?
    var handler: CompletionAddOtherHistoriesViewOpen?
    var arrayForTblDataView:[HistoryDataDisplayModel] = []
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var historyView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set font for title
        setFontForLabel()
        
        
        // Do any additional setup after loading the view.
    }
    func  setFontForLabel() {
        self.lblTitle.font = Fonts.kCellTitleFontListInAddSection
    }
    func setHandler(handler: @escaping CompletionAddOtherHistoriesViewOpen){
        self.handler = handler
    }
    
    //========================================================================================================
    //MARK:Fetch History Data From Database..
    //========================================================================================================
    func fetchHistoryDataFromDatabase(){
        
        self.lblTitle.text = self.otherHistoryFromSuperView?.keys.first?.rawValue ?? ""
        
        guard let otherHistoryId = self.otherHistoryFromSuperView?.values.first else {return}
        
        //Global Queue
        Utility.showSVProgress()
        DispatchQueue.global(qos: .background).async {
            
            //let historyData = DBManager.shared.loadHistories()
            DBManager.shared.loadHisory(withID: (otherHistoryId.rawValue)) { (success, historyData) in
                //Main Queue......
                DispatchQueue.main.async {
                    if success{
                        self.arrayForTblDataView = historyData ?? []
                        if self.arrayForTblDataView.count <= 0{
                            setNoDataInfoIfRecordsNotExists(tblView: self.tblHistory,font: Fonts.kCellHistoryDataValueFontInAddSection)
                        }
                        self.tblHistory.reloadData()
                        //Hide Progress HUD
                        SVProgressHUD.dismiss()
                    }
                    
                }
                
            }
            
        }
    }
    //MRK:- TABLEVIEW METHODS....
    //UITableView
    
    
}
extension HistoryValueListViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayForTblDataView.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return HEIGHT_OF_ROW_IN_TBL_INPUT_VIEW;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:OtherHistoryTextCell = tblHistory.dequeueReusableCell(withIdentifier: "OtherHistoryTextCell", for: indexPath) as! OtherHistoryTextCell
        
        //========================================================================//
        let historyModel = arrayForTblDataView[indexPath.row]
        cell.btnDeleteCall = {
            if let parentVC = self.view.window?.rootViewController {
                let deleteAction = UIAlertAction(title: Titles.BTN_DELETE, style: .destructive, handler: { (action: UIAlertAction!) in
                    //Delete Medication....
                    self.deleteOne(indexPath, model: historyModel)
                })
                let cancelAction = UIAlertAction(title: Titles.BTN_CANCEL, style: .default, handler: { (action: UIAlertAction!) in
                    //Hide Alert
                    
                })
                parentVC.presentAlert(title: AlertMessages.DELETE_CONFIRMATION_TITLE, message: AlertMessages.DELETE_CONFIRMATION_MESSAGE, actions: cancelAction,deleteAction)
            }
            
        }
        cell.displayData(historyTxt: historyModel.txtValue ?? "")
        //========================================================================//
        
        return cell;
        
    }
    
    //MARK: Delete History Data
    func deleteOne(_ indexPath: IndexPath,model:HistoryDataDisplayModel) {
        
        //===========Global Queue========//
        //==========Add row in table and update table===========//
        Utility.showSVProgress()
        DispatchQueue.global(qos: .background).async {
            let isSuccess = DBManager.shared.deleteHistory(model: model)
            DispatchQueue.main.async {
                if isSuccess{
                    Utility.hideSVProgress()
                    //====== Remove value at index =======//
                    self.arrayForTblDataView.remove(at:indexPath.row)
                    if let parentVC =  self.view.window?.rootViewController {
                        Utility.showAlertWithOKBtn(onViewController: parentVC, message: AlertMessages.SUCCESS_HISTORY_DELETE)
                    }
                    
                    self.perform(#selector(self.reloadTable), with: nil, afterDelay: 1)
                }
                //===========================================//
            }
        }
        
    }
    @objc func reloadTable() {
        DispatchQueue.main.async { //please do all interface updates in main thread only
            self.tblHistory.backgroundView = nil
            if self.arrayForTblDataView.count <= 0{
                setNoDataInfoIfRecordsNotExists(tblView: self.tblHistory,font: Fonts.kCellHistoryDataValueFontInAddSection)
            }
            self.tblHistory.reloadData()
            
        }
    }
    //========================================================================================================
    //MARK: Open Add History Text..
    //========================================================================================================
    @IBAction func openAddHistoryViewController(index:Int){
        
        //Add detail value view as child view
        addHistoryVC = UIStoryboard(name: Storyboard.add.rawValue, bundle: nil).instantiateViewController(withIdentifier: "AddOtherHistoriesViewController") as? AddOtherHistoriesViewController
        self.addChild(addHistoryVC!)
        addHistoryVC?.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        
        //Show animation when view added.....
        animationForDetailViewWhenAdded(subviewToAdd: (addHistoryVC?.view)!, in: self.view)
        
        addHistoryVC?.view.setNeedsDisplay()
        addHistoryVC?.didMove(toParent: self)
        addHistoryVC?.view.tag = 222
        
        addHistoryVC?.lblTitle.text = self.lblTitle.text
        if  otherHistoryFromSuperView != nil{
            let model = HistoryDataDisplayModel()
            model.id = otherHistoryFromSuperView?.values.first
            model.name = otherHistoryFromSuperView?.keys.first
            addHistoryVC?.modelFromSuperView = model
        }
        //let historyModel:HistoryDataDisplayModel = model!
        let modelNew = HistoryDataDisplayModel()
        addHistoryVC?.setHandler(handler: { [weak self] (model) in
            if model != nil{
           
                modelNew.id = model?.id
                modelNew.name = model?.name
                modelNew.txtValue = model?.txtValue ?? ""
                modelNew.timeStamp = model?.timeStamp
                self?.arrayForTblDataView.append(model!)
                self?.reloadTable()
            }
        })
        //Pass selected Symptoms to AddSymptomViewController
        //let vitalData = HistoryArray[index]
        //valueListHistoryVC?.vitalModel = vitalData
        //setUpCloseButton(frame:btnFrame , btnImage:btnImage , btnTintColor:btnTintColor! )
        //Hide main view of Detail Pullup class
        
        historyView.isHidden = true
        
        
        if let handler = handler{
            handler(true)
        }
        
    }
    
    //MARK:-
    func removeAddHistoryViewController(){
        //Show animation when view removed from superview.......
        animationForDetailViewWhenRemoved(from: self.view)
        
        if addHistoryVC != nil{
            historyView.isHidden = false
            addHistoryVC?.view.removeFromSuperview()
            addHistoryVC?.removeFromParent()
        }
        
    }
}




