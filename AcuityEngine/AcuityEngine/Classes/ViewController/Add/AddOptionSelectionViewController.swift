//
//  AddOptionViewController.swift
//  AcuityEngine
//
//  Created by Bhoomi Jagani on 04/03/21.
//

import Foundation
import UIKit
import SOPullUpView

class AddOptionSelectionViewController:UIViewController{
    
    // MARK: - Outlet
    @IBOutlet weak var addOptionTableView: UITableView!
    @IBOutlet weak var handleArea: HandleView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var visualEffectView: UIView!
    @IBOutlet var collection: UICollectionView!
    
    var size:CGFloat = 0;
    //Set From Main View Controller.....
    var isAnimationEnabledForSubView:Bool = true
    //Object of Profilevalue viewcontroller...
    var symptomsVC : SymptomsListViewController?
    var conditionsVC : ConditionsListViewController?
    var vitalsVC : VitalsListViewController?
    var medicationsVC : AddMedicationsViewController?
    var historiesVC : HistoryTitleListViewController?
    var preventionVC : AddPreventionFromListViewController?
    
    var addOptionArray: [[String:String]] = [["title":AddOption.vitals.rawValue,"description":"Please log your daily vitals to understand your wellness."],["title":AddOption.symptom.rawValue,"description":"A place for you to track your symptoms on a daily basis or chronically."],["title":AddOption.conditions.rawValue,"description":"Start Here to track any conditions you may have from our list."],["title":AddOption.medications.rawValue,"description":"A convenient way to note down what you take daily."],["title":AddOption.otherHistory.rawValue,"description":"Complete your data repository by noting other historical information about yourself."],["title":AddOption.preventionTracker.rawValue,"description":"Follow USPSTF guidelines on your recommended prevention."]]
    //var labelsAsStringForMonth: Array<String> = ["Week1","Week2","Week3","Week4"]
    // MARK: - Properties
    
    var pullUpControl: SOPullUpControl? {
        didSet {
            pullUpControl?.delegate = self
        }
    }
    
    // MARK: - Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collection.delegate = self
        collection.dataSource = self
        
        /*if let layout = collection?.collectionViewLayout as? UICollectionViewFlowLayout{
         layout.minimumLineSpacing = 10
         //layout.minimumInteritemSpacing = 10
         //layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
         let size = CGSize(width:(collection!.bounds.width-20)/2, height: 250)
         layout.itemSize = size
         self.size = size.width - 30
         }*/
    }
    
    
    
}
// MARK: - SOPullUpViewDelegate

extension AddOptionSelectionViewController: SOPullUpViewDelegate {
    func pullUpViewStatus(_ sender: UIViewController, didChangeTo status: PullUpStatus) {
        switch status {
        case .collapsed:
            UIView.animate(withDuration: 0.9) {
                self.view.alpha = 0.2
            }completion: { isCompleted in
                //Refresh call
                NotificationCenter.default.post(name:Notification.Name(NSNotificationName.refreshDataInCircle.rawValue), object: nil)
            }
            NotificationCenter.default.post(name: Notification.Name(NSNotificationName.pullUpClose.rawValue), object: nil)
            NotificationCenter.default.post(name:Notification.Name(NSNotificationName.showAcuityDetailPopup.rawValue), object: nil)
            
        case .expanded: break
        default:break
        }
        
    }
    
    func pullUpHandleArea(_ sender: UIViewController) -> UIView {
        return handleArea
    }
}

// MARK: - UITableViewDelegate , UITableViewDataSource
extension AddOptionSelectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size:CGFloat = (collection.frame.size.width - space) / 2.0
        print("collection size",size)
        print("self.view.frame",self.view.frame)
        self.size = size - 1
        return CGSize(width: size, height: size/1.15)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return addOptionArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: AddOptionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddOptionCell", for: indexPath as IndexPath) as? AddOptionCell else {
            fatalError("AcuityDetailDisplayCell cell is not found")
        }
        cell.containerViewWidth.constant = self.size
        cell.containerViewHeight.constant = self.size - 15
        cell.containerView.layoutIfNeeded()
        let optionDict  = addOptionArray[indexPath.item]
        cell.displayData(title: optionDict["title"] ?? "",description: optionDict["description"] ?? "")
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? AddOptionCell else {
            return
        }
        Utility.setBackgroundColorWhenViewSelcted(view: cell.contentView)
        let delayInSeconds = 0.15
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) { [self] in
            Utility.setBackgroundColorWhenViewUnSelcted(view: cell.contentView)
            let optionDict = addOptionArray[indexPath.row]
            switch AddOption(rawValue: optionDict["title"] ?? ""){
            case .symptom:
                do{
                    openSymptomsViewController(title:AddOption.symptom.rawValue)
                }
            case .conditions:
                do{
                    openConditionsViewController(title:AddOption.conditions.rawValue)
                }
            case .vitals:
                do{
                    openVitalViewController(title:AddOption.vitals.rawValue)
                }
            case .medications:
                do{
                    openMedicationScreen(title: AddOption.medications.rawValue)
                }
            case .otherHistory:
                do{
                    openOtherHistoriesScreen(title: AddOption.otherHistory.rawValue)
                }
            case .preventionTracker:
                do{
                    openPreventionTrackerScreen(title: AddOption.otherHistory.rawValue)
                }
            case .none:
                print("")
            default:
                break;
            }
        }
    }
}

extension AddOptionSelectionViewController {
    /*
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     return addOptionArray.count
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     guard let cell: AddOptionCell = tableView.dequeueReusableCell(withIdentifier: "AddOptionCell", for: indexPath as IndexPath) as? AddOptionCell else {
     fatalError("AcuityDetailDisplayCell cell is not found")
     }
     cell.displayData(title: addOptionArray[indexPath.row])
     
     
     cell.selectionStyle = .none
     
     return cell
     }
     
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
     return getRowHeightAsPerDeviceSize(height:80)
     }
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
     switch AddOption(rawValue: addOptionArray[indexPath.row]){
     case .symptom:
     do{
     openSymptomsViewController(title:AddOption.symptom.rawValue)
     }
     case .conditions:
     do{
     openConditionsViewController(title:AddOption.conditions.rawValue)
     }
     case .vitals:
     do{
     openVitalViewController(title:AddOption.vitals.rawValue)
     }
     case .medications:
     do{
     openMedicationScreen(title: AddOption.medications.rawValue)
     }
     case .otherHistory:
     do{
     openOtherHistoriesScreen(title: AddOption.otherHistory.rawValue)
     }
     
     case .none:
     print("")
     default:
     break;
     }
     
     }
     */
    //========================================================================================================
    //MARK: Open Symptom Screen
    //========================================================================================================
    func openSymptomsViewController(title:String){
        if symptomsVC != nil{
            self.symptomsVC?.view.removeFromSuperview()
        }
        
        //Add detail value view as child view
        symptomsVC = UIStoryboard(name: Storyboard.add.rawValue, bundle: nil).instantiateViewController(withIdentifier: "SymptomsListViewController") as? SymptomsListViewController
        setupTitleAndBackButtonForAllSubViewController(vc: (symptomsVC)!)
        symptomsVC?.lblTitle.text = title
        self.setupBackButton()
        self.visualEffectView.bringSubviewToFront((self.handleArea)!)
        symptomsVC?.setHandler(handler: { [weak self] (open) in
            if open ?? false{
//                self?.setupBackButton()
//                self?.visualEffectView.bringSubviewToFront((self?.handleArea)!)
            }else{
                self?.symptomsVC?.view.removeFromSuperview()
                self?.symptomsVC?.removeFromParent()
            }
        })
    }
    
    //========================================================================================================
    //MARK: Open Vital Screen
    //========================================================================================================
    func openVitalViewController(title:String){
        
        //Add detail value view as child view
        vitalsVC = UIStoryboard(name: Storyboard.add.rawValue, bundle: nil).instantiateViewController(withIdentifier: "VitalsListViewController") as? VitalsListViewController
        guard (vitalsVC != nil) else {
            return
        }
        setupTitleAndBackButtonForAllSubViewController(vc: (vitalsVC)!)
        vitalsVC?.lblTitle.text = title
        self.setupBackButton()
        self.visualEffectView.bringSubviewToFront((self.handleArea)!)
        vitalsVC?.setHandler(handler: { [weak self] (open) in
            if open ?? false{
//                self.setupBackButton()
//                self.visualEffectView.bringSubviewToFront((self?.handleArea)!)
            }else{
                self?.vitalsVC?.view.removeFromSuperview()
                self?.vitalsVC?.removeFromParent()
            }
        })
    }
    
    //========================================================================================================
    //MARK: Open Condition Screen
    //========================================================================================================
    func openConditionsViewController(title:String){
        
        //Add detail value view as child view
        conditionsVC = UIStoryboard(name: Storyboard.add.rawValue, bundle: nil).instantiateViewController(withIdentifier: "ConditionsListViewController") as? ConditionsListViewController
        guard (conditionsVC != nil) else {
            return
        }
        setupTitleAndBackButtonForAllSubViewController(vc: conditionsVC!)
        conditionsVC?.lblTitle.text = title
        self.setupBackButton()
        self.visualEffectView.bringSubviewToFront((self.handleArea)!)
    }
    //========================================================================================================
    //MARK: Open Medication Screen
    //========================================================================================================
    func openMedicationScreen(title:String){
        
        //Add detail value view as child view
        medicationsVC = UIStoryboard(name: Storyboard.add.rawValue, bundle: nil).instantiateViewController(withIdentifier: "AddMedicationsViewController") as? AddMedicationsViewController
        guard (medicationsVC != nil) else {
            return
        }
        
        setupTitleAndBackButtonForAllSubViewController(vc: medicationsVC!)
        medicationsVC?.lblTitle.text = title
        self.setupBackButton()
        self.visualEffectView.bringSubviewToFront((self.handleArea)!)
    }
    //========================================================================================================
    //MARK: Open Other Histories Screen
    //========================================================================================================
    func openOtherHistoriesScreen(title:String){
        
        //Add detail value view as child view
        historiesVC = UIStoryboard(name: Storyboard.add.rawValue, bundle: nil).instantiateViewController(withIdentifier: "HistoryTitleListViewController") as? HistoryTitleListViewController
        guard (historiesVC != nil) else {
            return
        }
        setupTitleAndBackButtonForAllSubViewController(vc: historiesVC!)
        historiesVC?.lblTitle.text = title
        self.setupBackButton()
        self.visualEffectView.bringSubviewToFront((self.handleArea)!)
        historiesVC?.setHandler(handler: { [weak self] (open) in
            if open ?? false{
//                self?.setupBackButton()
//                self?.visualEffectView.bringSubviewToFront((self?.handleArea)!)
            }else{
                self?.historiesVC?.view.removeFromSuperview()
                self?.historiesVC?.removeFromParent()
            }
        })
        
    }
    //========================================================================================================
    //MARK: Open Prevention Tracker Screen
    //========================================================================================================
    func openPreventionTrackerScreen(title:String){
        
        //Add detail value view as child view
        preventionVC = UIStoryboard(name: Storyboard.add.rawValue, bundle: nil).instantiateViewController(withIdentifier: "AddPreventionFromListViewController") as? AddPreventionFromListViewController
        guard (preventionVC != nil) else {
            return
        }
        setupTitleAndBackButtonForAllSubViewController(vc: preventionVC!)
        self.setupBackButton()
        self.visualEffectView.bringSubviewToFront((self.handleArea)!)
        //preventionVC?.lblTitle.text = title
    }
    //========================================================================================================
    //MARK: Setup Title And BackButton For All SubViewController
    //========================================================================================================
    func setupTitleAndBackButtonForAllSubViewController(vc:UIViewController){
        self.addChild(vc)
        
        //Hide main view of Detail Pullup class
        mainView.isHidden = true
        let originY:CGFloat = 15
        vc.view.frame = CGRect(x: 0, y: originY, width: visualEffectView.frame.size.width, height: visualEffectView.frame.size.height-originY)
        vc.view.removeFromSuperview()
        //Show animation when view added.....
        if isAnimationEnabledForSubView{
            animationForDetailViewWhenAdded(subviewToAdd: (vc.view)!, in: self.visualEffectView)
        }else{
            self.visualEffectView.addSubview((vc.view)!)
        }
        vc.didMove(toParent: self)
        
        //Add close button target
        setUpCloseButton()
        
        visualEffectView.bringSubviewToFront(handleArea)
        
    }
    
    func setupBackButton(){
        handleArea.btnBack!.isHidden = false
        handleArea.btnBack!.addTarget(self, action: #selector(btnBackClickedInAddOptionVC), for: UIControl.Event.touchUpInside)
    }
    
    func setUpCloseButton(){
        handleArea.btnClose!.isHidden = false
        handleArea.btnClose!.addTarget(self, action: #selector(btnCloseClickedInAddOptionVC), for: UIControl.Event.touchUpInside)
        
    }
    //========================================================================================================
    //MARK: Btn Close Clicked
    //========================================================================================================
    @objc func btnCloseClickedInAddOptionVC(){
        
        if symptomsVC != nil{
            removeSymptomsView()
        }
        if vitalsVC != nil{
            removeVitalView()
        }
        if conditionsVC != nil{
            removeConditionView()
        }
        if medicationsVC != nil{
            removeMedicationView()
        }
        if historiesVC != nil{
            removeHistoryView()
        }
        if preventionVC != nil{
            removePreventionView()
        }
    }
    //========================================================================================================
    //MARK: Btn Back Clicked
    //========================================================================================================
    @objc func btnBackClickedInAddOptionVC(){
        
        if symptomsVC != nil{
            if let _:UIView = symptomsVC?.view.viewWithTag(111) {
                self.symptomsVC?.removeAddSymptomsViewController()
                //removeBackButton()
                self.setupBackButton()
            }else{
                removeSymptomsView()
                
            }
        }
        if vitalsVC != nil{
            if let _:UIView = vitalsVC?.view.viewWithTag(111) {
                self.vitalsVC?.removeAddVitalsViewController()
                //removeBackButton()
                self.setupBackButton()
            }else{
                removeVitalView()
            }
        }
        if historiesVC != nil{
            if let _:UIView = historiesVC?.view.viewWithTag(222) {
                self.historiesVC?.removeAddHistoryViewController()
            }
            else if let _:UIView = historiesVC?.view.viewWithTag(111) {
                self.historiesVC?.removeHistoryValueViewController()
                //removeBackButton()
                self.setupBackButton()
            }else{
                removeHistoryView()
            }
        }
        if conditionsVC != nil{
            removeConditionView()
        }
        if medicationsVC != nil{
            removeMedicationView()
        }
        if preventionVC != nil{
            removePreventionView()
        }
    }
    
    func removeVitalView(){
        //Show animation when view is removed.....
        animationForDetailViewWhenRemoved(from: self.visualEffectView)
        ////
        self.vitalsVC?.tblVitals?.removeFromSuperview()
        removeSubView(vc: vitalsVC!)
        self.vitalsVC = nil
        
    }
    func removeSymptomsView(){
        //Show animation when view is removed.....
        animationForDetailViewWhenRemoved(from: self.visualEffectView)
        ////
        self.symptomsVC?.symptomView?.removeFromSuperview()
        removeSubView(vc: symptomsVC!)
        self.symptomsVC = nil
    }
    
    func removeConditionView(){
        removeSubView(vc: conditionsVC!)
        conditionsVC = nil;
    }
    func removeMedicationView(){
        removeSubView(vc: medicationsVC!)
        medicationsVC = nil;
    }
    func removeHistoryView(){
        //Show animation when view is removed.....
        animationForDetailViewWhenRemoved(from: self.visualEffectView)
        ////
        self.historiesVC?.historyView?.removeFromSuperview()
        removeSubView(vc: historiesVC!)
        historiesVC = nil;
    }
    func removePreventionView(){
        removeSubView(vc: preventionVC!)
        preventionVC = nil;
    }
    func removeSubView(vc:UIViewController){
        //Show animation when view is removed.....
        animationForDetailViewWhenRemoved(from: self.visualEffectView)
        ////
        vc.view.removeFromSuperview()
        vc.removeFromParent()
        removeCloseButton()
        removeBackButton()
    }
    
    func removeCloseButton(){
        mainView.isHidden = false
        handleArea.btnClose!.isHidden = true
        
    }
    func removeBackButton(){
        handleArea.btnBack!.isHidden = true
    }
}

