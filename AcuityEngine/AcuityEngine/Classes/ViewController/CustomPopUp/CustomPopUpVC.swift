//
//  CustomPopUpVC.swift
//  AcuityEngine
//
//  Created by DevDigital on 13/10/21.
//

import UIKit

class CustomPopUpVC: UIViewController {
    
    @IBOutlet weak var tblTitle: UITableView! {
        didSet{
            setTbl()
        }
    }
    @IBOutlet weak var segmentControl:UISegmentedControl!
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var subViewHeightConstraint:NSLayoutConstraint!
    var arrRecommondetions = [SpecificRecommendations]() {
        didSet{
            loadFirstRecommondetion()
        }
    }
    var arrTitle = [String]()
    var btnCloseClickedCallback: (() -> Void)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tblTitle.delegate = self
        tblTitle.dataSource = self
        
        lblTitle.text = "Prevention Recommendations By Grade"
        lblTitle.font = Fonts.kAcuityAddOptionTitleFont
        lblTitle.textColor = UIColor.white
        
        self.view.backgroundColor = UIColor.white.withAlphaComponent(0.2)
    }
    
    func setTbl(){
        tblTitle.register(UINib(nibName: "CustomPopUpCell", bundle: nil), forCellReuseIdentifier: NSStringFromClass(CustomPopUpCell.classForCoder()))
        setUpSegmentControl(segmentControl: segmentControl)
    }
    func setUpSegmentControl(segmentControl:UISegmentedControl){
        
        segmentControl.defaultConfiguration(font: Fonts.kAcuityDetailSegmentFont, color: UIColor.white)
        segmentControl.selectedConfiguration(font: Fonts.kAcuityDetailSegmentFont, color: UIColor.black)
//        var titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
//        segmentControl.setTitleTextAttributes(titleTextAttributes, for: .normal)
//        titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
//        segmentControl.setTitleTextAttributes(titleTextAttributes, for: .selected)
        segmentControl.selectedSegmentIndex = 0
        //self.segmentClicked(segmentControl)
    }
    func loadFirstRecommondetion(){
        filterARecommondetions()
    }
    @IBAction func btnCloseClicked(sender:UIButton){
        if let _ = btnCloseClickedCallback{
            (self.btnCloseClickedCallback)()
        }
    }
    
    @IBAction func changeSegmentControlStatus(segmentRecommondetions:UISegmentedControl){
        if segmentRecommondetions.selectedSegmentIndex == 0{
            filterARecommondetions()
        }else{
            filterBRecommondetions()
        }
        
    }
    func filterARecommondetions(){
        arrTitle = []
        for obj in 0..<(arrRecommondetions.count ) {
            let data = arrRecommondetions[obj]
            
            let _ = data.ageRange?.map{ _ in
                if  data.grade == "A"{
                    arrTitle.append(data.title ?? "")
                }
            }
        }
        self.tblTitle.reloadData()
    }
    
    func filterBRecommondetions(){
        arrTitle = []
        for obj in 0..<(arrRecommondetions.count ) {
            let data = arrRecommondetions[obj]
            
            let _ = data.ageRange?.map{ _ in
                if  data.grade == "B"{
                    arrTitle.append(data.title ?? "")
                }
            }
        
        }
        self.tblTitle.reloadData()
    }
}

extension CustomPopUpVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblTitle.dequeueReusableCell(withIdentifier: NSStringFromClass(CustomPopUpCell.classForCoder()), for: indexPath) as! CustomPopUpCell
        cell.lblTitle.text = arrTitle[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension;
    }
    
}
