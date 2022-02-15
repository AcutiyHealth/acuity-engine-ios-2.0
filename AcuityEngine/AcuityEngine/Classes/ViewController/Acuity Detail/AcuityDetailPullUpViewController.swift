//
//  AcuityDetailPullUpViewController.swift
//  SOPullUpView_Example
//
//  Created by Ahmad Sofi on 12/8/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import SOPullUpView
import SwiftChart
import Charts

class AcuityDetailPullUpViewController: UIViewController {
    
    // MARK: - Outlet
    
    @IBOutlet weak var chart: Chart!
    @IBOutlet weak var chartView: UIView!
    
    @IBOutlet weak var handleHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var topOfMyWellScoreTblConstraint: NSLayoutConstraint!
    @IBOutlet weak var viewOfMetricsBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblNoDataAvailable: UILabel!
    @IBOutlet weak var lblScore: UILabel!
    @IBOutlet weak var handleArea: HandleView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var visualEffectView: UIView!
    @IBOutlet weak var visualEffectMainView: UIVisualEffectView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    //4 tile UIView...
    @IBOutlet weak var viewCondition: UIView!
    @IBOutlet weak var viewSymptom: UIView!
    @IBOutlet weak var viewVitals: UIView!
    @IBOutlet weak var viewLab: UIView!
    @IBOutlet weak var viewOfMetrics: UIView!
    @IBOutlet weak var lblCondition: UILabel!
    @IBOutlet weak var lblSymptom: UILabel!
    @IBOutlet weak var lblVitals: UILabel!
    @IBOutlet weak var lblLab: UILabel!
    
    //4 tile tableview...
    //4 tile tableview...
    @IBOutlet weak var tblCondition: UITableView!
    @IBOutlet weak var tblSymptom: UITableView!
    @IBOutlet weak var tblVitals: UITableView!
    @IBOutlet weak var tblLab: UITableView!
    
    //Handle view for Swipe up/down
    var handleHeight: CGFloat = 60
    var isAnimationEnabledForSubView:Bool = true
    //Object of Acuity detial value viewcontroller...
    var metrixDetailVC : AcuityMetricsDetailViewController?
    //viewModel object..
    var viewModelObj = AcuityDetailPullUpViewModel()
    var previousPullupState:PullUpStatus = .collapsed
    fileprivate var labelLeadingMarginInitialConstant: CGFloat!
    
    let labelsAsStringForWeek: Array<String> = dayArray
    var labelsAsStringForMonth: Array<String> = ["Week1","Week2","Week3","Week4"]
    var colorForChart: UIColor = UIColor.red
    
    let cellHeight = (17.2 * Screen.screenHeight)/568//(28 * Screen.screenHeight)/896
    
    // MARK: - Properties
    
    var pullUpControl: SOPullUpControl? {
        didSet {
            pullUpControl?.delegate = self
        }
    }
    var systemData:[String:Any]?{
        didSet{
            self.showSystemData()
        }
    }
    
    lazy var lineChartView: AcuityGraph = {
        let chartView = AcuityGraph()
        chartView.initialize()
        chartView.delegate = self
        chartView.frame = CGRect(x: 0, y: 0, width: self.chartView.frame.size.width, height: self.chartView.frame.size.height)
        
        //chartView.backgroundColor = UIColor.gray
        return chartView
    }()
    var systemMetricsData:[String:Any]?
    var arrConditions:[ConditionsModel] = []
    var arrSymptoms:[SymptomsModel] = []
    var arrLabs:[LabModel] = []
    var arrVitals:[VitalsModel] = []
    
    //=================== My Well Score Data =====================//
    var systemMyWellScoreData:[[String:Any]]?
    
    @IBOutlet var tblMyWellScoreData:UITableView!
    
    //===================//===================//===================//
    
    // MARK: - Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setFontForLabel()
        setupSegmentControl()
        showButtonLooksForAllMetrics()
        if UIDevice.current.hasNotch{
            let bottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
            //viewOfMetricsBottomConstraint.constant = bottom + 5;
        }
        
        //change handle height for consistent swipe up...
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            // your code here
            self.setHandleViewHeight()
        }
        //handleAreaUserInteractionOff()
        
        print("viewDidLoad AcuityDetailPullUpViewController")
    }
    //========================================================================================================
    //MARK: Set Font For Score and System Name..
    //========================================================================================================
    
    func setFontForLabel(){
        //Set Font For Title and Score..
        lblTitle.font = Fonts.kAcuityDetailTitleFont
        lblScore.font = Fonts.kAcuityDetailValueFont
        //Set Font For Title in View Metrics..
        lblVitals.font = Fonts.kAcuityDetailCellTitleFont
        lblCondition.font = Fonts.kAcuityDetailCellTitleFont
        lblSymptom.font = Fonts.kAcuityDetailCellTitleFont
        lblLab.font = Fonts.kAcuityDetailCellTitleFont
    }
    
    //========================================================================================================
    //MARK: Setup Segment Control..
    //========================================================================================================
    func setupSegmentControl(){
        viewModelObj.setUpSegmentControl(segmentControl: segmentControl)
    }
    
    //========================================================================================================
    //MARK: Show Button Looks For All Metrics..
    //========================================================================================================
    func showButtonLooksForAllMetrics(){
        viewModelObj.setBackGroundColorFor(viewSymptom: self.viewSymptom, viewCondition: viewCondition, viewVital: viewVitals, viewLab: viewLab)
    }
    //========================================================================================================
    //MARK: show system data in tableview
    //========================================================================================================
    
    func showSystemData(){
        guard let systemData = systemData else {
            return
        }
        
        let acuityModel = viewModelObj.prepareAcuityModelFromSystemData(systemData: systemData)
        //Display data from acuityModel
        displayDatailTitleFromAcuityModel(acuityModel: acuityModel)
        
        //=============================== When Any System Selected Out of 14 system ======================//
        if acuityModel.id != SystemId.Id_MyWellScore.rawValue {
            //self.topOfMyWellScoreTblConstraint.constant = originalChartHeight;
            viewCondition.isHidden = false
            viewSymptom.isHidden = false
            viewVitals.isHidden = true
            viewLab.isHidden = true
        }else{
            viewCondition.isHidden = true
            viewSymptom.isHidden = true
            viewVitals.isHidden = false
            viewLab.isHidden = false
            
            //self.topOfMyWellScoreTblConstraint.constant = 0;
            
            //showTblMyWellScore(isShow: true)
            
            //self.showScoreAndChartDataForMyWellScore()
        }
        showTblMyWellScore(isShow: false)
        self.showScoreAndChartData()
        self.reloadTableView()
        
    }
    //========================================================================================================
    //MARK: Show/Hide Tableview Of MyWellscore system...
    //========================================================================================================
    func showTblMyWellScore(isShow:Bool){
        self.tblMyWellScoreData.isHidden = !isShow
        self.viewOfMetrics.isHidden = isShow
        self.chartView.isHidden = isShow
        self.segmentControl.isHidden = isShow
    }
    //========================================================================================================
    //MARK: Display Score and System Name...
    //========================================================================================================
    func displayDatailTitleFromAcuityModel(acuityModel:AcuityDisplayModel){
        systemMetricsData = acuityModel.metricDictionary
        lblTitle.text = acuityModel.name?.rawValue
        
        //============== Dont's show score when MyWellScore tab in wheel is selected..=============//
        lblScore.text =  acuityModel.id != SystemId.Id_MyWellScore.rawValue ? acuityModel.score : ""
        MyWellScore.sharedManager.selectedSystem = acuityModel.name ?? SystemName.Cardiovascular
    }
    
    
    //========================================================================================================
    //MARK: MyWellScore Selected in wheel showScoreAndChartDataForMyWellScore..
    //========================================================================================================
    
    func showScoreAndChartDataForMyWellScore(){
        
        let scoreTupple = viewModelObj.getScoreAndArrayOfSystemScoreForMyWellScore()
        systemMyWellScoreData = scoreTupple.2 //metricDictionary
        
        //=========Uncomment below code if want to show chart when MyWell Score selected..=======//
        //Display Chart and Score Data
        //displayScoreAndChartData(scoreText: scoreText, arraySystemScore: arraySystemScore)
        
        //Reload Tableview..
        reloadTableOnMainThread(tblName: self.tblMyWellScoreData)
        
    }
    
    //=============================== When Any System Selected Out of 14 system ======================//
    //========================================================================================================
    //MARK: showScoreAndChartData For 14 system
    //========================================================================================================
    
    func showScoreAndChartData(){
        var scoreText = String(format: "0.00")
        var data = [(x:0, y:0.0)]
        var arraySystemScore:[Double] = []
        print("<--------------------showScoreAndChartData-------------------->")
        /*
         NOTE: getScoreAndArrayOfSystemScore use to calculate system score for 7 days/1 Month/ 3 Month for every selected system.....
         */
        let scoreTupple = viewModelObj.getScoreAndArrayOfSystemScore()
        scoreText = scoreTupple.0 //scoreText
        arraySystemScore = scoreTupple.1 //arraySystemScore
        systemMetricsData = scoreTupple.2 //metricDictionary
        var i = 0;
        data  = [];
        for item in arraySystemScore{
            data.append((x:i,y:item))
            i = i + 1
        }
        switch MyWellScore.sharedManager.daysToCalculateSystemScore {
        case .SevenDays:
            do{
                segmentControl.selectedSegmentIndex = 0
                //self.chart.xLabels = [0,1,2,3,4,5,6]
                //self.segmentClicked(segmentControl)
            }
        case .ThirtyDays:
            do{
                segmentControl.selectedSegmentIndex = 1
                //self.chart.xLabels = [0,1,2,3]
                //self.segmentClicked(segmentControl)
            }
        case .ThreeMonths:
            do{
                segmentControl.selectedSegmentIndex = 2
                //chart.xLabels = [0,1,2]
                //self.segmentClicked(segmentControl) 
            }
        case .OneDay:
            break
        }
        
        //Prepare Array from acuityModel
        prepareArrayFromAcuityModel()
        
        //Display Chart and Score Data
        displayScoreAndChartData(scoreText: scoreText, arraySystemScore: arraySystemScore)
    }
    
    //========================================================================================================
    //MARK: prepare array from AcuityModel For 14 system
    //========================================================================================================
    
    func prepareArrayFromAcuityModel(){
        DispatchQueue.global().async {[weak self] in
            //generate array of conditions,lab,vital,symptoms
            self?.arrConditions = []
            self?.arrSymptoms = []
            self?.arrSymptoms = []
            self?.arrLabs = []
            self?.arrVitals = []
            
            let scoreTupple = self?.viewModelObj.prepareArrayFromAcuityModel(systemMetricsData: self?.systemMetricsData)
            self?.arrConditions = scoreTupple?.0 ?? [] //arrConditions
            //self.arrSymptoms = scoreTupple.1 //arrSymptoms
            self?.arrSymptoms = scoreTupple?.1 ?? [] //arrSymptoms
            self?.arrVitals = scoreTupple?.2  ?? []//arrVitals
            self?.arrLabs = scoreTupple?.3 ?? [] //arrLabs
            
            self?.arrLabs = self?.viewModelObj.combineOtherEntriesFromListOfLabsInArrayForDisplay(arrVital: self?.arrLabs ?? []) ?? []
            //=============Combine Free Condition with Add Section Condition Data.=============//
            //self?.arrConditions = self?.viewModelObj.fetchFreeConditionDataAndCombineWithAddSectionCondition(arrConditions: self?.arrConditions ?? []) ?? []
            //reload tableview....
            self?.reloadTableView()
        }
    }
    
    //========================================================================================================
    //MARK: Display Chart and Score Data
    //========================================================================================================
    func displayScoreAndChartData(scoreText:String,arraySystemScore:[Double]){
        
        lblScore.text = scoreText
        
        setColorForScoreAndChart()
        
        self.setUpChartView(arraySystemScore: arraySystemScore)
    }
    
    //========================================================================================================
    //MARK: Set Color For Score And Chart
    //========================================================================================================
    func setColorForScoreAndChart(){
        
        //change background color with system selection..
        let themeColor = Utility.shared.getThemeColor(index:  lblScore.text,isForWheel: false)
        lblScore.textColor = themeColor;
        colorForChart = themeColor ?? UIColor.red
    }
    
    //========================================================================================================
    //MARK: Set Background view to Nil when there is no data in tableview..
    //========================================================================================================
    func reloadTableView(){
        DispatchQueue.main.async {
            self.tblCondition.backgroundView = nil
            self.tblLab.backgroundView = nil
            self.tblSymptom.backgroundView = nil
            self.tblVitals.backgroundView = nil
            
            if self.arrConditions.count <= 0 {
                Utility.setNoDataInfoIfRecordsNotExists(tblView: self.tblCondition)
            }
            if self.arrLabs.count <= 0 {
                Utility.setNoDataInfoIfRecordsNotExists(tblView: self.tblLab)
            }
            /*if arrSymptoms.count <= 0 {
             viewModelObj.Utility.setNoDataInfoIfRecordsNotExists(tblView: tblSymptom)
             }*/
            if self.arrSymptoms.count <= 0 {
                Utility.setNoDataInfoIfRecordsNotExists(tblView: self.tblSymptom)
            }
            if self.arrVitals.count <= 0 {
                Utility.setNoDataInfoIfRecordsNotExists(tblView: self.tblVitals)
            }
            self.reloadTables()
        }
    }
    
    func reloadTables(){
        
        reloadTableOnMainThread(tblName: tblLab)
        reloadTableOnMainThread(tblName: tblCondition)
        reloadTableOnMainThread(tblName: tblSymptom)
        reloadTableOnMainThread(tblName: tblVitals)
        
    }
    
    func reloadTableOnMainThread(tblName:UITableView){
        DispatchQueue.main.async {
            tblName.reloadData()
        }
    }
    //========================================================================================================
    //MARK: segment click
    //========================================================================================================
    @IBAction func segmentClicked(_ sender: UISegmentedControl) {
        
        let selectedSegment = sender.selectedSegmentIndex
        switch selectedSegment {
        case 0:
            do{
                MyWellScore.sharedManager.daysToCalculateSystemScore = SegmentValueForGraph.SevenDays
                showScoreAndChartData()
                
            }
        case 1:
            do{
                MyWellScore.sharedManager.daysToCalculateSystemScore = SegmentValueForGraph.ThirtyDays
                showScoreAndChartData()
                
            }
        case 2:
            do{
                MyWellScore.sharedManager.daysToCalculateSystemScore = SegmentValueForGraph.ThreeMonths
                showScoreAndChartData()
            }
            
        default:
            break
        }
        //NotificationCenter.default.post(name: Notification.Name("refreshCircleView"), object: nil)
        
    }
    //========================================================================================================
    //MARK: View Metrics click
    //========================================================================================================
    @IBAction func viewConditionClicked(_ sender: Any) {
        if arrConditions.count>0{
            openValueDetailScreen(metrixType: .Conditions)
        }
    }
    
    @IBAction func viewSymptomsClicked(_ sender: Any) {
        if arrSymptoms.count>0{
            openValueDetailScreen(metrixType: .Sympotms)
        }
    }
    @IBAction func viewMedicationClicked(_ sender: Any) {
        if arrSymptoms.count>0{
            openValueDetailScreen(metrixType: .Medication)
        }
    }
    @IBAction func viewVitalsClicked(_ sender: Any) {
        if arrVitals.count>0{
            openValueDetailScreen(metrixType: .Vitals)
        }
    }
    
    @IBAction func viewLabsClicked(_ sender: Any) {
        if arrLabs.count>0{
            openValueDetailScreen(metrixType: .LabData)
        }
    }
}

//========================================================================================================
//MARK: SOPullUpViewDelegate
//========================================================================================================
extension AcuityDetailPullUpViewController: SOPullUpViewDelegate {
    
    func pullUpViewStatus(_ sender: UIViewController, didChangeTo status: PullUpStatus) {
        
        switch status {
        case .collapsed:
            do{
                //DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                // your code here
                
                self.removeDetailScreenAtCollapseWithAnimation()
                /*
                 We are storing previousPullupState because when pullup half open and tap handle, it will collapse. So every time pullUpClose was fire and animation of mainscoreview happen..
                 To avaoid this, we check if previousPullupState not half opened state, then fire pullUpClose otherwise not...
                 */
                if previousPullupState != .halfOpened{
                    previousPullupState = .collapsed
                    NotificationCenter.default.post(name: Notification.Name(NSNotificationName.pullUpClose.rawValue), object: nil)
                }
                //When collapse - make wheel interactive...
                //NotificationCenter.default.post(name: Notification.Name(NSNotificationName.makeWheeInteractiveAtpullUpClose.rawValue), object: nil)
            }
        case .halfOpened:
            do{
                //handleAreaUserInteractionOff()
                
                if previousPullupState != .collapsed{
                    previousPullupState = .halfOpened
                    NotificationCenter.default.post(name: Notification.Name(NSNotificationName.pullUpHalfOpened.rawValue), object: nil)
                }
            }
        case .expanded:
            do{
                previousPullupState = .expanded
                NotificationCenter.default.post(name: Notification.Name("pullUpOpen"), object: nil)
            }
        default:break
        }
        
    }
    
    func pullUpHandleArea(_ sender: UIViewController) -> UIView {
        return handleArea
    }
}
//========================================================================================================
//MARK: UITableViewDelegate,UITableViewDataSource
//========================================================================================================
extension AcuityDetailPullUpViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == tblCondition && arrConditions.count>0 {
            let count = Int(tblCondition.frame.height/cellHeight)
            return arrConditions.count  >= count ? count : arrConditions.count
        } else if  tableView == tblSymptom && arrSymptoms.count>0{
            let count = Int(tblSymptom.frame.height/cellHeight)
            return arrSymptoms.count >= count ? count : arrSymptoms.count
        } else if  tableView == tblVitals  && arrVitals.count>0{
            let count = Int(tblVitals.frame.height/cellHeight)
            return arrVitals.count  >= count ? count : arrVitals.count
        } else if  tableView == tblLab  && arrLabs.count>0{
            let count = Int(tblLab.frame.height/cellHeight)
            return arrLabs.count  >= count ? count : arrLabs.count
        }
        else if  tableView == tblMyWellScoreData{
            return systemMyWellScoreData?.count ?? 0
        }
        return  0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: AcuityPullUpMetricsDisplayCell = tableView.dequeueReusableCell(withIdentifier: "AcuityPullUpMetricsDisplayCell", for: indexPath as IndexPath) as? AcuityPullUpMetricsDisplayCell else {
            fatalError("AcuityDetailDisplayCell cell is not found")
        }
        if tableView == tblCondition {
            if arrConditions.count > indexPath.row{
                let metrixItem = arrConditions[indexPath.row]
                cell.displayConditionData(item: metrixItem)
                //cell.setFontForLabel(font: UIFont.SFProDisplayMedium(of: 12))
            }
        } else if  tableView == tblSymptom {
            if arrSymptoms.count > indexPath.row{
                let metrixItem = arrSymptoms[indexPath.row]
                cell.displaySymptomsData(item: metrixItem)
                //cell.setFontForLabel(font: UIFont.SFProDisplayMedium(of: 12))
            }
            
        } else if  tableView == tblVitals {
            if arrVitals.count > indexPath.row{
                let metrixItem = arrVitals[indexPath.row]
                //print("metrixItem.isBPModel",metrixItem.isBPModel)
                cell.displayVitals(item: metrixItem)
                //cell.setFontForLabel(font: UIFont.SFProDisplayMedium(of: 12))
            }
        } else if  tableView == tblLab {
            if arrLabs.count > indexPath.row{
                let metrixItem = arrLabs[indexPath.row]
                cell.displayLabsData(item: metrixItem)
                //cell.setFontForLabel(font: UIFont.SFProDisplayMedium(of: 12))
                
            }
        }
        else if  tableView == tblMyWellScoreData {
            guard let dictionarySystemScore = systemMyWellScoreData?[indexPath.row] else { return cell }
            cell.displaySystemScore(item: dictionarySystemScore)
        }
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView != tblMyWellScoreData{
            return cellHeight
        }
        //return getRowHeightAsPerDeviceSize(height:40)
        return UITableView.automaticDimension
    }
    
    //========================================================================================================
    //MARK: open value detail screen on click of Metrixs
    //========================================================================================================
    
    func openValueDetailScreen(metrixType:MetricsType){
        
        //Add detail value view as child view
        metrixDetailVC = UIStoryboard(name: Storyboard.acuityDetailPullUp.rawValue, bundle: nil).instantiateViewController(withIdentifier: "AcuityMetricsDetailViewController") as? AcuityMetricsDetailViewController
        
        
        switch metrixType {
        case .Conditions:
            metrixDetailVC?.arrConditions = self.arrConditions
            Utility.setBackgroundColorWhenViewSelcted(view: viewCondition)
        case .Vitals:
            metrixDetailVC?.arrVitals = self.arrVitals
            Utility.setBackgroundColorWhenViewSelcted(view: viewVitals)
        case .Sympotms:
            metrixDetailVC?.arrSymptoms = self.arrSymptoms
            Utility.setBackgroundColorWhenViewSelcted(view: viewSymptom)
        case .LabData:
            metrixDetailVC?.arrLabs = self.arrLabs
            Utility.setBackgroundColorWhenViewSelcted(view: viewLab)
        case .Medication:
            metrixDetailVC?.arrMedications = AppDelegate.shared.arrMedications
            //viewModelObj.setBackgroundColorWhenViewSelcted(view: viewM)
        default:
            break;
        }
        
        let delayInSeconds = 0.15
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) { [self] in
            
            self.addChild(metrixDetailVC!)
            
            //Make setBackgroundColorWhenViewUnSelcted
            Utility.setBackgroundColorWhenViewUnSelcted(viewSymptom: viewSymptom, viewCondition: viewCondition, viewVital: viewVitals, viewLab: viewLab)
            
            metrixDetailVC?.view.frame.size = CGSize(width: visualEffectView.frame.size.width, height: visualEffectView.frame.size.height)
            
            
            self.metrixDetailVC?.didMove(toParent: self)
            
            //Show animation when view added.....
            //            if isAnimationEnabledForSubView{
            //                animationForDetailViewWhenAdded(subviewToAdd: (metrixDetailVC?.view)!, in: self.visualEffectView)
            //            }else{
            self.visualEffectView.addSubview((metrixDetailVC?.view)!)
            //            }
            
            //when detail screen open make handle height small......
            handleHeightConstraint.constant = handleHeight;
            
            
            //PAss metrix Item to display data...
            metrixDetailVC?.metrixType = metrixType
            setUpCloseButton()
            setupBackButton()
            self.visualEffectView.bringSubviewToFront((self.handleArea)!)
            //Hide main view of Detail Pullup class
            mainView.isHidden = true
            metrixDetailVC?.setHandler(handler: { [weak self] (open) in
                if open ?? false{
                    //                    self?.visualEffectView.bringSubviewToFront((self?.handleArea)!)
                    //                    self?.setupBackButton()
                }else{
                    //Remove Detail View
                    removeDetailViewFromParent()
                }
            })
            visualEffectView.bringSubviewToFront(handleArea)
            
            if pullUpControl != nil && pullUpControl?.isExpanded == false{
                pullUpControl?.expanded()
            }
        }
        
    }
    //========================================================================================================
    //MARK: Setup Back Button in Sub Detail Screen...
    //========================================================================================================
    func setupBackButton(){
        handleArea.btnBack!.isHidden = false
        handleArea.btnBack!.addTarget(self, action: #selector(btnBackClickedInAcuityValueViewController), for: UIControl.Event.touchUpInside)
    }
    //========================================================================================================
    //MARK: Setup Close Button in Sub Detail screen...
    //========================================================================================================
    func setUpCloseButton(){
        handleArea.btnClose!.isHidden = false
        handleArea.btnClose!.addTarget(self, action: #selector(btnCloseClickedInAcuityValueViewController), for: UIControl.Event.touchUpInside)
        
    }
    //========================================================================================================
    //MARK: Set Handle Height in Pullup
    //========================================================================================================
    func setHandleViewHeight(){
        //make handle height to chart view's max y....
        handleHeightConstraint.constant = segmentControl.frame.origin.y;
        
    }
    
    //MARK: Btn close click
    @objc func btnCloseClickedInAcuityValueViewController(){
        
        if self.pullUpControl != nil && self.pullUpControl?.isExpanded == true{
            self.pullUpControl?.halfOpened()
        }
        //DispatchQueue.main.asyncAfter(deadline: .now() + pullUpAnimationTime/2) {
        self.removeDetailScreenAtCollapseWithAnimation()
        //}
    }
    func removeDetailScreenAtCollapseWithAnimation(){
        if metrixDetailVC != nil{
            
            handleArea.btnClose?.isHidden = true
            handleArea.btnBack?.isHidden = true
            self.mainView.isHidden = false
            //Remove Detail View
            removeDetailViewFromParent()
            //set handle view height to pull up consistently...
            setHandleViewHeight()
            
        }
    }
    
    func removeDetailViewFromParent(){
        //animationForDetailViewWhenRemoved(from: self.visualEffectView)
        
        mainView.alpha = 0.0
        UIView.animate(withDuration: pullUpViewFadeAnimationTimeAtCollapse) {
            self.metrixDetailVC?.view.alpha = 0.2
        } completion: { success in
            self.metrixDetailVC?.view.alpha = 0.0
            
            self.mainView.alpha = 1
            self.metrixDetailVC?.view.removeFromSuperview()
            self.metrixDetailVC?.removeFromParent()
            
        }
        
    }
    
    //MARK: Btn Back click
    @objc func btnBackClickedInAcuityValueViewController(){
        if metrixDetailVC != nil{
            //Here we check if back button is clicked in metrix value view controller?
            //If yes, back button need to be hidden and remove that view from MetrixDetailVC by calling method removeDetailValueViewController()
            //view of metrix value view controller has tag 111 in MetrixDetailVC as subview..
            if let _:UIView = metrixDetailVC?.view.viewWithTag(111) {
                //handleArea.btnBack?.isHidden = true
                self.metrixDetailVC?.removeDetailValueViewController()
            }
            else{
                //If we are in metrixdetail screen, both have back and close button...in both we will half open the pullup..
                //So code for back and close button will be same...
                self.btnCloseClickedInAcuityValueViewController()
            }
        }
    }
}


extension AcuityDetailPullUpViewController:ChartViewDelegate{
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry)
    }
    
}
extension AcuityDetailPullUpViewController{
    func setUpChartView(arraySystemScore:[Double]){
        var i = 0;
        var data = [(x:0, y:0.0)]
        data  = [];
        for item in arraySystemScore{
            data.append((x:i,y:item))
            i = i + 1
        }
        //Add line chart view in Main chart view...
        addLineChartViewInMainChartView()
        //Load data in line chart view
        lineChartView.setData(data: data,colorForChart: colorForChart)
    }
    
    func addLineChartViewInMainChartView(){
        
        lineChartView.removeFromSuperview()
        self.chartView.addSubview(lineChartView)
        lineChartView.translatesAutoresizingMaskIntoConstraints = false
        let leadingConstraint = NSLayoutConstraint(item: lineChartView, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.chartView, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 0)
        let trailingConstraint = NSLayoutConstraint(item: lineChartView, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.chartView, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 0)
        let topConstraint =  NSLayoutConstraint(item: lineChartView, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.chartView, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: lineChartView, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.chartView, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 0)
        chartView.addConstraints([leadingConstraint, trailingConstraint, topConstraint, bottomConstraint])
        
        
    }
}

extension AcuityDetailPullUpViewController: ChartDelegate {
    func didFinishTouchingChart(_ chart: Chart) {
        
    }
    
    
    // Chart delegate
    
    func didTouchChart(_ chart: Chart, indexes: Array<Int?>, x: Double, left: CGFloat) {
        
    }
    
    
    
    func didEndTouchingChart(_ chart: Chart) {
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        super.viewWillTransition(to: size, with: coordinator)
        
        // Redraw chart on rotation
        chart.setNeedsDisplay()
        
    }
}
