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
    @IBOutlet weak var tblCondition: UITableView!
    @IBOutlet weak var tblSymptom: UITableView!
    @IBOutlet weak var tblVitals: UITableView!
    @IBOutlet weak var tblLab: UITableView!
    
    //Handle view for Swipe up/down
    var handleHeight: CGFloat = 60
    
    //Object of Acuity detial value viewcontroller...
    var detailConditionVC : AcuityMetricsDetailViewController?
    //viewModel object..
    var viewModelObj = AcuityDetailPullUpViewModel()
    
    fileprivate var labelLeadingMarginInitialConstant: CGFloat!
    
    let labelsAsStringForWeek: Array<String> = dayArray
    var labelsAsStringForMonth: Array<String> = ["Week1","Week2","Week3","Week4"]
    var colorForChart: UIColor = UIColor.red
    
    let cellHeight = (40 * Screen.screenHeight)/896
    
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
        
        //change handle height for consistent swipe up...
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            // your code here
            self.setHandleViewHeight()
        }
        
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
        if acuityModel.id != SystemId.Id_MyWellScore {
            //self.topOfMyWellScoreTblConstraint.constant = originalChartHeight;
            showTblMyWellScore(isShow: false)
            self.showScoreAndChartData()
        }else{
            //self.topOfMyWellScoreTblConstraint.constant = 0;
            
            showTblMyWellScore(isShow: true)
            
            self.showScoreAndChartDataForMyWellScore()
        }
        
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
        lblScore.text =  acuityModel.id != SystemId.Id_MyWellScore ? acuityModel.score : ""
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
        self.tblMyWellScoreData.reloadData()
        
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
        //generate array of conditions,lab,vital,symptoms
        self.arrConditions = []
        self.arrSymptoms = []
        self.arrLabs = []
        self.arrVitals = []
        
        let scoreTupple = viewModelObj.prepareArrayFromAcuityModel(systemMetricsData: systemMetricsData)
        self.arrConditions = scoreTupple.0 //arrConditions
        self.arrSymptoms = scoreTupple.1 //arrSymptoms
        self.arrVitals = scoreTupple.2 //arrVitals
        self.arrLabs = scoreTupple.3 //arrLabs
        
        //reload tableview....
        self.reloadTableView()
        
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
        let themeColor = getThemeColor(index:  lblScore.text,isForWheel: false)
        lblScore.textColor = themeColor;
        colorForChart = themeColor ?? UIColor.red
    }
    
    //========================================================================================================
    //MARK: Set Background view to Nil when there is no data in tableview..
    //========================================================================================================
    func reloadTableView(){
        tblCondition.backgroundView = nil
        tblLab.backgroundView = nil
        tblSymptom.backgroundView = nil
        tblVitals.backgroundView = nil
        
        if arrConditions.count <= 0 {
            viewModelObj.setNoDataInfoIfRecordsNotExists(tblView: tblCondition)
        }
        if arrLabs.count <= 0 {
            viewModelObj.setNoDataInfoIfRecordsNotExists(tblView: tblLab)
        }
        if arrSymptoms.count <= 0 {
            viewModelObj.setNoDataInfoIfRecordsNotExists(tblView: tblSymptom)
        }
        if arrVitals.count <= 0 {
            viewModelObj.setNoDataInfoIfRecordsNotExists(tblView: tblVitals)
        }
        reloadTables()
    }
    
    func reloadTables(){
        
        self.tblLab.reloadData()
        self.tblCondition.reloadData()
        self.tblSymptom.reloadData()
        self.tblVitals.reloadData()
        
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
                NotificationCenter.default.post(name: Notification.Name("pullUpClose"), object: nil)
            }
        case .expanded:
            do{
                NotificationCenter.default.post(name: Notification.Name("pullUpOpen"), object: nil)
            }
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
        return getRowHeightAsPerDeviceSize(height:40)
    }
    
    //========================================================================================================
    //MARK: open value detail screen on click of Metrixs
    //========================================================================================================
    
    func openValueDetailScreen(metrixType:MetricsType){
        
        //Add detail value view as child view
        detailConditionVC = UIStoryboard(name: Storyboard.acuityDetailPullUp.rawValue, bundle: nil).instantiateViewController(withIdentifier: "AcuityMetricsDetailViewController") as? AcuityMetricsDetailViewController
        
        
        switch metrixType {
        case .Conditions:
            detailConditionVC?.arrConditions = self.arrConditions
            viewModelObj.setBackgroundColorWhenViewSelcted(view: viewCondition)
        case .Vitals:
            detailConditionVC?.arrVitals = self.arrVitals
            viewModelObj.setBackgroundColorWhenViewSelcted(view: viewVitals)
        case .Sympotms:
            detailConditionVC?.arrSymptoms = self.arrSymptoms
            viewModelObj.setBackgroundColorWhenViewSelcted(view: viewSymptom)
        case .LabData:
            detailConditionVC?.arrLabs = self.arrLabs
            viewModelObj.setBackgroundColorWhenViewSelcted(view: viewLab)
            
        }
        
        let delayInSeconds = 0.15
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) { [self] in
            
            self.addChild(detailConditionVC!)
            
            //Make setBackgroundColorWhenViewUnSelcted
            viewModelObj.setBackgroundColorWhenViewUnSelcted(viewSymptom: viewSymptom, viewCondition: viewCondition, viewVital: viewVitals, viewLab: viewLab)
            
            detailConditionVC?.view.frame.size = CGSize(width: visualEffectView.frame.size.width, height: visualEffectView.frame.size.height)
            
            
            self.detailConditionVC?.didMove(toParent: self)
            
            //Show animation when view added.....
            animationForDetailViewWhenAdded(subviewToAdd: (detailConditionVC?.view)!, in: self.visualEffectView)
            
            //when detail screen open make handle height small......
            handleHeightConstraint.constant = handleHeight;
            
            
            //PAss metrix Item to display data...
            detailConditionVC?.metrixType = metrixType
            setUpCloseButton()
            
            //Hide main view of Detail Pullup class
            mainView.isHidden = true
            detailConditionVC?.setHandler(handler: { [weak self] (open) in
                if open ?? false{
                    self?.visualEffectView.bringSubviewToFront((self?.handleArea)!)
                    self?.setupBackButton()
                }else{
                    //Remove Detail View
                    removeDetailViewFromParent()
                }
            })
            visualEffectView.bringSubviewToFront(handleArea)
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
        if detailConditionVC != nil{
            
            handleArea.btnClose?.isHidden = true
            handleArea.btnBack?.isHidden = true
            mainView.isHidden = false
            //Remove Detail View
            removeDetailViewFromParent()
            //set handle view height to pull up consistently...
            setHandleViewHeight()
        }
    }
    
    func removeDetailViewFromParent(){
        animationForDetailViewWhenRemoved(from: self.visualEffectView)
        detailConditionVC?.view.removeFromSuperview()
        detailConditionVC?.removeFromParent()
    }
    //MARK: Btn Back click
    @objc func btnBackClickedInAcuityValueViewController(){
        if detailConditionVC != nil{
            if let _:UIView = detailConditionVC?.view.viewWithTag(111) {
                handleArea.btnBack?.isHidden = true
                self.detailConditionVC?.removeDetailValueViewController()
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
