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
    @IBOutlet weak var labelInChartForSelectedValue: UILabel!
    @IBOutlet weak var labelLeadingMarginConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var scoreLbl: UILabel!
    @IBOutlet weak var handleArea: HandleView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var visualEffectView: UIView!
    @IBOutlet weak var visualEffectMainView: UIVisualEffectView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    //4 tile tableview...
    @IBOutlet weak var tblCondition: UITableView!
    @IBOutlet weak var tblSymptom: UITableView!
    @IBOutlet weak var tblVitals: UITableView!
    @IBOutlet weak var tblLab: UITableView!
    
    //Close button for Acuity detail value...
    var btnClose:UIButton?
    
    //Object of Acuity detial value viewcontroller...
    var detailConditionVC : AcuityDetailConditionViewController?
    
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
    var Conditions:[ConditionsModel] = []
    var symptoms:[SymptomsModel] = []
    var labs:[LabModel] = []
    var Vitals:[VitalsModel] = []
    
    // MARK: - Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setFontForLabel()
        setupSegmentControl()
        //set initial margin for label...
        labelLeadingMarginInitialConstant = labelLeadingMarginConstraint.constant
        
    }
    
    func setFontForLabel(){
        titleLbl.font = Fonts.kAcuityDetailTitleFont
        scoreLbl.font = Fonts.kAcuityDetailValueFont
    }
    //MARK: show system data in tableview
    func setupSegmentControl(){
        segmentControl.setTitle(SegmentValueForGraph.SevenDays.rawValue, forSegmentAt: 0)
        segmentControl.setTitle(SegmentValueForGraph.ThirtyDays.rawValue, forSegmentAt: 1)
        segmentControl.setTitle(SegmentValueForGraph.ThreeMonths.rawValue, forSegmentAt: 2)
        segmentControl.defaultConfiguration(font: Fonts.kAcuityDetailSegmentFont, color: UIColor.white)
        segmentControl.selectedConfiguration(font: Fonts.kAcuityDetailSegmentFont, color: UIColor.black)
        segmentControl.selectedSegmentIndex = 0
    }
    
    //MARK: show system data in tableview
    func showSystemData(){
        guard let systemData = systemData else {
            return
        }
        systemMetricsData = systemData["metricCardio"] as? [String:Any]
        titleLbl.text = systemData["name"] as? String ?? ""
        scoreLbl.text = systemData["score"]  as? String ?? ""
        let index:String = (systemData["score"] as? String ?? "")
        
        //generate array of Conditions,lab,imp data,symptoms
        
        self.Conditions = systemMetricsData![MetricsType.Conditions.rawValue] as! [ConditionsModel]
        self.symptoms = systemMetricsData![MetricsType.Sympotms.rawValue] as! [SymptomsModel]
        self.labs = systemMetricsData![MetricsType.LabData.rawValue] as! [LabModel]
        self.Vitals = systemMetricsData![MetricsType.Vitals.rawValue] as! [VitalsModel]
        
        //change background color with system selection..
        let themeColor = getThemeColor(index: index,isForWheel: false)
        scoreLbl.textColor = themeColor;
        colorForChart = themeColor ?? UIColor.red
        
        self.reloadTableView()
        self.segmentClicked(segmentControl)
    }
    
    func setUpChartView(data:[(x: Int, y: Double)]){
        chart.removeAllSeries()
        chart.delegate = self
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
    func reloadTableView(){
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
                let data = [
                    (x: 0, y: 90.0),
                    (x: 1, y: 80.5),
                    (x: 2, y: 70),
                    (x: 3, y: 95),
                    (x: 4, y: 85),
                    (x: 5, y: 60),
                    (x: 6, y: 80),
                ]
                self.setUpChartView(data: data)
                chart.xLabels = [0,1,2,3,4,5,6]
                
            }
        case 1:
            do{
                let data = [
                    (x: 0, y: 90),
                    (x: 1, y: 80),
                    (x: 2, y: 70),
                    (x: 3, y: 95.5),
                    
                ]
                self.setUpChartView(data: data)
                chart.xLabels = [0,1,2,3]
            }
        case 2:
            do{
                let data = [
                    (x: 0, y: 80),
                    (x: 1, y: 95.0),
                    (x: 2, y: 60)
                    
                ]
                self.setUpChartView(data: data)
                chart.xLabels = [0,1,2]
            }
            
        default:
            break
        }
    }
    //MARK: View click
    
    @IBAction func viewConditionClicked(_ sender: Any) {
        openValueDetailScreen(metrixType: .Conditions)
    }
    
    @IBAction func viewSymptomsClicked(_ sender: Any) {
        openValueDetailScreen(metrixType: .Sympotms)
    }
    @IBAction func viewVitalsClicked(_ sender: Any) {
        openValueDetailScreen(metrixType: .Vitals)
    }
    
    @IBAction func viewLabsClicked(_ sender: Any) {
        openValueDetailScreen(metrixType: .LabData)
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
        
        if tableView == tblCondition {
            let count = Int(tblCondition.frame.height/cellHeight)
            return Conditions.count  > count ? count : 3
        } else if  tableView == tblSymptom {
            let count = Int(tblSymptom.frame.height/cellHeight)
            return symptoms.count > count ? count : 3
        } else if  tableView == tblVitals {
            let count = Int(tblVitals.frame.height/cellHeight)
            return Vitals.count  > count ? count : 3
        } else if  tableView == tblLab {
            let count = Int(tblLab.frame.height/cellHeight)
            return labs.count  > count ? count : 3
        }
        
        return  0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: AcuityDetailValueDisplayCell = tableView.dequeueReusableCell(withIdentifier: "AcuityDetailValueDisplayCell", for: indexPath as IndexPath) as? AcuityDetailValueDisplayCell else {
            fatalError("AcuityDetailDisplayCell cell is not found")
        }
        if tableView == tblCondition {
            if Conditions.count > indexPath.row{
                let metrixItem = Conditions[indexPath.row]
                cell.displayConditionData(item: metrixItem)
            }
        } else if  tableView == tblSymptom {
            if symptoms.count > indexPath.row{
                let metrixItem = symptoms[indexPath.row]
                cell.displaySymptomsData(item: metrixItem)
            }
        } else if  tableView == tblVitals {
            if Vitals.count > indexPath.row{
                let metrixItem = Vitals[indexPath.row]
                cell.displayVitals(item: metrixItem)
            }
        } else if  tableView == tblLab {
            if labs.count > indexPath.row{
                let metrixItem = labs[indexPath.row]
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
        detailConditionVC = UIStoryboard(name: Storyboard.acuityDetailPullUp.rawValue, bundle: nil).instantiateViewController(withIdentifier: "AcuityDetailConditionViewController") as? AcuityDetailConditionViewController
        self.addChild(detailConditionVC!)
        visualEffectView.addSubview((detailConditionVC?.view)!)
        detailConditionVC?.didMove(toParent: self)
        
        //PAss metrix Item to display data...
        detailConditionVC?.systemName = metrixType
        
        setUpCloseButton()
        //Hide main view of Detail Pullup class
        mainView.isHidden = true
        detailConditionVC?.setHandler(handler: { [weak self] (open) in
            if open ?? false{
                self?.visualEffectView.bringSubviewToFront((self?.handleArea)!)
            }else{
                self?.detailConditionVC?.view.removeFromSuperview()
                self?.detailConditionVC?.removeFromParent()
            }
        })
        visualEffectView.bringSubviewToFront(handleArea)
    }
    
    func setUpCloseButton(){
        //Add close button target
        btnClose = CloseButton()
        let rect = (btnClose!.frame)
        let originX = Double(handleArea.frame.size.width - (rect.size.width)-20)
        let originY = Double(handleArea.frame.size.height - (rect.size.height))/2
        
        btnClose!.frame = CGRect(origin: CGPoint(x: originX, y: originY), size: rect.size)
        
        btnClose!.addTarget(self, action: #selector(btnCloseClickedInAcuityValueViewController), for: UIControl.Event.touchUpInside)
        
        handleArea.addSubview(btnClose!)
    }
    //MARK: Btn close click
    @objc func btnCloseClickedInAcuityValueViewController(){
        if detailConditionVC != nil{
            if let _:UIView = detailConditionVC?.view.viewWithTag(111) {
                self.detailConditionVC?.removeDetailValueViewController()
            }
            else{
                btnClose?.removeFromSuperview()
                detailConditionVC?.view.removeFromSuperview()
                detailConditionVC?.removeFromParent()
                mainView.isHidden = false
                
            }
            
        }
    }
}
extension AcuityDetailPullUpViewController: ChartDelegate {
    
    // Chart delegate
    
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

