//
//  AcuityMainViewController.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 19/02/21.
//



import UIKit


class AcuityMainViewController: PullUpViewController, UIScrollViewDelegate,RotaryProtocol{
    
    //Use for all system data..Ex. Cardio,Respiratory
    var arrBodySystems: [[String:Any]] = []
    //Custom header view that contain MyWell Score
    @IBOutlet weak var headerView: Header!
    
    //Array sorting based on it's index value..
    var arrSortedArray: [[String:Any]]?
    
    //@IBOutlet var roundView: UIView!
    @IBOutlet var btnWheelSelection: UIButton!
    
    //Wheel contain System
    var wheel: RotaryWheel?
    
    var strSelectedAcuityId: String?
    
    //ViewModel Cardio
    private let viewModelCardio = CardioViewModel()
    //ViewModel Respiratory
    private let viewModelRespiratory = RespiratoryViewModel()
    
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpAcuityCircleView()
        
    }
    
   
  //MARK: set up Acuity circle view...
    
    func setUpAcuityCircleView() {
        
        //set UI color for main view
        setUIColorForMainView()
        
        //Set up body system data with default value...
        setupBodySystemData()
        
        //If body sytem more than 0 create wheel..
        if arrBodySystems.count>0{
            
            //Id of selected system..
            strSelectedAcuityId = (arrBodySystems[0]["id"]) as? String
            
            //[self setIndexImageView1Image];
            setAcuityIndexRemainingImageViewImages()
            
            //Select system index from array of arrBodySystems
            let acuityId = arrBodySystems[0]["id"] as? String
            let selSystem = self.arrayIndexFromBodySystem(bodyStystem: arrBodySystems, andAcuityId: acuityId ?? "0")
            
            //setup wheel
            setupWheel(selSystem: selSystem, bodyStystems: arrBodySystems, needToRotateChevron: !btnWheelSelection.isSelected)
            
            
            //display scrore data...
            displayMyWellScoreData()
          
        }
        
    }
    
    //MARK: set UI color for main view
    func setUIColorForMainView(){
        self.view.backgroundColor = AppColorsData.kMainThemeColor
    }
    
    //MARK: show data in header..
    func displayMyWellScoreData(){
        self.headerView.lblSystemScore!.text = String(format: "%.2f", (MyWellScore.sharedManager.myWellScore))
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
        let innerView = UIView(frame: CGRect(x: 10, y: 10, width: (wheel?.roundbackGroundView.frame.size.width)!-20, height: (wheel?.roundbackGroundView.frame.size.height)!-20 ))
        innerView.center = (wheel?.roundbackGroundView.center)!
        innerView.backgroundColor = AppColorsData.kMainThemeColor
        innerView.layer.cornerRadius = innerView.frame.size.height / 2
        
        btnWheelSelection.removeFromSuperview()
        let btnWheelSelectionWidth = 50
        let btnWheelSelectionHeight = 50
        btnWheelSelection.frame = CGRect(x: Int(innerView.frame.size.width)/2 - btnWheelSelectionWidth/2, y: Int(innerView.frame.size.height)/2 - btnWheelSelectionHeight/2, width: btnWheelSelectionWidth, height: btnWheelSelectionHeight)
        innerView.addSubview(btnWheelSelection)
        //roundView.backgroundColor = UIColor.clear
       // roundView.center = wheel!.center
        wheel?.addSubview(innerView)
        //wheel?.bringSubviewToFront(roundView)
        
        innerView.setNeedsLayout()
        innerView.isUserInteractionEnabled = true
        //roundView.setNeedsDisplay()
        
        if ((wheel) != nil){
            
            self.view.addSubview(wheel!)
            self.view.sendSubviewToBack(wheel!);
            //self.view.sendSubviewToBack(acuityIndexView);
        }
    }
    
    @IBAction func btnWheelSelectionClicked(_ sender: Any) {
        arrSortedArray = arrBodySystems
        if btnWheelSelection.isSelected == true {
            btnWheelSelection.isSelected = false
            setupWheel(selSystem: 0, bodyStystems: arrBodySystems, needToRotateChevron: true)
            if arrBodySystems.count>0{
                let item = arrBodySystems[0]
                let index:String = (item["index"] as? String ?? "")
                self.setBackGroundColorRoundView(index:index )
            }
        }else{
            btnWheelSelection.isSelected = true
            arrSortedArray = self.returnSortedArrayUsingIndexandSequence(bodySystemArray: arrBodySystems)
            setupWheel(selSystem: 0, bodyStystems: arrSortedArray ?? arrBodySystems, needToRotateChevron: true)
            if arrSortedArray?.count ?? 0>0{
                let item = arrSortedArray?[0]
                let index:String = (item?["index"] as? String ?? "")
                self.setBackGroundColorRoundView(index:index )
            }
        }
    }
    //MARK: Sorting of body system array
    func setAcuityIndexRemainingImageViewImages(){
        arrSortedArray = returnSortedArrayUsingIndexandSequence(bodySystemArray: arrBodySystems)
        
    }
    
    //MARK: set background color in round view
    func setBackGroundColorRoundView(index:String){
        let themeColor = getThemeColor(index: index)
        wheel?.roundbackGroundView.backgroundColor = themeColor;
        
    }
    
    //MARK: Wheel change delegate method..
    func wheelDidChangeValue(_ newValue: Int32){
        DispatchQueue.main.async {
            
            var item:[String:Any]?
            
            if self.btnWheelSelection.isSelected {
                if self.arrSortedArray!.count>newValue{
                    item = self.arrSortedArray?[Int(newValue)]
                    let index:String = (item?["index"] as? String ?? "")
                    self.setBackGroundColorRoundView(index:index )
                    //self.headerView.lblSystemName.text = (item?["name"] as? String ?? "")
                    //self.headerView.lblSystemScore.text = (item?["score"] as? String ?? "")
                    self.strSelectedAcuityId = (item?["id"] as? String ?? "")
                }
            }else{
                if self.arrBodySystems.count>newValue{
                    item = self.arrBodySystems[Int(newValue)]
                    let index:String = (item?["index"] as? String ?? "")
                    
                    //change background color with system selection..
                    self.setBackGroundColorRoundView(index:index )
                    
                    //change text in header view..
                    //self.headerView.lblSystemName.text = (item?["name"] as? String ?? "")
                    //self.headerView.lblSystemScore.text = (item?["score"] as? String ?? "")
                    //selection of id
                    self.strSelectedAcuityId = (item?["id"] as? String ?? "")
                    
                }
            }
            
            if (item != nil){
                
                //set selected system data..
                //IT's from PullViewController..When user change system in didSet it will change data...
                self.systemData = item
            }
            
        }
    }
    
    func arrayIndexFromBodySystem(bodyStystem:[[String:Any]],andAcuityId acuityId:String) -> Int{
        for i in 0..<bodyStystem.count {
            let item = bodyStystem[i]
            if acuityId==item["id"] as? String{
                return i
            }
        }
        return 0;
    }
    
    //MARK: Return sorted data array...
    func returnSortedArrayUsingIndexandSequence(bodySystemArray:[[String:Any]]) -> [[String:Any]] {
        var redColorElememnts : [[String:Any]] = []
        var yellowColorElememnts : [[String:Any]] = []
        var greenColorElememnts : [[String:Any]] = []
        
        for item in bodySystemArray{
            let indexValue = Int(item["index"] as! String) ?? 0
            if indexValue  > 0 && indexValue <= 75{
                redColorElememnts.append(item)
            }else if indexValue  > 75 && indexValue <= 85{
                yellowColorElememnts.append(item)
            }else{
                greenColorElememnts.append(item)
            }
        }
        var finalArray: [[String:Any]] = []
        finalArray.append(contentsOf: redColorElememnts)
        finalArray.append(contentsOf: yellowColorElememnts)
        finalArray.append(contentsOf: greenColorElememnts)
        return finalArray
    }
    
    
    //MARK: Default system data...
    
    func setupBodySystemData() {
        arrBodySystems = []
        
        let metricCardio = [["Chest Pain":"Not Present"],["Hypertension":"No"],["Blood Oxygen Level":"98%"],["S Blood Pressure":"133"],["D Blood Pressure":"84"],["Heart Rate":"85"]]
        
        let dictCardiovascular =   AcuityDisplayModel()
        dictCardiovascular.id = "0"
        dictCardiovascular.name = "Cardiovascular"
        dictCardiovascular.score = String(format: "%.2f", (CardioManager.sharedManager.cardioData.cardioWeightedSystemScore))
        dictCardiovascular.index = "89"
        dictCardiovascular.image = AcuityImages.kCardiovascular
        dictCardiovascular.metricCardio = metricCardio
        
        let dictRespiratory =   AcuityDisplayModel()
        dictRespiratory.id = "15"
        dictRespiratory.name = "Respiratory"
        dictRespiratory.score = String(format: "%.2f", (RespiratoryManager.sharedManager.respiratoryData.respiratoryWeightedSystemScore))
        dictRespiratory.index = "23"
        dictRespiratory.image = AcuityImages.kRespiratory
        dictRespiratory.metricCardio = metricCardio
        
        
        let dictGastrointestinal =   AcuityDisplayModel()
        dictGastrointestinal.id = "45"
        dictGastrointestinal.name = "Gastrointestinal"
        dictGastrointestinal.score = "+84"
        dictGastrointestinal.index = "38"
        dictGastrointestinal.image = AcuityImages.kGastrointestinal
        dictGastrointestinal.metricCardio = metricCardio

        let dictGenitourinary =   AcuityDisplayModel()
        dictGenitourinary.id = "32"
        dictGenitourinary.name = "Genitourinary"
        dictGenitourinary.score = "-29"
        dictGenitourinary.index = "98"
        dictGenitourinary.image = AcuityImages.kGenitourinary
        dictGenitourinary.metricCardio = metricCardio

        let dictEndocrine =   AcuityDisplayModel()
        dictEndocrine.id = "46"
        dictEndocrine.name = "Endocrine"
        dictEndocrine.score = "+89"
        dictEndocrine.index = "90"
        dictEndocrine.image = AcuityImages.kEndocrine
        dictEndocrine.metricCardio = metricCardio

        let dictNuerological =   AcuityDisplayModel()
        dictNuerological.id = "78"
        dictNuerological.name = "Nuerological"
        dictNuerological.score = "-56"
        dictNuerological.index = "82"
        dictNuerological.image = AcuityImages.kNuerological
        dictNuerological.metricCardio = metricCardio

        let dictHaematology =   AcuityDisplayModel()
        dictHaematology.id = "36"
        dictHaematology.name = "Haematology"
        dictHaematology.score = "+46"
        dictHaematology.index = "91"
        dictHaematology.image = AcuityImages.kHematology
        dictHaematology.metricCardio = metricCardio

      
        let dictMusculatory =   AcuityDisplayModel()
        dictMusculatory.id = "23"
        dictMusculatory.name = "Musculatory"
        dictMusculatory.score = "-17"
        dictMusculatory.index = "68"
        dictMusculatory.image = AcuityImages.kMusculatory
        dictMusculatory.metricCardio = metricCardio
        
       
        let dictIntegumentary =   AcuityDisplayModel()
        dictIntegumentary.id = "89"
        dictIntegumentary.name = "Integumentary"
        dictIntegumentary.score = "-90"
        dictIntegumentary.index = "92"
        dictIntegumentary.image = AcuityImages.kIntegumentary
        dictIntegumentary.metricCardio = metricCardio
        
        let dictFluids =   AcuityDisplayModel()
        dictFluids.id = "432"
        dictFluids.name = "Fluids"
        dictFluids.score = "-20"
        dictFluids.index = "74"
        dictFluids.image = AcuityImages.kFluids
        dictFluids.metricCardio = metricCardio
        
        let dictInfectious =   AcuityDisplayModel()
        dictInfectious.id = "98"
        dictInfectious.name = "Infectious Disease"
        dictInfectious.score = "+64"
        dictInfectious.index = "98"
        dictInfectious.image = AcuityImages.kIDs
        dictInfectious.metricCardio = metricCardio
        
        let dictDisposition =   AcuityDisplayModel()
        dictDisposition.id = "248"
        dictDisposition.name = "Disposition Information"
        dictDisposition.score = "+40"
        dictDisposition.index = "84"
        dictDisposition.image = AcuityImages.kDisposition
        dictDisposition.metricCardio = metricCardio
        
        let dictHeent =   AcuityDisplayModel()
        dictHeent.id = "111"
        dictHeent.name = "Heent"
        dictHeent.score = "+20"
        dictHeent.index = "78"
        dictHeent.image = AcuityImages.kHeent
        dictHeent.metricCardio = metricCardio
        
     
        
        self.arrBodySystems.append(dictCardiovascular.dictionaryRepresentation())
        self.arrBodySystems.append(dictGastrointestinal.dictionaryRepresentation())
        self.arrBodySystems.append(dictGenitourinary.dictionaryRepresentation())
        self.arrBodySystems.append(dictEndocrine.dictionaryRepresentation())
        self.arrBodySystems.append(dictNuerological.dictionaryRepresentation())
        
        self.arrBodySystems.append(dictHaematology.dictionaryRepresentation())
        self.arrBodySystems.append(dictHeent.dictionaryRepresentation())
        self.arrBodySystems.append(dictDisposition.dictionaryRepresentation())
        self.arrBodySystems.append(dictInfectious.dictionaryRepresentation())
        self.arrBodySystems.append(dictFluids.dictionaryRepresentation())
        
        self.arrBodySystems.append(dictIntegumentary.dictionaryRepresentation())
        self.arrBodySystems.append(dictMusculatory.dictionaryRepresentation())
        self.arrBodySystems.append(dictRespiratory.dictionaryRepresentation())
        
    }
    
}
