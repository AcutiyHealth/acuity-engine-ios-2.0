//
//  SymptomsListViewController.swift
//  AcuityEngine
//
//  Created by Bhoomi Jagani on 05/03/21.
//

import UIKit


typealias CompletionaddSymptomsViewOpen = (_ open: Bool?) -> Void

class SymptomsListViewController: UIViewController {
    
    @IBOutlet weak var tblSymptoms: UITableView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var symptomView: UIView!
    var arrayOfStringsSymptom: [SymptomsName] = []
    var symptomArray : [Symptoms] = []
    var addSymptomsVC : AddSymptomViewController?
    var handler: CompletionaddSymptomsViewOpen?
    
    
    @IBOutlet weak var btnClose: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set title
        setFontForLabel()
        //Load Symptoms from File
        loadSymptomsData()
        //
        tblSymptoms.reloadData()
        // Do any additional setup after loading the view.
    }
    func  setFontForLabel() {
        self.lblTitle.font = Fonts.kCellTitleFontListInAddSection
    }
    func setHandler(handler: @escaping CompletionaddSymptomsViewOpen){
        self.handler = handler
    }
    
    func loadSymptomsData(){
        
        do {
            // Fetch data from Txt file and convert it in array to display in tableview
            /* if let path = Bundle.main.path(forResource: "Symptoms", ofType: "txt"){
             let data = try String(contentsOfFile:path, encoding: String.Encoding.utf8)
             arrayOfStringsSymptom = data.components(separatedBy: "\n")*/
            
            arrayOfStringsSymptom = getSymptomsArray()
            //Log.d(arrayOfStringsSymptom)
        }
        
        for item in arrayOfStringsSymptom{
            let Symptom = Symptoms(title: item)
            symptomArray.append(Symptom)
        }
        //Log.d(symptomArray)
    }
}
extension SymptomsListViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return symptomArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: LabelInListAddSectionCell = tableView.dequeueReusableCell(withIdentifier: "LabelInListAddSectionCell", for: indexPath as IndexPath) as? LabelInListAddSectionCell else {
            fatalError("LabelInListAddSectionCell cell is not found")
        }
        let symptomsData = symptomArray[indexPath.row]
        cell.displayData(title: symptomsData.title?.rawValue ?? "")
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        openAddSymptomsViewController(index: indexPath.row)
    }
    
    func openAddSymptomsViewController(index:Int){
        
        //Add detail value view as child view
        addSymptomsVC = UIStoryboard(name: Storyboard.add.rawValue, bundle: nil).instantiateViewController(withIdentifier: "AddSymptomViewController") as? AddSymptomViewController
        self.addChild(addSymptomsVC!)
        addSymptomsVC?.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        
        //Show animation when view added.....
        animationForDetailViewWhenAdded(subviewToAdd: (addSymptomsVC?.view)!, in: self.view)
        
        addSymptomsVC?.view.setNeedsDisplay()
        addSymptomsVC?.didMove(toParent: self)
        addSymptomsVC?.view.tag = 111
        
        //Pass selected Symptoms to AddSymptomViewController
        let symptomsData = symptomArray[index]
        addSymptomsVC?.symptomsModel = symptomsData
        //setUpCloseButton(frame:btnFrame , btnImage:btnImage , btnTintColor:btnTintColor! )
        //Hide main view of Detail Pullup class
        
        symptomView.isHidden = true
        
        
        if let handler = handler{
            handler(true)
        }
    }
    func removeAddSymptomsViewController(){
        //Show animation when view removed from superview.......
        animationForDetailViewWhenRemoved(from: self.view)
        
        //
        if addSymptomsVC != nil{
            symptomView.isHidden = false
            addSymptomsVC?.view.removeFromSuperview()
            addSymptomsVC?.removeFromParent()
        }
        if let parentVC = self.parent {
            if let parentVC = parentVC as? AddOptionSelectionViewController {
                // parentVC is someViewController
                parentVC.removeBackButton()
            }
        }
    }
}




