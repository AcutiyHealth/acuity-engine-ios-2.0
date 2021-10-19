//
//  ProfileOptionSelectionViewController.swift
//  AcuityEngine
//
//  Created by Bhoomi Jagani on 03/03/21.
//

import Foundation
import UIKit
import SOPullUpView

class ProfileOptionSelectionViewController:UIViewController{
    
    // MARK: - Outlet
    @IBOutlet weak var profileOptionTableView: UITableView!
    @IBOutlet weak var handleArea: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var visualEffectView: UIView!
    
    //Close button for Acuity detail value...
    var btnClose:UIButton?
    
    //Object of Profilevalue viewcontroller...
    var profileVC : ProfileViewController?
    var termsVC : TermsOfServiceViewController?
    var settingVC : SettingsViewController?
    
    
    var profileOptionArray: Array<String> = [ProfileOption.profile.rawValue,ProfileOption.settings.rawValue,ProfileOption.termsOfService.rawValue]
    //var labelsAsStringForMonth: Array<String> = ["Week1","Week2","Week3","Week4"]
    // MARK: - Properties
    
    var pullUpControl: SOPullUpControl? {
        didSet {
            pullUpControl?.delegate = self
        }
    }
    
    // MARK: - Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileOptionTableView.reloadData()
        
    }
    
    
    
}
// MARK: - SOPullUpViewDelegate

extension ProfileOptionSelectionViewController: SOPullUpViewDelegate {
    func pullUpViewStatus(_ sender: UIViewController, didChangeTo status: PullUpStatus) {
        switch status {
        case .collapsed:
            UIView.animate(withDuration: 0.9) {
                self.view.alpha = 0.2
            }
            NotificationCenter.default.post(name: Notification.Name("pullUpClose"), object: nil)
            NotificationCenter.default.post(name: Notification.Name("showAcuityDetailPopup"), object: nil)
            
        case .expanded: break
            
        }
    }
    
    func pullUpHandleArea(_ sender: UIViewController) -> UIView {
        return handleArea
    }
}

// MARK: - UITableViewDelegate , UITableViewDataSource

extension ProfileOptionSelectionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileOptionArray.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "ProfileDisplayCell", for: indexPath as IndexPath)
            let profileImage = cell.viewWithTag(1) as? UIImageView
            let nameLabel = cell.viewWithTag(2) as? UILabel
            nameLabel?.text = "Test Test"
            nameLabel?.font = Fonts.kCellTitleFont
            cell.selectionStyle = .none
            
            return cell
        }
        else{
            guard let cell: LabelDisplayCell = tableView.dequeueReusableCell(withIdentifier: "LabelDisplayCell", for: indexPath as IndexPath) as? LabelDisplayCell else {
                fatalError("AcuityDetailDisplayCell cell is not found")
            }
            
            cell.titleLabel?.text = profileOptionArray[indexPath.row-1]
            
            cell.selectionStyle = .none
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            let cellHeight = getRowHeightAsPerDeviceSize(height:100)
            return cellHeight > 108 ? 108 : cellHeight
        }else{
            return 50
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch ProfileOption(rawValue: profileOptionArray[indexPath.row-1]){
        case .profile:
            do{
                openProfileViewController()
            }
        case .settings:
            do{
                openSettingViewController()
            }
        case .termsOfService:
            do{
                openTermsNServiceViewController()
            }
            
            
        case .none:
            print("")
        }
    }
    
    //MARK: open value detail screen
    func openProfileViewController(){
        
        //Add detail value view as child view
        profileVC = UIStoryboard(name: Storyboard.profile.rawValue, bundle: nil).instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController
        self.addChild(profileVC!)
        
        //Show animation when view added.....
        animationForDetailViewWhenAdded(subviewToAdd: (profileVC?.view)!, in: self.visualEffectView)
        
        profileVC?.didMove(toParent: self)
        
        //Add close button target
        setUpCloseButton()
        //Hide main view of Detail Pullup class
        mainView.isHidden = true
        
        visualEffectView.bringSubviewToFront(handleArea)
    }
    
    //MARK: open settings screen
    func openSettingViewController(){
        
        //Add detail value view as child view
        settingVC = UIStoryboard(name: Storyboard.profile.rawValue, bundle: nil).instantiateViewController(withIdentifier: "SettingsViewController") as? SettingsViewController
        self.addChild(settingVC!)
        
        //Show animation when view added.....
        animationForDetailViewWhenAdded(subviewToAdd: (settingVC?.view)!, in: self.visualEffectView)
        
        settingVC?.didMove(toParent: self)
        //Add close button target
        setUpCloseButton()
        
        //Hide main view of Detail Pullup class
        mainView.isHidden = true
        
        visualEffectView.bringSubviewToFront(handleArea)
    }
    
    //MARK: open Terms screen
    func openTermsNServiceViewController(){
        
        //Add detail value view as child view
        termsVC = UIStoryboard(name: Storyboard.profile.rawValue, bundle: nil).instantiateViewController(withIdentifier: "TermsOfServiceViewController") as? TermsOfServiceViewController
        self.addChild(termsVC!)
        
        //Show animation when view added.....
        animationForDetailViewWhenAdded(subviewToAdd: (termsVC?.view)!, in: self.visualEffectView)
        
        termsVC?.didMove(toParent: self)
        
        //Add close button target
        setUpCloseButton()
        
        //Hide main view of Detail Pullup class
        mainView.isHidden = true
        
        visualEffectView.bringSubviewToFront(handleArea)
    }
    
    func setUpCloseButton(){
        //Add close button target
        
        
        btnClose = CloseButton()
        let rect = (btnClose!.frame)
        let originX = Double(handleArea.frame.size.width - (rect.size.width)-20)
        let originY = Double(handleArea.frame.size.height - (rect.size.height))/2
        
        btnClose!.frame = CGRect(origin: CGPoint(x: originX, y: originY), size: rect.size)
        
        btnClose!.addTarget(self, action: #selector(btnCloseClickedInProfileViewController), for: UIControl.Event.touchUpInside)
        
        handleArea.addSubview(btnClose!)
        
    }
    
    //MARK: Btn close click
    @objc func btnCloseClickedInProfileViewController(){
        //Show animation when view is removed.....
        animationForDetailViewWhenRemoved(from: self.visualEffectView)
        
        btnClose?.removeFromSuperview()
        if profileVC != nil{
            profileVC?.view.removeFromSuperview()
            profileVC?.removeFromParent()
        }
        if settingVC != nil{
            settingVC?.view.removeFromSuperview()
            settingVC?.removeFromParent()
        }
        if termsVC != nil{
            termsVC?.view.removeFromSuperview()
            termsVC?.removeFromParent()
        }
        
        mainView.isHidden = false
    }
}
