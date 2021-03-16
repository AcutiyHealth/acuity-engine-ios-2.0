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
    @IBOutlet var lblScoreWhenPopup: UILabel!
    @IBOutlet var lblScoreText: UILabel!
    
    //Stackview....
    @IBOutlet var mainScoreView: UIView!
    @IBOutlet var subScoreView: UIView!
    @IBOutlet var stackProfileView: UIView!
    @IBOutlet var stackAddView: UIView!
    
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
        
        headerView.delegate = self
        //Set pullup view height
        self.expandedViewHeight = viewModelAcuityMain.getExpandedViewHeight(expandedViewHeight: (self.expandedViewHeight), headerViewHeight: subScoreView.frame.maxY)
        self.reloadCardView()
        
        //Set up Circle View
        self.setUpAcuityCircleView()
        
        //Add notification for Pullup view open/close
        NotificationCenter.default.addObserver(self, selector: #selector(self.showSubScoreView), name: Notification.Name("pullUpOpen"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.showMainScoreView), name: Notification.Name("pullUpClose"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.showAcuityDetailPopup), name: Notification.Name("showAcuityDetailPopup"), object: nil)
    }
    
    deinit {
        if (headerView != nil){
            headerView.delegate = nil
        }
    }
    //MARK:
    
    //MARK: set up Acuity circle view...
    
    func setUpAcuityCircleView() {
        
        //set UI color for main view
        setUIColorForMainView()
        setFontForMyWellScore()
        
        //Set up body system data with default value...
        arrBodySystems = viewModelAcuityMain.setupBodySystemData()
        
        //If body sytem more than 0 create wheel..
        if arrBodySystems.count>0{
            
            //Id of selected system..
            strSelectedAcuityId = (arrBodySystems[0]["id"]) as? String
            
            //[self setIndexImageView1Image];
            setAcuityIndexRemainingImageViewImages()
            
            //Select system index from array of arrBodySystems
            let acuityId = arrBodySystems[0]["id"] as? String
            let selSystem = viewModelAcuityMain.arrayIndexFromBodySystem(bodyStystem: arrBodySystems, andAcuityId: acuityId ?? "0")
            
            //setup wheel
            setupWheel(selSystem: selSystem, bodyStystems: arrBodySystems, needToRotateChevron: true)
            btnWheelSelection.isSelected = true
            self.btnWheelSelectionClicked(btnWheelSelection)
            
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
        }
    }
    //MARK: show data in header..
    func displayMyWellScoreData(){
        //self.headerView.lblSystemScore!.text = String(format: "%.2f", (MyWellScore.sharedManager.myWellScore))
        lblScore.text = String(format: "%.2f", (MyWellScore.sharedManager.myWellScore))
    }
    
    //MARK: draw wheel..
    func setupWheel(selSystem:Int, bodyStystems arrSelectedBodySystem:[[String:Any]], needToRotateChevron rotateChevron:Bool){
        
        if (wheel != nil){
            wheel?.removeFromSuperview()
        }
        let mutableBodySystemArray = NSMutableArray()
        mutableBodySystemArray.addObjects(from: arrSelectedBodySystem)
        
        wheel = RotaryWheel(frame: CGRect(x: (CGFloat(Screen.screenWidth) - ChartSize.kAcuityCircleWidth)/2, y: (CGFloat(Screen.screenHeight) - ChartSize.kAcuityCircleHeight)/2 , width: ChartSize.kAcuityCircleWidth, height: ChartSize.kAcuityCircleHeight), andDelegate: self, withSections: Int32(arrSelectedBodySystem.count), bodySystems: mutableBodySystemArray, selectedSystem: Int32(selSystem), needToRotateChevron: rotateChevron)
        
        //To shw blue circle view
        let innerView = UIView(frame: CGRect(x: 10, y: 10, width: (wheel?.roundbackGroundView.frame.size.width)!-18, height: (wheel?.roundbackGroundView.frame.size.height)!-18 ))
        innerView.center = (wheel?.roundbackGroundView.center)!
        innerView.backgroundColor = ColorSchema.kMainThemeColor
        innerView.layer.cornerRadius = innerView.frame.size.height / 2
        
        
        btnWheelSelection.frame = CGRect(x: Int(innerView.frame.size.width)/2 - btnWheelSelectionWidth/2, y: Int(innerView.frame.size.height)/2 - btnWheelSelectionHeight/2, width: btnWheelSelectionWidth, height: btnWheelSelectionHeight)
        btnWheelSelection.setImage(ImageSet.wheel2, for: UIControl.State.normal)
        btnWheelSelection.setImage(ImageSet.wheel1, for: UIControl.State.selected)
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
    
    @objc @IBAction func btnWheelSelectionClicked(_ sender: Any) {
        arrSortedArray = arrBodySystems
        if btnWheelSelection.isSelected == true {
            btnWheelSelection.isSelected = false
            setupWheel(selSystem: 0, bodyStystems: arrBodySystems, needToRotateChevron: true)
            if arrBodySystems.count>0{
                let item = arrBodySystems[0]
                let index:String = (item["score"] as? String ?? "")
                self.setBackGroundColorRoundView(index:index )
            }
        }else{
            btnWheelSelection.isSelected = true
            arrSortedArray = viewModelAcuityMain.returnSortedArrayUsingIndexandSequence(bodySystemArray: arrBodySystems)
            setupWheel(selSystem: 0, bodyStystems: arrSortedArray ?? arrBodySystems, needToRotateChevron: true)
            if arrSortedArray?.count ?? 0>0{
                let item = arrSortedArray?[0]
                let index:String = (item?["score"] as? String ?? "")
                self.setBackGroundColorRoundView(index:index )
            }
        }
    }
    //MARK: Sorting of body system array
    func setAcuityIndexRemainingImageViewImages(){
        arrSortedArray = viewModelAcuityMain.returnSortedArrayUsingIndexandSequence(bodySystemArray: arrBodySystems)
        
    }
    
    //MARK: set background color in round view
    func setBackGroundColorRoundView(index:String){
        let themeColor = getThemeColor(index: index,isForWheel: true)
        wheel?.roundbackGroundView.backgroundColor = themeColor;
        
        mainScoreView.isHidden = false
        subScoreView.isHidden = true
        stackAddView.isHidden = true
        stackProfileView.isHidden = true
        
    }
    //MARK: show Main Score view
    @objc func showMainScoreView(){
        
        self.mainScoreView.isHidden = false
        self.subScoreView.isHidden = true
        self.stackAddView.isHidden = true
        self.stackProfileView.isHidden = true
        
    }
    @objc func showAcuityDetailPopup(){
        self.wheelDidChangeValue(Int32(self.lastSelectedIndex))
        
    }
    @objc func showSubScoreView(){
        
        self.mainScoreView.isHidden = true
        self.subScoreView.isHidden = false
        self.stackAddView.isHidden = true
        self.stackProfileView.isHidden = true
        
        
    }
    //MARK: Wheel change delegate method..
    func wheelDidChangeValue(_ newValue: Int32){
        DispatchQueue.main.async { [weak self] in
            
            var item:[String:Any]?
            
            self?.lastSelectedIndex = Int(newValue)
            
            if ((self?.btnWheelSelection.isSelected) != nil) {
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
                self?.reloadCardView()
                self?.systemData = item
                
            }
            
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
        
        self.selectPullUpType = .Profie
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
