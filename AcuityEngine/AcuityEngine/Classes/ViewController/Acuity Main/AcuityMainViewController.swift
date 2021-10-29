//
//  AcuityMainViewController.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 19/02/21.
//



import UIKit
import HealthKitReporter
import PopupDialog
import SVProgressHUD

let btnWheelSelectionWidth = 50
let btnWheelSelectionHeight = 50

enum ToggleCaseForBtnSelection: Int {
    case showNormalWheel = 1
    case showReorderWheel = 2
    case refreshData = 3
}

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
    
    @IBOutlet var btnPrevention: UIButton!
    
    //save last selected index in wheel...
    var lastSelectedIndex = 0
    //@IBOutlet var roundView: UIView!
    var btnWheelSelection: UIButton = UIButton()
    //===========btnWheelSelection will have 3 toggles===========//
    var btnWheelSelectionToggle = 1;
    
    //Wheel contain System
    var wheel: RotaryWheel?
    
    var strSelectedAcuityId: String?
    
    //ViewModel AcuityMain VC
    private let viewModelAcuityMain = AcuityMainViewModel()
    
    var leadingMyWellConstraint,topMyWellConstraint,centerMyWellConstraint,lblScoreCenterConstraint,lblScoreTopConstraint,lblScoreBottomConstraint,lblScoreTextLeadingConstraint,lblScoreTextCenterYConstraint: NSLayoutConstraint?
    
    var traillingMyWellConstraint,lblScoreTextCenterConstraint,lblScoreTextTopConstraint: NSLayoutConstraint?
    var isAnimationConstraintAdded: Bool = false
    var isProfileClicked:Bool = false
    //MARK: viewDidLoad
    override func viewDidLoad() {
        
        //Load super viewdidLoad
        super.viewDidLoad()
        //========================================================================================================
        //set UI color for main view
        setUIColorForMainView()
        //========================================================================================================
        setFontForMyWellScore()
        //========================================================================================================
        setDoubleTapGestureForProfileAndAddButton(button: headerView.btnAdd)
        setDoubleTapGestureForProfileAndAddButton(button: headerView.btnProfile)
        //========================================================================================================
        headerView.delegate = self
        //========================================================================================================
        //Set up Circle View
        self.callLoadHealthData()
        //========================================================================================================
        self.addPreventionButtonNearWheel()
        //========================================================================================================
        //Set pullup view height
        self.expandedViewHeight = viewModelAcuityMain.getExpandedViewHeight(expandedViewHeight: (self.expandedViewHeight), headerViewHeight: subScoreView.frame.maxY)
        self.reloadCardView()
        //========================================================================================================
        //Add notification for Pullup view open/close
        NotificationCenter.default.addObserver(self, selector: #selector(self.showSubScoreViewWithAnimation), name: Notification.Name(NSNotificationName.pullUpOpen.rawValue), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.showMainScoreViewWithAnimation), name: Notification.Name(NSNotificationName.pullUpClose.rawValue), object: nil)
        //Add notification for show AcuityDetailPopup when close Profile or Add Popup
        NotificationCenter.default.addObserver(self, selector: #selector(self.showAcuityDetailPopup), name: Notification.Name(NSNotificationName.showAcuityDetailPopup.rawValue), object: nil)
        //Add notification when segment change from popup
        NotificationCenter.default.addObserver(self, selector: #selector(self.refreshWheeltoShowDayWiseData), name: Notification.Name(NSNotificationName.refreshCircleView.rawValue), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.callLoadHealthData), name: Notification.Name(NSNotificationName.refreshDataInCircle.rawValue), object: nil)
        setMainScoreViewsLabelAnimationConstrinat(isFirstTime: true)
        self.setMainScoreViewsLabelConstrinat(isFirstTime: true)
    }
    
    
    deinit {
        if (headerView != nil){
            headerView.delegate = nil
        }
        
        wheel = nil
        wheel?.delegate = nil
        arrBodySystems = []
        arrSortedArray = []
        NotificationCenter.default.removeObserver(self,name: Notification.Name(NSNotificationName.pullUpOpen.rawValue), object: nil)
        NotificationCenter.default.removeObserver(self,name: Notification.Name(NSNotificationName.pullUpClose.rawValue), object: nil)
        NotificationCenter.default.removeObserver(self,name: Notification.Name(NSNotificationName.showAcuityDetailPopup.rawValue), object: nil)
        NotificationCenter.default.removeObserver(self,name: Notification.Name(NSNotificationName.refreshCircleView.rawValue), object: nil)
        NotificationCenter.default.removeObserver(self,name: Notification.Name(NSNotificationName.refreshDataInCircle.rawValue), object: nil)
    }
    //========================================================================================================
    //MARK: Notifications Methods..
    //========================================================================================================
    @objc  func callLoadHealthData(){
        self.loadHealthData(days: MyWellScore.sharedManager.daysToCalculateSystemScore, completion: { (success, error) in
            
        })
    }
    @objc func showMainScoreViewWithAnimation(){
        if isProfileClicked {
            self.removeMainScoreViewConstraintWhenaProfileOrAddClick(mainScoreView: mainScoreView, lblMyWell: lblMyWell, lblScoreText: lblScoreText, lblScore: lblScore, viewHeight: self.view.frame.height)
        }
        showMainScoreView()
        animateScoreView(view: self.mainScoreView)
        
    }
    @objc func showSubScoreViewWithAnimation(){
        self.removeMainScoreViewConstraintWhenaProfileOrAddClick(mainScoreView: mainScoreView, lblMyWell: lblMyWell, lblScoreText: lblScoreText, lblScore: lblScore, viewHeight: self.view.frame.height)
        showSubScoreView()
        animateScoreView(view: self.subScoreView)
        
    }
    //MARK:Add notification for show AcuityDetailPopup when close Profile or Add Popup
    @objc func showAcuityDetailPopup(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            // your code here
            self.openPullUpControllerWithSystemData()
        }
        
        
    }
    //MARK: Refresh Wheel To Updated Data
    /*
     When api call ad it creates wheel, it uses one day system score which was used to calculate My Well score.
     But in pull up we display 7/1 Month and 3 Months data. So, system score will be changed and according to it, there needs to be change color of system in Wheel.
     */
    //========================================================================================================
    @objc  func refreshWheeltoShowDayWiseData(){
        self.setUpAcuityCircleView()
    }
    
    
    //========================================================================================================
    //MARK: Refresh Health Data
    /*
     It reloads health data. So, if there is any new data available, it will use it.
     */
    //========================================================================================================
    
    //MARK: Refresh button click
    @IBAction func btnRefreshClick(sender:UIButton){
        callLoadHealthData()
    }
    
    func loadHealthData(days:SegmentValueForGraph,completion: @escaping (Bool, HealthkitSetupError?) -> Swift.Void){
        
        //Show Progress HUD
        SVProgressHUD.show()
        
        MyWellScore.sharedManager.loadHealthData(days: days) {[weak self] (success, error) in
            if success && error == nil{
                //Set up Circle View
                DispatchQueue.main.async {
                    
                    //Do my well score caclulation....
                    MyWellScore.sharedManager.myWellScoreCalculation()
                    
                    self?.setUpAcuityCircleView()
                    //Hide Progress HUD
                    SVProgressHUD.dismiss()
                    completion(success,error)
                }
                
            }
        }
        
    }
    //========================================================================================================
    //MARK: Setup Acuity Cirlce View.....
    //========================================================================================================
    @objc func setUpAcuityCircleView() {
        
        //Select system index from array of arrBodySystems
        let acuityId = strSelectedAcuityId
        var selSystem = 0
        
        //When Center wheel button selected..sort all data in Array Body System to Green,Red,Yellow..
        //if btnWheelSelection.isSelected == true {
        if btnWheelSelectionToggle == ToggleCaseForBtnSelection.showReorderWheel.rawValue{
            sortArrayBodySystem()
            MyWellScore.sharedManager.reorderDictionaryOfSystemScoreBasedOnScore()
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
    
    //========================================================================================================
    //MARK: Draw Wheel..
    //========================================================================================================
    func setupWheel(selSystem:Int, bodyStystems arrSelectedBodySystem:[[String:Any]], needToRotateChevron rotateChevron:Bool){
        
        if (wheel != nil){
            wheel?.removeFromSuperview()
        }
        let mutableBodySystemArray = NSMutableArray()
        mutableBodySystemArray.addObjects(from: arrSelectedBodySystem)
        
        wheel = RotaryWheel(frame: CGRect(x: (Int(CGFloat(Screen.screenWidth)) - ChartSize.kAcuityCircleWidth)/2, y: (Int(CGFloat(Screen.screenHeight)) - ChartSize.kAcuityCircleHeight)/2 , width: ChartSize.kAcuityCircleWidth, height: ChartSize.kAcuityCircleHeight), andDelegate: self, withSections: Int32(arrSelectedBodySystem.count), bodySystems: mutableBodySystemArray, selectedSystem: Int32(selSystem), needToRotateChevron: rotateChevron)
        
        
        //To show blue circle view
        let xOfwhiteCircleImageView = 92*((wheel?.whiteCircleContainerView.frame.size.width)!)/340;
        let innerView = UIView(frame: CGRect(x: (xOfwhiteCircleImageView/2), y: xOfwhiteCircleImageView/2-2.5, width: (wheel?.whiteCircleContainerView.frame.size.width)!-xOfwhiteCircleImageView, height: (wheel?.whiteCircleContainerView.frame.size.width)!-xOfwhiteCircleImageView+2 ))
        //innerView.center = (wheel?.roundbackGroundView.center)!
        innerView.backgroundColor = ColorSchema.kMainThemeColor
        innerView.layer.cornerRadius = innerView.frame.size.width / 2
        innerView.clipsToBounds = true;
        innerView.layer.masksToBounds = true;
        innerView.isUserInteractionEnabled = false
        btnWheelSelection.frame = CGRect(x: Int(innerView.frame.size.width)/2, y: Int(innerView.frame.size.height)/2, width: btnWheelSelectionWidth, height: btnWheelSelectionHeight)
        btnWheelSelection.center = wheel?.whiteCircleContainerView.center ?? CGPoint(x: 0, y: 0)
        //btnWheelSelection.setImage(ImageSet.wheel2, for: UIControl.State.selected)
        btnWheelSelection.setImage(ImageSet.wheel2, for: UIControl.State.normal)
        btnWheelSelection.addTarget(self, action: #selector(btnWheelSelectionClicked), for: UIControl.Event.touchUpInside)
        
        wheel?.addSubview(btnWheelSelection)
        wheel?.whiteCircleContainerView?.addSubview(innerView)
        //================ Keep arrowDownImageView on topmost ==========================//
        wheel?.whiteCircleContainerView?.bringSubviewToFront((wheel?.arrowDownImageView)!)
        
        if ((wheel) != nil){
            
            self.view.addSubview(wheel!)
            self.view.sendSubviewToBack(wheel!);
            //self.view.sendSubviewToBack(acuityIndexView);
            
        }
        addPreventionButtonNearWheel()
    }
    //========================================================================================================
    //MARK: Center Wheel Button
    //========================================================================================================
    @objc @IBAction func btnWheelSelectionClicked(_ sender: Any) {
        
        btnWheelSelectionToggle = btnWheelSelectionToggle + 1;
        /*if btnWheelSelection.isSelected == false {
         MyWellScore.sharedManager.reorderDictionaryOfSystemScoreBasedOnScore()
         btnWheelSelected(selectedSystemIndex: 0)
         
         self.openDetailPullUpViewController(withAnimation: false)
         }
         else{
         btnWheelNotSelected(selectedSystemIndex: 0)
         }
         btnWheelSelection.isSelected = !btnWheelSelection.isSelected*/
        
        switch btnWheelSelectionToggle {
        case ToggleCaseForBtnSelection.showNormalWheel.rawValue:
            do{
                btnWheelNotSelected(selectedSystemIndex: 0)
            }
            break;
        case ToggleCaseForBtnSelection.showReorderWheel.rawValue:
            do{
                MyWellScore.sharedManager.reorderDictionaryOfSystemScoreBasedOnScore()
                btnWheelSelected(selectedSystemIndex: 0)
                
                self.openDetailPullUpViewController(withAnimation: false)
            }
            break;
        case ToggleCaseForBtnSelection.refreshData.rawValue:
            do{
                
                //======= Refresh Health Data For Calculation===========//
                callLoadHealthData()
                btnWheelSelectionToggle = 1;
                btnWheelSelection.setImage(ImageSet.wheel2, for: UIControl.State.normal)
            }
            break;
        default:
            break;
        }
        
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
            print("btnWheelNotSelected",item["name"]!,index)
        }
    }
    //========================================================================================================
    //MARK: Sorting of body system array
    //========================================================================================================
    func sortArrayBodySystem(){
        arrSortedArray = viewModelAcuityMain.returnSortedArrayUsingIndexandSequence(bodySystemArray: arrBodySystems)
        
    }
    //========================================================================================================
    //MARK: set UI color for main view
    //========================================================================================================
    func setUIColorForMainView(){
        self.view.backgroundColor = ColorSchema.kMainThemeColor
    }
    //========================================================================================================
    //MARK: Set Score View Constraint For Animation
    //========================================================================================================
    func setMainScoreViewsLabelConstrinat(isFirstTime:Bool){
        //viewModelAcuityMain.setTopLabel(mainScoreView: mainScoreView, lblMyWell: lblMyWell, lblScoreText: lblScoreText, lblScore: lblScore, viewHeight: self.view.frame.height)
        setTopLabel(isFirstTime:isFirstTime)
    }
    func setMainScoreViewsLabelAnimationConstrinat(isFirstTime:Bool){
        //viewModelAcuityMain.setTopLabelAnimation(mainScoreView: mainScoreView, lblMyWell: lblMyWell, lblScoreText: lblScoreText, lblScore: lblScore, viewHeight: self.view.frame.height)
        setTopLabelAnimation(isFirstTime:isFirstTime)
    }
    func setTopLabel(isFirstTime:Bool) {
        
        if isAnimationConstraintAdded {
            mainScoreView.removeConstraint(traillingMyWellConstraint!)
            mainScoreView.removeConstraint(lblScoreTextCenterConstraint!)
            mainScoreView.removeConstraint(lblScoreTextLeadingConstraint!)
            mainScoreView.removeConstraint(topMyWellConstraint!)
            mainScoreView.removeConstraint(lblScoreTopConstraint!)
            mainScoreView.removeConstraint(lblScoreTextTopConstraint!)
            isAnimationConstraintAdded = false
        }
        var animationDuration  = 0.7
        if isFirstTime{
            animationDuration = 0.0
        }
        UIView.animateKeyframes(withDuration: animationDuration, delay: 0.0, options: .calculationModeLinear) { [self] in
            //
            //            mainScoreView.backgroundColor = .red
            //            lblMyWell.backgroundColor = .black
            //            lblScoreText.backgroundColor = .black
            //            lblScore.backgroundColor = .black
            //
            lblMyWell.font = lblMyWell.font.withSize(self.view.frame.height * 0.046) //UIFont.systemFont(ofSize: 26, weight: .semibold)
            
            lblScoreText.font = lblScoreText.font.withSize(self.view.frame.height * 0.030)
            //UIFont.systemFont(ofSize: 32, weight: .semibold)
            
            lblScore.font = lblScore.font.withSize(self.view.frame.height * 0.046 + 12)
            //UIFont.systemFont(ofSize: 32, weight: .semibold)
            
            
            lblMyWell.translatesAutoresizingMaskIntoConstraints = false
            lblScore.translatesAutoresizingMaskIntoConstraints = false
            lblScoreText.translatesAutoresizingMaskIntoConstraints = false
            
            let margins = mainScoreView.layoutMarginsGuide
            
            
            leadingMyWellConstraint = lblMyWell.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 20)
            topMyWellConstraint = lblMyWell.topAnchor.constraint(equalTo: margins.topAnchor, constant: 0)
            centerMyWellConstraint = lblMyWell.centerXAnchor.constraint(equalTo: margins.centerXAnchor, constant: 0)
            
            lblScoreCenterConstraint = lblScore.centerXAnchor.constraint(equalTo: lblMyWell.centerXAnchor, constant: 0)
            lblScoreTopConstraint = lblScore.topAnchor.constraint(equalTo: lblMyWell.bottomAnchor, constant: 0)
            lblScoreBottomConstraint = lblScore.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: 5)
            
            lblScoreTextLeadingConstraint = lblScoreText.leadingAnchor.constraint(equalTo: lblScore.trailingAnchor, constant: 4)
            
            /*let height1 = lblMyWell.heightAnchor.constraint(equalTo: margins.heightAnchor, multiplier: 0.39)
             let height2 = lblScore.heightAnchor.constraint(equalTo: margins.heightAnchor, multiplier: 0.6)
             let height3 = lblScoreText.heightAnchor.constraint(equalTo: lblScore.heightAnchor, multiplier: 0.42)*/
            lblScoreTextCenterYConstraint = lblScoreText.centerYAnchor.constraint(equalTo: lblScore.centerYAnchor, constant: lblScore.font.pointSize/lblScoreText.font.pointSize + (self.view.frame.height/CGFloat(Screen.iPhoneSEHeight))*2)
            mainScoreView.addConstraint(leadingMyWellConstraint!)
            mainScoreView.addConstraint(topMyWellConstraint!)
            mainScoreView.addConstraint(centerMyWellConstraint!)
            
            mainScoreView.addConstraint(lblScoreCenterConstraint!)
            mainScoreView.addConstraint(lblScoreTopConstraint!)
            mainScoreView.addConstraint(lblScoreBottomConstraint!)
            //            mainScoreView.addConstraint(height3)
            //            mainScoreView.addConstraint(height1)
            //            mainScoreView.addConstraint(height2)
            mainScoreView.addConstraint(lblScoreTextLeadingConstraint!)
            mainScoreView.addConstraint(lblScoreTextCenterYConstraint!)
            
            mainScoreView.layoutIfNeeded()
        } completion: { [self] (isSuccess) in
            
            
        }
    }
    
    func setTopLabelAnimation(isFirstTime:Bool) {
        var animationDuration  = 0.7
        if isFirstTime{
            animationDuration = 0.0
        }
        
        UIView.animateKeyframes(withDuration: animationDuration, delay: 0.0, options: .calculationModeLinear) { [self] in
            isAnimationConstraintAdded = true
            lblMyWell.font = lblMyWell.font.withSize(self.view.frame.height * 0.042)
            lblScoreText.font = lblScoreText.font.withSize(self.view.frame.height *  0.042)
            lblScore.font = lblScore.font.withSize(self.view.frame.height * 0.052)
            
            if !isFirstTime{
                self.removeMainScoreViewConstraintWhenaProfileOrAddClick(mainScoreView: mainScoreView, lblMyWell: lblMyWell, lblScoreText: lblScoreText, lblScore: lblScore, viewHeight: self.view.frame.height)
            }
            lblMyWell.translatesAutoresizingMaskIntoConstraints = false
            lblScore.translatesAutoresizingMaskIntoConstraints = false
            lblScoreText.translatesAutoresizingMaskIntoConstraints = false
            
            let margins = mainScoreView.layoutMarginsGuide
            
            topMyWellConstraint = lblMyWell.topAnchor.constraint(equalTo: margins.topAnchor, constant: (self.view.frame.height/CGFloat(Screen.iPhoneSEHeight)) * 8)
            lblScoreTopConstraint = lblScore.centerYAnchor.constraint(equalTo: lblMyWell.centerYAnchor, constant: 0)
            lblScoreTextTopConstraint = lblScoreText.topAnchor.constraint(equalTo: lblMyWell.topAnchor, constant: 0)
            
            traillingMyWellConstraint = lblMyWell.trailingAnchor.constraint(equalTo: lblScoreText.leadingAnchor, constant: -4)
            
            lblScoreTextCenterConstraint = lblScoreText.centerXAnchor.constraint(equalTo: margins.centerXAnchor, constant: (self.view.frame.width/CGFloat(Screen.iPhoneSEWidth)) * 10)
            //centerXAnchor.constraint(equalTo: margins.centerXAnchor, constant: 20)
            //(self.view.frame.width/CGFloat(Screen.iPhoneSEWidth)) * 16))
            lblScoreTextLeadingConstraint = lblScore.leadingAnchor.constraint(equalTo: lblScoreText.trailingAnchor, constant: 4)
            
            mainScoreView.addConstraint(traillingMyWellConstraint!)
            mainScoreView.addConstraint(lblScoreTextCenterConstraint!)
            mainScoreView.addConstraint(lblScoreTextLeadingConstraint!)
            mainScoreView.addConstraint(topMyWellConstraint!)
            mainScoreView.addConstraint(lblScoreTopConstraint!)
            mainScoreView.addConstraint(lblScoreTextTopConstraint!)
            mainScoreView.layoutIfNeeded()
        } completion: { [self] (isSuccess) in
            
            
        }
    }
    func removeMainScoreViewConstraintWhenaProfileOrAddClick(mainScoreView:UIView,lblMyWell:UILabel,lblScoreText:UILabel,lblScore:UILabel,viewHeight:CGFloat){
        mainScoreView.removeConstraint(leadingMyWellConstraint!)
        mainScoreView.removeConstraint(topMyWellConstraint!)
        mainScoreView.removeConstraint(centerMyWellConstraint!)
        
        mainScoreView.removeConstraint(lblScoreCenterConstraint!)
        mainScoreView.removeConstraint(lblScoreTopConstraint!)
        mainScoreView.removeConstraint(lblScoreBottomConstraint!)
        
        mainScoreView.removeConstraint(lblScoreTextLeadingConstraint!)
        mainScoreView.removeConstraint(lblScoreTextCenterYConstraint!)
        //        if isAnimationConstraintAdded {
        //        mainScoreView.removeConstraint(traillingMyWellConstraint!)
        //        mainScoreView.removeConstraint(lblScoreTextCenterConstraint!)
        //        mainScoreView.removeConstraint(lblScoreTextLeadingConstraint!)
        //        }
    }
    //========================================================================================================
    //MARK: Set Double Tap For Profile And Add Button
    //========================================================================================================
    func setDoubleTapGestureForProfileAndAddButton(button:UIButton){
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped(sender:)))
        tap.numberOfTapsRequired = 2
        button.addGestureRecognizer(tap)
    }
    @objc func doubleTapped(sender:UIButton) {
        //When Double Tap Profile and Add button, collapse Profile and Add pull up and show main pull up.
        pullUpController.collapsed()
    }
    //========================================================================================================
    //MARK: set font of my well score according to  view
    //========================================================================================================
    func setFontForMyWellScore(){
        if self.view.frame.height <= 667{
            lblScore.font = lblScore.font.withSize((self.view.frame.height * 100)/896)
            lblMyWell.font = lblMyWell.font.withSize((self.view.frame.height * 34)/896)
            lblScoreText.font = lblScoreText.font.withSize((self.view.frame.height * 22)/896)
            lblScoreTextWhenPopup.font = lblScoreText.font.withSize((self.view.frame.height * 40)/896)
            lblScoreWhenPopup.font = lblScoreText.font.withSize((self.view.frame.height * 60)/896)
        }
    }
    //========================================================================================================
    //MARK: Show data in header..
    //========================================================================================================
    
    func displayMyWellScoreData(){
        //self.headerView.lblSystemScore!.text = String(format: "%.2f", (MyWellScore.sharedManager.myWellScore))
        let score = (MyWellScore.sharedManager.myWellScore)
        
        lblScore.text = getStringToDisplayScore(score: score)
        lblScore.sizeToFit()
        //Score label in popup....
        lblScoreWhenPopup.text = lblScore.text
        
        //Set text color according to score....
        let themeColor = getThemeColor(index: lblScore.text, isForWheel: true)
        lblScore.textColor = themeColor
        lblScoreWhenPopup.textColor = lblScore.textColor
        
    }
    
    
    //MARK: Set background color in round view
    func setBackGroundColorRoundView(index:String){
        let themeColor = getThemeColor(index: index,isForWheel: true)
        wheel?.roundbackGroundView.backgroundColor = themeColor;
        if btnWheelSelectionToggle == ToggleCaseForBtnSelection.showReorderWheel.rawValue{
            let image = viewModelAcuityMain.getCenterBtnImageOfColor(index: index)
            btnWheelSelection.setImage(image, for: .normal)
        }
        //        if pullUpController.isExpanded{
        //            showSubScoreView()
        //        }else{
        //            showMainScoreView()
        //        }
    }
    
    //MARK: Show Main Score ..
    func showMainScoreView(){
        //activeTopConstraint()
        //setUpTopLabelNormal()
        self.setMainScoreViewsLabelConstrinat(isFirstTime: false)
        self.mainScoreView.isHidden = false
        self.subScoreView.isHidden = true
        self.stackAddView.isHidden = true
        self.stackProfileView.isHidden = true
        self.pullUpController.isExpanded = false
        
    }
    //MARK: Show Sub Score ..
    func showSubScoreView(){
        //inActiveTopConstraint()
        //setUpTopLabels()
        self.setMainScoreViewsLabelAnimationConstrinat(isFirstTime: false)
        self.mainScoreView.isHidden = false
        self.subScoreView.isHidden = true
        self.stackAddView.isHidden = true
        self.stackProfileView.isHidden = true
        self.pullUpController.isExpanded = true
        
    }
    //========================================================================================================
    //MARK: Wheel change delegate method..
    //========================================================================================================
    func wheelDidChangeValue(_ newValue: Int32){
        DispatchQueue.main.async { [weak self] in
            
            var item:[String:Any]?
            
            item = self?.fetchObjectFromDataArray(newValue)
            
            if (item != nil){
                let index:String = (item?["score"] as? String ?? "")
                self?.setBackGroundColorRoundView(index:index )
                //set selected system data..
                //IT's from PullViewController..When user change system in didSet it will change data...
                self?.selectPullUpType = .Detail
                self?.openDetailPullUpViewController(withAnimation: false)
                self?.systemData = item
                
            }
            
        }
    }
    func fetchObjectFromDataArray(_ newValue: Int32)->[String:Any]?{
        var item:[String:Any]?
        
        lastSelectedIndex = Int(newValue)
        
        /*if btnWheelSelection.isSelected == true {
         if (arrSortedArray!.count)>newValue{
         item = arrSortedArray?[Int(newValue)]
         
         }
         }else{
         if (arrBodySystems.count)>newValue{
         item = arrBodySystems[Int(newValue)]
         
         
         }
         }*/
        if btnWheelSelectionToggle == ToggleCaseForBtnSelection.showReorderWheel.rawValue{
            if (arrSortedArray!.count)>newValue{
                item = arrSortedArray?[Int(newValue)]
                
            }
        }
        else{
            if (arrBodySystems.count)>newValue{
                item = arrBodySystems[Int(newValue)]
                
                
            }
        }
        return item;
    }
    
    func openPullUpControllerWithSystemData(){
        DispatchQueue.main.async { [weak self] in
            
            var item:[String:Any]?
            
            item = self?.fetchObjectFromDataArray((Int32(self?.lastSelectedIndex ?? 0)))
            
            if (item != nil){
                
                //set selected system data..
                //IT's from PullViewController..When user change system in didSet it will change data...
                
                self?.selectPullUpType = .Detail
                self?.openDetailPullUpViewController(withAnimation: true)
                self?.systemData = item
                
            }
            
        }
    }
    //========================================================================================================
    //MARK: Open Detail PullUp ViewController..
    //========================================================================================================
    
    func openDetailPullUpViewController(withAnimation:Bool){
        if  (self.pullUpController.pullUpVC != nil),!self.pullUpController.pullUpVC.isKind(of: AcuityDetailPullUpViewController.self){
            
            if withAnimation{
                self.reloadCardViewWithAnimation()
            }else{
                self.reloadCardView()
            }
            
            
        }
    }
    //========================================================================================================
    //MARK: Add Prevention Button Near wheel..
    //========================================================================================================
    func addPreventionButtonNearWheel(){
        if let _ = wheel{
            btnPrevention.isHidden = false
            viewModelAcuityMain.arrangePreventionButtonNearWheel(btnPrevention: btnPrevention, view: self.view, wheel: wheel!)
            viewModelAcuityMain.displayPreventionData = { arrRecommondetions in
                self.showPreventionPopUp(arrRecommondetions: arrRecommondetions)
            }
            viewModelAcuityMain.showNoAgeDataAlert = { isShowNoAge in
                if isShowNoAge{
                    Utility.showAlertWithOKBtn(onViewController: self, title: AlertMessages.TITLE_NO_AGE_SET, message: AlertMessages.DESCIPTION_NO_AGE_SET)
                }
            }
            viewModelAcuityMain.noInternetAlert = { isInternetNotAvailable in
                if isInternetNotAvailable{
                    Utility.showAlertWithOKBtn(onViewController: self, title: AlertMessages.TITLE_NETWORK_PROBLEM, message: AlertMessages.NETWORK_PROBLEM_MESSAGE)
                }
            }
        }
    }
    func showPreventionPopUp(arrRecommondetions:[SpecificRecommendations]) {
        let customPopUpVC = CustomPopUpVC(nibName: "CustomPopUpVC", bundle: nil)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            // Create the dialog
            customPopUpVC.arrRecommondetions = arrRecommondetions
            
            // your code here
            customPopUpVC.subViewHeightConstraint?.constant = self.view.frame.size.height*2.2/3
            //customPopUpVC.subViewWidthConstraint?.constant = self.view.frame.size.width-22
            customPopUpVC.subView?.layoutIfNeeded()
            
        }
        let popup = PopupDialog(viewController: customPopUpVC,
                                buttonAlignment: .horizontal,
                                transitionStyle: .zoomIn,
                                preferredWidth: self.view.frame.size.width-22,
                                tapGestureDismissal: true,
                                panGestureDismissal: false)
        
        customPopUpVC.btnCloseClickedCallback = {
            popup.dismiss(nil)
        }
        
        present(popup, animated: true, completion: nil)
        
        
    }
}

extension AcuityMainViewController:HeaderDelegate{
    func btnAddClickedCallBack() {
        isProfileClicked = true
        mainScoreView.isHidden = true
        subScoreView.isHidden = true
        stackAddView.isHidden = false
        stackProfileView.isHidden = true
        animateScoreView(view: stackAddView)
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
        isProfileClicked = true
        mainScoreView.isHidden = true
        subScoreView.isHidden = true
        stackAddView.isHidden = true
        stackProfileView.isHidden = false
        animateScoreView(view: stackProfileView)
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
