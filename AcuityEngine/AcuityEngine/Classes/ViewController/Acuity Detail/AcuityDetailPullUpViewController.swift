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
class AcuityDetailPullUpViewController: UIViewController {
    
    // MARK: - Outlet
    
    @IBOutlet weak var chart: Chart!
    @IBOutlet weak var chartView: UIView!
    @IBOutlet weak var labelInChartForSelectedValue: UILabel!
    @IBOutlet weak var labelLeadingMarginConstraint: NSLayoutConstraint!
    @IBOutlet weak var handleHeightConstraint: NSLayoutConstraint!
    
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
    var systemMetricsData:[String:Any]?
    var arrConditions:[ConditionsModel] = []
    var arrSymptoms:[SymptomsModel] = []
    var arrLabs:[LabModel] = []
    var arrVitals:[VitalsModel] = []
    
    // MARK: - Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //handleArea.backgroundColor = UIColor.red
        //set initial margin for label...
        labelLeadingMarginInitialConstant = labelLeadingMarginConstraint.constant
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
    
    func setFontForLabel(){
        lblTitle.font = Fonts.kAcuityDetailTitleFont
        lblScore.font = Fonts.kAcuityDetailValueFont
    }
    
    func setupSegmentControl(){
        viewModelObj.setUpSegmentControl(segmentControl: segmentControl)
    }
    
    //MARK:
    func showButtonLooksForAllMetrics(){
        self.setBackgroundColorForMetricsView(view: viewCondition)
        self.setBackgroundColorForMetricsView(view: viewVitals)
        self.setBackgroundColorForMetricsView(view: viewSymptom)
        self.setBackgroundColorForMetricsView(view: viewLab)
    }
    //MARK: show system data in tableview
    func showSystemData(){
        guard let systemData = systemData else {
            return
        }
        
        let acuityModel = viewModelObj.prepareAcuityModelFromSystemData(systemData: systemData)
        //Display data from acuityModel
        displayDatailTitleFromAcuityModel(acuityModel: acuityModel)
        
        self.showScoreAndChartData()
        
        self.reloadTableView()
        
    }
    func displayDatailTitleFromAcuityModel(acuityModel:AcuityDisplayModel){
        systemMetricsData = acuityModel.metricDictionary
        lblTitle.text = acuityModel.name?.rawValue
        lblScore.text = acuityModel.score
        MyWellScore.sharedManager.selectedSystem = acuityModel.name ?? SystemName.Cardiovascular
        
    }
    //MARK: prepare array from AcuityModel
    func prepareArrayFromAcuityModel(){
        //generate array of conditions,lab,vital,symptoms
        self.arrConditions = []
        self.arrSymptoms = []
        self.arrLabs = []
        self.arrVitals = []
        guard let arrConditions = systemMetricsData?[MetricsType.Conditions.rawValue] as? [ConditionsModel] else {
            return
        }
        guard let arrSymptoms = systemMetricsData?[MetricsType.Sympotms.rawValue] as? [SymptomsModel] else {
            return
        }
        guard let arrLabs = systemMetricsData?[MetricsType.LabData.rawValue] as? [LabModel] else {
            return
        }
        guard let arrVitals = systemMetricsData?[MetricsType.Vitals.rawValue] as? [VitalsModel] else {
            return
        }
        self.arrConditions = arrConditions
        self.arrSymptoms = arrSymptoms
        self.arrLabs = arrLabs
        self.arrVitals = arrVitals
        
        //Sorting of array...
        self.arrConditions.sort {
            $0.title ?? "" < $1.title ?? ""
        }
        self.arrVitals.sort {
            $0.title ?? "" < $1.title ?? ""
        }
        self.arrSymptoms.sort {
            $0.title ?? "" < $1.title ?? ""
        }
        self.arrLabs.sort {
            $0.title ?? "" < $1.title ?? ""
        }
        
        //reload tableview....
        self.reloadTableView()
        
    }
    //MARK: setup chart
    func setUpChartView(data:[(x: Int, y: Double)]){
        chart.removeAllSeries()
        /*
         Uncomment below line if you want to start Touch in chart..
         */
        //chart.delegate = self
        // Simple chart
        //let labelsAsString: Array<String> = labelsAsStringForWeek
        
        let series = ChartSeries(data: data)
        series.area = true
        series.color = colorForChart
        
        chart.showXLabelsAndGrid = false
        chart.showYLabelsAndGrid = false
        chart.minX = 0
        chart.minY = 0
        chart.maxY = 100
        chart.add(series)
    }
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
        for item in arraySystemScore{
            data.append((x:i,y:item))
            i = i + 1
        }
        switch MyWellScore.sharedManager.daysToCalculateSystemScore {
        case .SevenDays:
            do{
                segmentControl.selectedSegmentIndex = 0
                self.chart.xLabels = [0,1,2,3,4,5,6]
                //self.segmentClicked(segmentControl)
            }
        case .ThirtyDays:
            do{
                segmentControl.selectedSegmentIndex = 1
                self.chart.xLabels = [0,1,2,3]
                //self.segmentClicked(segmentControl)
            }
        case .ThreeMonths:
            do{
                segmentControl.selectedSegmentIndex = 2
                chart.xLabels = [0,1,2]
                //self.segmentClicked(segmentControl)
            }
        case .OneDay:
            break
        }
        
        //Prepare Array from acuityModel
        prepareArrayFromAcuityModel()
        
        lblScore.text = scoreText
        
        setColorForScoreAndChart()
        
        self.setUpChartView(data: data)
    }
    //MARK: Set Color For Score And Chart
    func setColorForScoreAndChart(){
        
        //change background color with system selection..
        let themeColor = getThemeColor(index:  lblScore.text,isForWheel: false)
        lblScore.textColor = themeColor;
        colorForChart = themeColor ?? UIColor.red
    }
    
    //MARK: reloadTableView
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
    
    
    //MARK: segment click
    
    @IBAction func segmentClicked(_ sender: UISegmentedControl) {
        labelLeadingMarginConstraint.constant = labelLeadingMarginInitialConstant
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
    //MARK: View click
    
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


// MARK: - SOPullUpViewDelegate

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

// MARK: - UITableViewDelegate , UITableViewDataSource

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
        return  0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: AcuityDetailValueDisplayCell = tableView.dequeueReusableCell(withIdentifier: "AcuityDetailValueDisplayCell", for: indexPath as IndexPath) as? AcuityDetailValueDisplayCell else {
            fatalError("AcuityDetailDisplayCell cell is not found")
        }
        if tableView == tblCondition {
            if arrConditions.count > indexPath.row{
                let metrixItem = arrConditions[indexPath.row]
                cell.displayConditionData(item: metrixItem)
            }
        } else if  tableView == tblSymptom {
            if arrSymptoms.count > indexPath.row{
                let metrixItem = arrSymptoms[indexPath.row]
                cell.displaySymptomsData(item: metrixItem)
            }
        } else if  tableView == tblVitals {
            if arrVitals.count > indexPath.row{
                let metrixItem = arrVitals[indexPath.row]
                cell.displayVitals(item: metrixItem)
            }
        } else if  tableView == tblLab {
            if arrLabs.count > indexPath.row{
                let metrixItem = arrLabs[indexPath.row]
                cell.displayLabsData(item: metrixItem)
            }
        }
        cell.setFontForLabel(font: Fonts.kAcuityDetailCellFont)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    
    //MARK: open value detail screen on click of Metrixs
    func openValueDetailScreen(metrixType:MetricsType){
        
        //Add detail value view as child view
        detailConditionVC = UIStoryboard(name: Storyboard.acuityDetailPullUp.rawValue, bundle: nil).instantiateViewController(withIdentifier: "AcuityMetricsDetailViewController") as? AcuityMetricsDetailViewController
        
        
        switch metrixType {
        case .Conditions:
            detailConditionVC?.arrConditions = self.arrConditions
            self.setBackgroundColorWhenViewSelcted(view: viewCondition)
        case .Vitals:
            detailConditionVC?.arrVitals = self.arrVitals
            self.setBackgroundColorWhenViewSelcted(view: viewVitals)
        case .Sympotms:
            detailConditionVC?.arrSymptoms = self.arrSymptoms
            self.setBackgroundColorWhenViewSelcted(view: viewSymptom)
        case .LabData:
            detailConditionVC?.arrLabs = self.arrLabs
            self.setBackgroundColorWhenViewSelcted(view: viewLab)
            
        }
        
        let delayInSeconds = 0.15
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) { [self] in
            
            self.addChild(detailConditionVC!)
            
            //Make setBackgroundColorWhenViewUnSelcted
            self.setBackgroundColorWhenViewUnSelcted()
            
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
    
    func setupBackButton(){
        handleArea.btnBack!.isHidden = false
        handleArea.btnBack!.addTarget(self, action: #selector(btnBackClickedInAcuityValueViewController), for: UIControl.Event.touchUpInside)
    }
    
    func setUpCloseButton(){
        handleArea.btnClose!.isHidden = false
        handleArea.btnClose!.addTarget(self, action: #selector(btnCloseClickedInAcuityValueViewController), for: UIControl.Event.touchUpInside)
        
    }
    //set handle view height to pull up consistently...
    func setHandleViewHeight(){
        //make handle height to chart view's max y....
        handleHeightConstraint.constant = segmentControl.frame.origin.y;
        
    }

    //MARK: Set background view of Conditions,lab,symptoms and vital
    func setBackgroundColorForMetricsView(view:UIView){
        view.layer.cornerRadius = 5;
        view.backgroundColor = UIColor.white.withAlphaComponent(0.2)
    }
    
    //MARK: Make view of Conditions,lab,symptoms and vital selected
    func setBackgroundColorWhenViewSelcted(view:UIView){
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 1;
    }
    
    //MARK: Make view of Conditions,lab,symptoms and vital unselected
    func setBackgroundColorWhenViewUnSelcted(){
        viewLab.layer.borderWidth = 0;
        viewVitals.layer.borderWidth = 0;
        viewSymptom.layer.borderWidth = 0;
        viewCondition.layer.borderWidth = 0;
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
extension AcuityDetailPullUpViewController: ChartDelegate {
    
    // Chart delegate
    
    func didTouchChart(_ chart: Chart, indexes: Array<Int?>, x: Double, left: CGFloat) {
        
        if let value = chart.valueForSeries(0, atIndex: indexes[0]) {
            
            let numberFormatter = NumberFormatter()
            numberFormatter.minimumFractionDigits = 2
            numberFormatter.maximumFractionDigits = 2
            labelInChartForSelectedValue.text = numberFormatter.string(from: NSNumber(value: value))
            
            // Align the label to the touch left position, centered
            var constant = labelLeadingMarginInitialConstant + left - (labelInChartForSelectedValue.frame.width / 2)
            
            // Avoid placing the label on the left of the chart
            if constant < labelLeadingMarginInitialConstant {
                constant = labelLeadingMarginInitialConstant
            }
            
            // Avoid placing the label on the right of the chart
            let rightMargin = chart.frame.width - labelInChartForSelectedValue.frame.width
            if constant > rightMargin {
                constant = rightMargin
            }
            
            labelLeadingMarginConstraint.constant = constant
            
        }
        
    }
    
    func didFinishTouchingChart(_ chart: Chart) {
        
        labelInChartForSelectedValue.text = ""
        labelLeadingMarginConstraint.constant = labelLeadingMarginInitialConstant
    }
    
    func didEndTouchingChart(_ chart: Chart) {
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        super.viewWillTransition(to: size, with: coordinator)
        
        // Redraw chart on rotation
        chart.setNeedsDisplay()
        
    }
}

