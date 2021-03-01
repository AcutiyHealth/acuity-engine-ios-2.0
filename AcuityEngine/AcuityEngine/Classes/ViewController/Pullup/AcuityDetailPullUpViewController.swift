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
    @IBOutlet weak var systemMetricsTable: UITableView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var scoreLbl: UILabel!
    @IBOutlet weak var handleArea: UIView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    let labelsAsStringForWeek: Array<String> = dayArray
    var labelsAsStringForMonth: Array<String> = ["Week1","Week2","Week3","Week4"]
    //var labelsAsStringForMonth: Array<String> = ["Week1","Week2","Week3","Week4"]
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
    var systemMetricsData:[[String:Any]]?
    // MARK: - Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        setupSegmentControl()
        
        chart.delegate = self
        // Simple chart
        let labelsAsString: Array<String> = labelsAsStringForWeek
        let data = [
            (x: 0, y: 0),
            (x: 3, y: 2.5),
            (x: 4, y: 2),
            (x: 5, y: 2.3),
            (x: 7, y: 3),
           
        ]
        let series = ChartSeries(data: data)
        series.area = true
        series.color = ChartColors.yellowColor()
        chart.xLabels = [0,1,2,3,4,5,6]
        chart.xLabelsFormatter = { (labelIndex: Int, labelValue: Double) -> String in
            return labelsAsString[labelIndex]
        }
        chart.add(series)
    }
    
    
    //MARK: show system data in tableview
    func setupSegmentControl(){
        segmentControl.setTitle(SegmentValueForGraph.SevenDays.rawValue, forSegmentAt: 0)
        segmentControl.setTitle(SegmentValueForGraph.ThirtyDays.rawValue, forSegmentAt: 1)
        segmentControl.setTitle(SegmentValueForGraph.ThreeMonths.rawValue, forSegmentAt: 2)
        segmentControl.defaultConfiguration(font: UIFont.systemFont(ofSize: 15), color: UIColor.white)
        segmentControl.selectedConfiguration(font: UIFont.boldSystemFont(ofSize: 15), color: UIColor.black)
    }
    
    //MARK: show system data in tableview
    func showSystemData(){
        guard let systemData = systemData else {
            return
        }
        systemMetricsData = systemData["metricCardio"] as? [[String:Any]]
        titleLbl.text = systemData["name"] as? String ?? ""
        scoreLbl.text = systemData["score"]  as? String ?? ""
        let index:String = (systemData["index"] as? String ?? "")
        
        //change background color with system selection..
        let themeColor = getThemeColor(index: index)
        scoreLbl.textColor = themeColor;
        
        
        self.reloadTableView()
    }
    
    func reloadTableView(){
        self.systemMetricsTable.reloadData()
    }
    
}

// MARK: - SOPullUpViewDelegate

extension AcuityDetailPullUpViewController: SOPullUpViewDelegate {
    
    func pullUpViewStatus(_ sender: UIViewController, didChangeTo status: PullUpStatus) {
        switch status {
        case .collapsed:
            UIView.animate(withDuration: 0.6)  { [weak self] in
                //self?.titleLbl.alpha = 0
            }
        case .expanded:
            UIView.animate(withDuration: 0.6) { [weak self] in
                //self?.titleLbl.alpha = 1
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
        return systemMetricsData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: PullUpDisplayCell = tableView.dequeueReusableCell(withIdentifier: "PullUpDisplayCell", for: indexPath as IndexPath) as? PullUpDisplayCell else {
            fatalError("PullUpDisplayCell cell is not found")
        }
        let metrixItem = systemMetricsData?[indexPath.row]
        if let _ = metrixItem{
            cell.displayData(metrixItem: metrixItem!)
        }
       
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
extension AcuityDetailPullUpViewController: ChartDelegate {
    
    // Chart delegate
    
    func didTouchChart(_ chart: Chart, indexes: Array<Int?>, x: Double, left: CGFloat) {
        for (seriesIndex, dataIndex) in indexes.enumerated() {
            if let value = chart.valueForSeries(seriesIndex, atIndex: dataIndex) {
                print("Touched series: \(seriesIndex): data index: \(dataIndex!); series value: \(value); x-axis value: \(x) (from left: \(left))")
            }
        }
    }
    
    func didFinishTouchingChart(_ chart: Chart) {
        
    }
    
    func didEndTouchingChart(_ chart: Chart) {
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        super.viewWillTransition(to: size, with: coordinator)
        
        // Redraw chart on rotation
        chart.setNeedsDisplay()
        
    }
}
