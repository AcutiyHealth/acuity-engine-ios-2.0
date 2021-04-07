//
//  AcuityMainViewController.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 19/02/21.
//



import UIKit

let btnWheelSelectionWidth = 84
let btnWheelSelectionHeight = 84

class AcuityMainViewController: PullUpViewController, UIScrollViewDelegate,RotaryProtocol{
    
    //Use for all system data..Ex. Cardio,Respiratory
    var arrBodySystems: [[String:Any]] = []
    //Custom header view that contain MyWell Score
    @IBOutlet weak var headerView: Header!
    
    //Array sorting based on it's index value..
    var arrSortedArray: [[String:Any]]?
    
    @IBOutlet var lblScore: UILabel!
    @IBOutlet var lblMyWell: UILabel!
    @IBOutlet var lblScoreText: UILabel!
    
    //Stackview....
    @IBOutlet var mainScoreView: UIView!
    @IBOutlet var subScoreView: UIView!
    @IBOutlet var stackProfileView: UIView!
    @IBOutlet var stackAddView: UIView!
    
    //SubScoreview Views
    @IBOutlet var lblScoreWhenPopup: UILabel!
    @IBOutlet var lblScoreTextWhenPopup: UILabel!
    
    //save last selected index in wheel...
    var lastSelectedIndex = 0
    //@IBOutlet var roundView: UIView!
    var btnWheelSelection: UIButton = UIButton()
    
    //Wheel contain System
    var wheel: RotaryWheel?
    
    var strSelectedAcuityId: String?
    
    //ViewModel AcuityMain VC
    private let viewModelAcuityMain = AcuityMainViewModel()
    
    
    //MARK: viewDidLoad
    override func viewDidLoad() {
        
        //Load super viewdidLoad
        super.viewDidLoad()
        
        //set UI color for main view
        setUIColorForMainView()
        
        setFontForMyWellScore()
        
        headerView.delegate = self
        //Set pullup view height
        self.expandedViewHeight = viewModelAcuityMain.getExpandedViewHeight(expandedViewHeight: (self.expandedViewHeight), headerViewHeight: subScoreView.frame.maxY)
        self.reloadCardView()
        
        //Set up Circle View
        self.callLoadHealthData()
        
        //Add notification for Pullup view open/close
        NotificationCenter.default.addObserver(self, selector: #selector(self.showSubScoreView), name: Notification.Name("pullUpOpen"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.showMainScoreView), name: Notification.Name("pullUpClose"), object: nil)
        //Add notification for show AcuityDetailPopup when close Profile or Add Popup
        NotificationCenter.default.addObserver(self, selector: #selector(self.showAcuityDetailPopup), name: Notification.Name("showAcuityDetailPopup"), object: nil)
        
        //Add notification when segment change from popup
        NotificationCenter.default.addObserver(self, selector: #selector(self.callLoadHealthData), name: Notification.Name("refreshCircleView"), object: nil)
    }
    
    deinit {
        if (headerView != nil){
            headerView.delegate = nil
        }
        
        wheel = nil
        wheel?.delegate = nil
        arrBodySystems = []
        arrSortedArray = []
        
    }
    
    //MARK: Load Health Data
    @objc  func callLoadHealthData(){
        self.loadHealthData(days: MyWellScore.sharedManager.daysToCalculateSystemScore, completion: { (success, error) in
            
        })
        
    }
    func loadHealthData(days:SegmentValueForGraph,completion: @escaping (Bool, HealthkitSetupError?) -> Swift.Void){
        
        //Show Progress HUD
        let progrssHUD = showIndicatorInView(view: self.view)
        
        MyWellScore.sharedManager.loadHealthData(days: days) {[weak self] (success, error) in
            if success && error == nil{
                //Set up Circle View
                DispatchQueue.main.async {
                    self?.setUpAcuityCircleView()
                    //Hide Progress HUD
                    progrssHUD.dismiss(animated: true)
                    completion(success,error)
                }
                
            }
        }
        
    }
    
    //MARK: set up Acuity circle view...
    
    @objc func setUpAcuityCircleView() {
        
        
        //Select system index from array of arrBodySystems
        let acuityId = strSelectedAcuityId
        var selSystem = 0
        
        //When Center wheel button selected..sort all data in Array Body System to Green,Red,Yellow..
        if btnWheelSelection.isSelected == true {
            
            sortArrayBodySystem()
            selSystem = viewModelAcuityMain.arrayIndexFromBodySystem(bodyStystem: arrSortedArray!, andAcuityId: acuityId ?? "0")
            
            btnWheelSelected(selectedSystemIndex: selSystem)
            wheel?.transform(true, andselectedIndex: Int32(selSystem), andPreviousIndex: wheel?.currentValue ?? 0)
            
        }
        else{
            //When Center wheel button not selected.
            //Set up body system data with default value...
            arrBodySystems = viewModelAcuityMain.setupBodySystemData()
            
            //If body sytem more than 0 create wheel..
            if arrBodySystems.count>0{
                
                //Select system index from array of arrBodySystems
                
                let selSystem = viewModelAcuityMain.arrayIndexFromBodySystem(bodyStystem: arrBodySystems, andAcuityId: acuityId ?? "0")
                
                btnWheelNotSelected(selectedSystemIndex: selSystem)
                
                //Transform wheel to selected System...
                wheel?.transform(true, andselectedIndex: Int32(selSystem), andPreviousIndex: wheel?.currentValue ?? 0)
                
            }
            
            //display scrore data...
            displayMyWellScoreData()
            
        }
        
    }
    
    //MARK: set UI color for main view
    func setUIColorForMainView(){
        self.view.backgroundColor = ColorSchema.kMainThemeColor
    }
    //MRK: set font of my well score according to  view
    func setFontForMyWellScore(){
        if self.view.frame.height <= 667{
            lblScore.font = lblScore.font.withSize((self.view.frame.height * 100)/896)
            lblMyWell.font = lblMyWell.font.withSize((self.view.frame.height * 34)/896)
            lblScoreText.font = lblScoreText.font.withSize((self.view.frame.height * 22)/896)
            lblScoreTextWhenPopup.font = lblScoreText.font.withSize((self.view.frame.height * 40)/896)
            lblScoreWhenPopup.font = lblScoreText.font.withSize((self.view.frame.height * 60)/896)
        }
    }
    
    //MARK: Refresh button click
    @IBAction func btnRefreshClick(sender:UIButton){
        callLoadHealthData()
    }
    //MARK: Show data in header..
    func displayMyWellScoreData(){
        //self.headerView.lblSystemScore!.text = String(format: "%.2f", (MyWellScore.sharedManager.myWellScore))
        lblScore.text = String(format: "%.2f", (MyWellScore.sharedManager.myWellScore))
        lblScoreWhenPopup.text = String(format: "%.2f", (MyWellScore.sharedManager.myWellScore))
    }
    
    //MARK: Draw Wheel..
    func setupWheel(selSystem:Int, bodyStystems arrSelectedBodySystem:[[String:Any]], needToRotateChevron rotateChevron:Bool){
        
        if (wheel != nil){
            wheel?.removeFromSuperview()
        }
        let mutableBodySystemArray = NSMutableArray()
        mutableBodySystemArray.addObjects(from: arrSelectedBodySystem)
        
        wheel = RotaryWheel(frame: CGRect(x: (CGFloat(Screen.screenWidth) - ChartSize.kAcuityCircleWidth)/2, y: (CGFloat(Screen.screenHeight) - ChartSize.kAcuityCircleHeight)/2 , width: ChartSize.kAcuityCircleWidth, height: ChartSize.kAcuityCircleHeight), andDelegate: self, withSections: Int32(arrSelectedBodySystem.count), bodySystems: mutableBodySystemArray, selectedSystem: Int32(selSystem), needToRotateChevron: rotateChevron)
        
        //To show blue circle view
        let innerView = UIView(frame: CGRect(x: 10, y: 10, width: (wheel?.roundbackGroundView.frame.size.width)!-18, height: (wheel?.roundbackGroundView.frame.size.height)!-18 ))
        innerView.center = (wheel?.roundbackGroundView.center)!
        innerView.backgroundColor = ColorSchema.kMainThemeColor
        innerView.layer.cornerRadius = innerView.frame.size.height / 2
        innerView.clipsToBounds = true;
        
        btnWheelSelection.frame = CGRect(x: Int(innerView.frame.size.width)/2 - btnWheelSelectionWidth/2, y: Int(innerView.frame.size.height)/2 - btnWheelSelectionHeight/2, width: btnWheelSelectionWidth, height: btnWheelSelectionHeight)
        btnWheelSelection.setImage(ImageSet.wheel2, for: UIControl.State.selected)
        btnWheelSelection.setImage(ImageSet.wheel1, for: UIControl.State.normal)
        btnWheelSelection.addTarget(self, action: #selector(btnWheelSelectionClicked), for: UIControl.Event.touchUpInside)
        
        innerView.addSubview(btnWheelSelection)
        wheel?.addSubview(innerView)
        
        
        innerView.setNeedsLayout()
        innerView.isUserInteractionEnabled = true
        //roundView.setNeedsDisplay()
        
        if ((wheel) != nil){
            
            self.view.addSubview(wheel!)
            self.view.sendSubviewToBack(wheel!);
            //self.view.sendSubviewToBack(acuityIndexView);
            
        }
    }
    
    //MARK: Center Wheel Button
    @objc @IBAction func btnWheelSelectionClicked(_ sender: Any) {
        
        if btnWheelSelection.isSelected == false {
            btnWheelSelected(selectedSystemIndex: 0)
        }
        else{
            btnWheelNotSelected(selectedSystemIndex: 0)
        }
        btnWheelSelection.isSelected = !btnWheelSelection.isSelected
    }
    
    func btnWheelSelected(selectedSystemIndex:Int){
        arrSortedArray = viewModelAcuityMain.returnSortedArrayUsingIndexandSequence(bodySystemArray: arrBodySystems)
        setupWheel(selSystem: selectedSystemIndex, bodyStystems: arrSortedArray ?? arrBodySystems, needToRotateChevron: true)
        if arrSortedArray?.count ?? 0>0{
            let item = arrSortedArray?[0]
            let index:String = (item?["score"] as? String ?? "")
            self.setBackGroundColorRoundView(index:index )
        }
    }
    
    func btnWheelNotSelected(selectedSystemIndex:Int){
        
        setupWheel(selSystem: selectedSystemIndex, bodyStystems: arrBodySystems, needToRotateChevron: true)
        if arrBodySystems.count>0{
            let item = arrBodySystems[0]
            let index:String = (item["score"] as? String ?? "")
            self.setBackGroundColorRoundView(index:index )
        }
    }
    //MARK: Sorting of body system array
    func sortArrayBodySystem(){
        arrSortedArray = viewModelAcuityMain.returnSortedArrayUsingIndexandSequence(bodySystemArray: arrBodySystems)
        
    }
    
    //MARK: Seet background color in round view
    func setBackGroundColorRoundView(index:String){
        let themeColor = getThemeColor(index: index,isForWheel: true)
        wheel?.roundbackGroundView.backgroundColor = themeColor;
        if pullUpController.isExpanded{
            showSubScoreView()
        }else{
            showMainScoreView()
        }
    }
    
    //MARK: Notifications Methods..
    @objc func showMainScoreView(){
        
        self.mainScoreView.isHidden = false
        self.subScoreView.isHidden = true
        self.stackAddView.isHidden = true
        self.stackProfileView.isHidden = true
        self.pullUpController.isExpanded = false
    }
    @objc func showAcuityDetailPopup(){
        self.wheelDidChangeValue(Int32(self.lastSelectedIndex))
        
    }
    @objc func showSubScoreView(){
        
        self.mainScoreView.isHidden = true
        self.subScoreView.isHidden = false
        self.stackAddView.isHidden = true
        self.stackProfileView.isHidden = true
        self.pullUpController.isExpanded = true
        
    }
    //MARK: Wheel change delegate method..
    func wheelDidChangeValue(_ newValue: Int32){
        DispatchQueue.main.async { [weak self] in
            
            var item:[String:Any]?
            
            self?.lastSelectedIndex = Int(newValue)
            
            if self?.btnWheelSelection.isSelected == true {
                if (self?.arrSortedArray!.count)!>newValue{
                    item = self?.arrSortedArray?[Int(newValue)]
                    let index:String = (item?["score"] as? String ?? "")
                    self?.setBackGroundColorRoundView(index:index )
                    
                    self?.strSelectedAcuityId = (item?["id"] as? String ?? "")
                }
            }else{
                if (self?.arrBodySystems.count)!>newValue{
                    item = self?.arrBodySystems[Int(newValue)]
                    let index:String = (item?["score"] as? String ?? "")
                    
                    //change background color with system selection..
                    self?.setBackGroundColorRoundView(index:index )
                    
                    
                    //selection of id
                    self?.strSelectedAcuityId = (item?["id"] as? String ?? "")
                    
                }
            }
            
            if (item != nil){
                
                //set selected system data..
                //IT's from PullViewController..When user change system in didSet it will change data...
                self?.selectPullUpType = .Detail
                self?.openDetailPullUpViewController()
                self?.systemData = item
                
            }
            
        }
    }
    
    func openDetailPullUpViewController(){
        if  (self.pullUpController.pullUpVC != nil),!self.pullUpController.pullUpVC.isKind(of: AcuityDetailPullUpViewController.self){
            
            self.reloadCardView()
            
        }
    }
    
}

extension AcuityMainViewController:HeaderDelegate{
    func btnAddClickedCallBack() {
        mainScoreView.isHidden = true
        subScoreView.isHidden = true
        stackAddView.isHidden = false
        stackProfileView.isHidden = true
        self.selectPullUpType = .Add
        if  (self.pullUpController.pullUpVC != nil),self.pullUpController.pullUpVC.isKind(of: AddOptionSelectionViewController.self){
            if !pullUpController.isExpanded{
                self.reloadCardView()
                pullUpController.expanded()
            }
        }else{
            self.reloadCardView()
            pullUpController.expanded()
        }
    }
    func btnProfileClickedCallBack() {
        mainScoreView.isHidden = true
        subScoreView.isHidden = true
        stackAddView.isHidden = true
        stackProfileView.isHidden = false
        
        self.selectPullUpType = .Profile
        //if pullUpController.isE
        if  (self.pullUpController.pullUpVC != nil),self.pullUpController.pullUpVC.isKind(of: ProfileOptionSelectionViewController.self){
            if !pullUpController.isExpanded{
                self.reloadCardView()
                pullUpController.expanded()
            }
        }else{
            self.reloadCardView()
            pullUpController.expanded()
        }
        
        
    }
}
