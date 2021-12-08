//
//  DemoHeaderView.swift
//  CustomHeaderDemo
//
//  Created by Macintosh HD on 11/24/17.
//  Copyright © 2017 iOS-Tutorial. All rights reserved.
//

import UIKit
extension UITableViewCell {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}
class ProfileAddOptionsDataCell: UITableViewCell,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var tblData: UITableView!
    @IBOutlet weak var heightConstraintFortblDataView: NSLayoutConstraint!
    
    var arrayOfData: [String] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewBg.backgroundColor = ColorSchema.fourBoxColorInPullup
        lblTitle.font = Fonts.kCellProfileDetailTitleFont
        setupViewBorderForAddSection(view: viewBg)
        //self.tblData.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
        
    }
    //========================================================================================================
    //MARK:deinit..
    //========================================================================================================
    deinit {
        //self.tblData.removeObserver(self, forKeyPath: "contentSize")
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let parentViewController = self.parentViewController {
            //            let deviceWiseConstant = 12.0 + (Float(Screen.iPhoneSEHeight)/Float(parentViewController.view.frame.size.height))
            //            print("deviceWiseConstant",deviceWiseConstant)
            //            let minus:CGFloat =  (CGFloat(arrayOfData.count)*CGFloat(deviceWiseConstant))
            tblData.layer.removeAllAnimations()
            heightConstraintFortblDataView.constant = tblData.contentSize.height
            UIView.animate(withDuration: 0.5) {
                
                parentViewController.updateViewConstraints()
            }
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: LabelDisplayCell = tableView.dequeueReusableCell(withIdentifier: "LabelDisplayCell", for: indexPath as IndexPath) as? LabelDisplayCell else {
            fatalError("AcuityDetailDisplayCell cell is not found")
        }
        
        let metrixItem = arrayOfData[indexPath.row]
        cell.titleLabel.text = metrixItem
        //cell.titleLabel.numberOfLines = 0;
        cell.setFontForLabel(font:Fonts.kCellProfileDetailFont)
        cell.selectionStyle = .none
        //cell.backgroundColor = UIColor.red
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        //return getRowHeightAsPerDeviceSize(height:30)
        return UITableView.automaticDimension
    }
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
