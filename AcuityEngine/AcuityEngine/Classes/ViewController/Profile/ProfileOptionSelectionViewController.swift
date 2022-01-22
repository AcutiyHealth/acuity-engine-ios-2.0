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
    @IBOutlet weak var handleArea: HandleView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var btnLogOut: UIButton!
    @IBOutlet weak var visualEffectView: UIView!
    
    //Close button for Acuity detail value...
    var btnClose:UIButton?
    
    //Object of Profilevalue viewcontroller...
    var profileVC : ProfileViewController?
    var termsVC : TermsOfServiceViewController?
    var settingVC : SettingsViewController?
    
    var fullName = ""
    
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
        
        let firstName = getFromKeyChain(key: Key.kAppleFirstName)
        let lastName = getFromKeyChain(key: Key.kAppleLastName)
        let userId = getFromKeyChain(key: Key.kAppleUserID)
        let isLoggedIn = Utility.fetchObject(forKey: Key.kIsLoggedIn)
        btnLogOut.isHidden = true
        if (isLoggedIn != nil) == true && userId != ""{
            //profileOptionArray.append(ProfileOption.logOut.rawValue)
            btnLogOut.isHidden = false
        }
        fullName = (firstName + " " + lastName).trimmingCharacters(in: .whitespaces)
        // Set Font For Button
        setFontForButtonsAndLabel()
        profileOptionTableView.reloadData()
        
    }
    //========================================================================================================
    //MARK: Set Font For Button
    //========================================================================================================
    func setFontForButtonsAndLabel(){
        btnLogOut.titleLabel?.font = Fonts.kCellTitleFont
    }
    //========================================================================================================
    //MARK: Log Out
    //========================================================================================================
    @IBAction func btnLogOutClicked(_ sender: Any){
        do{
            Utility.setBoolForKey(false, key: Key.kIsLoggedIn)
            //kIsSymptomseminder
            var notificationModel = NotificationModel(identifier: Key.kIsSymptomseminder)
            NotificationManager.shared.removeScheduledNotification(model: notificationModel)
            //kIsTerminatereminder
            notificationModel = NotificationModel(identifier: Key.kIsTerminatereminder)
            NotificationManager.shared.removeScheduledNotification(model: notificationModel)
            NotificationCenter.default.post(name: Notification.Name(NSNotificationName.logOutFromApp.rawValue), object: nil)
        }
    }
    
}
// MARK: - SOPullUpViewDelegate

extension ProfileOptionSelectionViewController: SOPullUpViewDelegate {
    func pullUpViewStatus(_ sender: UIViewController, didChangeTo status: PullUpStatus) {
        switch status {
        case .collapsed:
            UIView.animate(withDuration: pullUpViewFadeAnimationTimeAtCollapse) {
                self.view.alpha = 0.4
            }
            NotificationCenter.default.post(name: Notification.Name(NSNotificationName.pullUpClose.rawValue), object: nil)
            NotificationCenter.default.post(name:Notification.Name(NSNotificationName.showAcuityDetailPopup.rawValue), object: nil)
            
        case .expanded: break
        default:break
        }
    }
    
    func pullUpHandleArea(_ sender: UIViewController) -> UIView {
        return handleArea
    }
}

// MARK: - UITableViewDelegate , UITableViewDataSource

extension ProfileOptionSelectionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if fullName != ""{
            return profileOptionArray.count + 1
        }else{
            return profileOptionArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0  && fullName != ""{
            let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "ProfileDisplayCell", for: indexPath as IndexPath)
            let profileImage = cell.viewWithTag(1) as? UIImageView
            let nameLabel = cell.viewWithTag(2) as? UILabel
            nameLabel?.text = fullName
            nameLabel?.font = Fonts.kCellTitleFont
            cell.selectionStyle = .none
            
            return cell
        }
        else{
            guard let cell: LabelDisplayCell = tableView.dequeueReusableCell(withIdentifier: "LabelDisplayCell", for: indexPath as IndexPath) as? LabelDisplayCell else {
                fatalError("AcuityDetailDisplayCell cell is not found")
            }
            var index = indexPath.row
            if fullName != ""{
                index = indexPath.row-1
            }
            cell.titleLabel?.text = profileOptionArray[index]
            
            cell.selectionStyle = .none
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0  && fullName != ""{
            let cellHeight = getRowHeightAsPerDeviceSize(height:100)
            return cellHeight > 108 ? 108 : cellHeight
        }else{
            return 50
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var index = indexPath.row
        if fullName != ""{
            index = indexPath.row-1
        }
        switch ProfileOption(rawValue: profileOptionArray[index]){
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
        case .logOut:
            do{
                
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
        setupBackButton()
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
        setupBackButton()
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
        setupBackButton()
        //Hide main view of Detail Pullup class
        mainView.isHidden = true
        
        visualEffectView.bringSubviewToFront(handleArea)
    }
    func setupBackButton(){
        handleArea.btnBack!.isHidden = false
        handleArea.btnBack!.addTarget(self, action: #selector(btnCloseClickedInProfileViewController), for: UIControl.Event.touchUpInside)
    }
    /*func setUpCloseButton(){
        //Add close button target
        
        
        btnClose = CloseButton()
        let rect = (btnClose!.frame)
        let originX = Double(handleArea.frame.size.width - (rect.size.width)-20)
        let originY = Double(handleArea.frame.size.height - (rect.size.height))/2
        
        btnClose!.frame = CGRect(origin: CGPoint(x: originX, y: originY), size: rect.size)
        
        btnClose!.addTarget(self, action: #selector(btnCloseClickedInProfileViewController), for: UIControl.Event.touchUpInside)
        
        handleArea.addSubview(btnClose!)
        
    }*/
    func setUpCloseButton(){
        handleArea.btnClose!.isHidden = false
        handleArea.btnClose!.addTarget(self, action: #selector(btnCloseClickedInProfileViewController), for: UIControl.Event.touchUpInside)
        
    }
    func removeBackButton(){
        handleArea.btnBack!.isHidden = true
    }
    func removeCloseButton(){
        handleArea.btnClose!.isHidden = true
    }
    //MARK: Btn close click
    @objc func btnCloseClickedInProfileViewController(){
        //Show animation when view is removed.....
        animationForDetailViewWhenRemoved(from: self.visualEffectView)
        removeBackButton()
        removeCloseButton()
        //btnClose?.removeFromSuperview()
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
