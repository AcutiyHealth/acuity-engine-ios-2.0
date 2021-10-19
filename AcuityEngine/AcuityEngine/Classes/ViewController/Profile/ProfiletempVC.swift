//
//  ProfiletempVC.swift
//  AcuityEngine
//
//  Created by Bhoomi Jagani on 15/10/21.
//

import Foundation

class ProfiletempVC: UIViewController {
    @IBOutlet weak var tblHistoryOrMedicationData: UITableView!
    @IBOutlet weak var scrollcontentView: UIView!
    @IBOutlet weak var heightConstraintFortblHistoryOrMedicationDataView: NSLayoutConstraint!
    let arrayOfData = ["test","test","test","test","test","test","test","test","test","test",]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Read Basic Charactristic from Health Kit.....
        tblHistoryOrMedicationData.isScrollEnabled  = false
        self.tblHistoryOrMedicationData.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
       
    }
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        tblHistoryOrMedicationData.layer.removeAllAnimations()
        heightConstraintFortblHistoryOrMedicationDataView.constant = tblHistoryOrMedicationData.contentSize.height
//         UIView.animate(withDuration: 0.5) {
//
//                self.updateViewConstraints()
//            self.view.layoutIfNeeded()
//
//        }
        
    }
}
// MARK: - UITableViewDelegate , UITableViewDataSource

extension ProfiletempVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return arrayOfData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: LabelDisplayCell = tableView.dequeueReusableCell(withIdentifier: "LabelDisplayCell", for: indexPath as IndexPath) as? LabelDisplayCell else {
            fatalError("AcuityDetailDisplayCell cell is not found")
        }
       
                let metrixItem = arrayOfData[indexPath.row]
        cell.titleLabel.text = metrixItem
        cell.setFontForLabel(font:Fonts.kAcuityDetailCellFont)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        //return getRowHeightAsPerDeviceSize(height:30)
        return UITableView.automaticDimension
    }
}
