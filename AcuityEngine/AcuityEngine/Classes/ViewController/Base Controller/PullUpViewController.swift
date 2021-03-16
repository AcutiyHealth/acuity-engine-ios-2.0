//
//  PullUpViewController+Extensions.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 23/02/21.
//

import Foundation

import UIKit
import SOPullUpView

enum PullUpType {
    case Detail
    case Profie
    case Add
}


class PullUpViewController: UIViewController {
    
    
    // MARK: - Properties
    var selectPullUpType:PullUpType = .Detail
    var pullUpController = SOPullUpControl()
    var expandedViewHeight = Screen.screenHeight
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
        
        reloadCardView()
    }
    
    //Remove view from it's super and add it again
    func reloadCardView(){
        hide()
        
        pullUpController.dataSource = self
        pullUpController.setupCard(from: self.view)
     
        
    }
    //remove current view from it's super view
    func hide() {
        self.view.subviews.forEach { (subView) in
            if subView.tag == -1996{
                subView.removeFromSuperview()
            }
        }
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
        let vc = UIViewController()
        switch selectPullUpType {
        case .Detail:
            do {
                if  (self.pullUpController.pullUpVC != nil),self.pullUpController.pullUpVC.isKind(of: AcuityDetailPullUpViewController.self){
                    self.pullUpController.pullUpVC.viewDidLoad()
                    return self.pullUpController.pullUpVC!
                }else{
                    guard let detailVC = UIStoryboard(name: Storyboard.acuityDetailPullUp.rawValue, bundle: nil).instantiateViewController(withIdentifier: "AcuityDetailPullUpViewController")  as? AcuityDetailPullUpViewController else {return vc}
                    detailVC.pullUpControl = self.pullUpController
                    return detailVC
                }
            }
        case .Profie:
            do{
               
                if  (self.pullUpController.pullUpVC != nil),self.pullUpController.pullUpVC.isKind(of: ProfileOptionSelectionViewController.self){
                   
                    return self.pullUpController.pullUpVC
                }else{
                    guard let profileVC = UIStoryboard(name: Storyboard.profile.rawValue, bundle: nil).instantiateViewController(withIdentifier: "ProfileOptionSelectionViewController") as? ProfileOptionSelectionViewController else {return vc}
                    profileVC.pullUpControl = self.pullUpController
                    
                    return profileVC
                }
            }
        case .Add:
            do{
                if  (self.pullUpController.pullUpVC != nil),self.pullUpController.pullUpVC.isKind(of: AddOptionSelectionViewController.self){
                    return self.pullUpController.pullUpVC
                }else{
                    guard let addVC = UIStoryboard(name: Storyboard.add.rawValue, bundle: nil).instantiateInitialViewController() as? AddOptionSelectionViewController else {return vc}
                    addVC.pullUpControl = self.pullUpController
                    return addVC
                }
            }
        }
        
    }
    
    func pullUpViewExpandedViewHeight() -> CGFloat {
        return expandedViewHeight
    }
}
