//
//  OtherHistoryTitleListViewController.swift
//  AcuityEngine
//
//  Created by Bhoomi Jagani on 13/11/21.
//

import Foundation

import UIKit
import SVProgressHUD


let HEIGHT_OF_ROW_IN_TBL_INPUT_VIEW:CGFloat = UITableView.automaticDimension;
let HEIGHT_OF_ROW_IN_TBL_DATA_VIEW:CGFloat = 40;
var arrayOtherHistorySectionTitle = [[OtherHistory.otherConditions:OtherHistoryId.otherConditionsId],[OtherHistory.familyHistory:OtherHistoryId.familyHistoryId],[OtherHistory.surgicalHistory:OtherHistoryId.surgicalHistoryId],[OtherHistory.socialHistory:OtherHistoryId.socialHistoryId],[OtherHistory.allergies:OtherHistoryId.allergiesId],[OtherHistory.consults:OtherHistoryId.consultsId]];

typealias CompletionhistoryValueListViewOpen = (_ open: Bool?) -> Void
class HistoryTitleListViewController: UIViewController {
    
    @IBOutlet weak var tblHistory: UITableView!
    var valueListHistoryVC : HistoryValueListViewController?
    var handler: CompletionhistoryValueListViewOpen?
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var historyView: UIView!
    
    @IBOutlet weak var btnClose: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set font for title
        setFontForLabel()
        //
        tblHistory.reloadData()
        // Do any additional setup after loading the view.
    }
    func  setFontForLabel() {
        self.lblTitle.font = Fonts.kCellTitleFontListInAddSection
    }
    func setHandler(handler: @escaping CompletionhistoryValueListViewOpen){
        self.handler = handler
    }
    
}
extension HistoryTitleListViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOtherHistorySectionTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: LabelInListAddSectionCell = tableView.dequeueReusableCell(withIdentifier: "LabelInListAddSectionCell", for: indexPath as IndexPath) as? LabelInListAddSectionCell else {
            fatalError("LabelInListAddSectionCell cell is not found")
        }
        let historyType:[OtherHistory:OtherHistoryId] = arrayOtherHistorySectionTitle[indexPath.row]
        if historyType.keys.count > 0{
            let historyName:OtherHistory = (historyType.keys.first)!
            cell.displayData(title: historyName.rawValue )
        }
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        openAddHistoryViewController(index: indexPath.row)
        
    }
    
    func openAddHistoryViewController(index:Int){
        
        //Add detail value view as child view
        valueListHistoryVC = UIStoryboard(name: Storyboard.add.rawValue, bundle: nil).instantiateViewController(withIdentifier: "HistoryValueListViewController") as? HistoryValueListViewController
        self.addChild(valueListHistoryVC!)
        valueListHistoryVC?.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        
        //Show animation when view added.....
        animationForDetailViewWhenAdded(subviewToAdd: (valueListHistoryVC?.view)!, in: self.view)
        
        valueListHistoryVC?.view.setNeedsDisplay()
        valueListHistoryVC?.didMove(toParent: self)
        valueListHistoryVC?.view.tag = 111
        
        //Pass selected Symptoms to AddSymptomViewController
        let historyData = arrayOtherHistorySectionTitle[index]
        valueListHistoryVC?.otherHistoryFromSuperView = historyData
        //setUpCloseButton(frame:btnFrame , btnImage:btnImage , btnTintColor:btnTintColor! )
        //Hide main view of Detail Pullup class
        
        historyView.isHidden = true
        
        
        if let handler = handler{
            handler(true)
        }
        
    }
    
    //MARK:-
    func removeHistoryValueViewController(){
        //Show animation when view removed from superview.......
        animationForDetailViewWhenRemoved(from: self.view)
        
        if valueListHistoryVC != nil{
            historyView.isHidden = false
            valueListHistoryVC?.view.removeFromSuperview()
            valueListHistoryVC?.removeFromParent()
        }
        
        /*if let parentVC = self.parent {
            if let parentVC = parentVC as? AddOptionSelectionViewController {
                // parentVC is someViewController
                parentVC.removeBackButton()
            }
        }*/
    }
    
    func removeAddHistoryViewController(){
        //Show animation when view removed from superview.......
        animationForDetailViewWhenRemoved(from: self.view)
        
        if valueListHistoryVC != nil{
            valueListHistoryVC?.removeAddHistoryViewController()
        }
       
    }
}




