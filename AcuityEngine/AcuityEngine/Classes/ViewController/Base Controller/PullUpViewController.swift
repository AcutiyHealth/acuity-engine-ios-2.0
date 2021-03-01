//
//  PullUpViewController+Extensions.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 23/02/21.
//

import Foundation

import UIKit
import SOPullUpView


class PullUpViewController: UIViewController {
    
    
    // MARK: - Properties
    
    var pullUpController = SOPullUpControl()
     
    var systemData:[String:Any]?{
        didSet{
            self.setMetricDataInPullUp()
        }
    }
    // used to return bottom Padding of safe area.
    var bottomPadding: CGFloat {
        let window = UIApplication.shared.keyWindow
        return window?.safeAreaInsets.top ?? 0.0
    }
    
    // MARK: - Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pullUpController.dataSource = self
        pullUpController.setupCard(from: view)
 
    }
    
    func setMetricDataInPullUp(){
        
        if  pullUpController.pullUpVC.isKind(of: AcuityDetailPullUpViewController.self){
            let vc = pullUpController.pullUpVC as? AcuityDetailPullUpViewController
            vc?.systemData = systemData
        }
        
    }
}

// MARK: - SOPullUpViewDataSource

extension PullUpViewController: SOPullUpViewDataSource {
    
    func pullUpViewCollapsedViewHeight() -> CGFloat {
         return bottomPadding + ((200 * Screen.screenHeight)/896)
    }
     
    func pullUpViewController() -> UIViewController {
        guard let vc = UIStoryboard(name: Storyboard.acuityDetailPullUp.rawValue, bundle: nil).instantiateInitialViewController() as? AcuityDetailPullUpViewController else {return UIViewController()}
        vc.pullUpControl = self.pullUpController
        return vc
    }
    
    func pullUpViewExpandedViewHeight() -> CGFloat {
        return Screen.screenHeight - 100
    }
}
