//
//  ProfileViewController.swift
//  AcuityEngine
//
//  Created by Bhoomi Jagani on 01/03/21.
//

import UIKit
import Foundation

class SettingsViewController: UIViewController {
    
    // MARK: - Outlet
    @IBOutlet weak var switchNotification: UISwitch!
    @IBOutlet weak var lblNotification: UILabel!
    @IBOutlet weak var btnClose: UIButton!
    
    // MARK: - Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        setFontForLabel()
        //Change switch status based on UserDefault key..
        if Utility.fetchObject(forKey: Key.kIsNotificationOnOff) != nil{
            switchNotification.isOn = Utility.fetchBool(forKey: Key.kIsNotificationOnOff)
        }
    }
    
    func setFontForLabel(){
        lblNotification.font = Fonts.kCellTitleFont
    }
    //========================================================================================================
    //MARK: switchChanged..
    //========================================================================================================
    @IBAction func switchChanged(){
        self.checkWhetherLocalNotificationOnFromSetting()
        //set userdefault data according to switch state.....
        Utility.setBoolForKey(switchNotification.isOn, key: Key.kIsNotificationOnOff)
        
        if !switchNotification.isOn{
            removePendingNotificationWhenSwitchOff()
        }
        if !AppDelegate.shared.isLocalNotificationGranted{
            //Show Alert For On From Settings....
            showAlertForNotificationIsOff()
        }
        
    }
    
    func showAlertForNotificationIsOff(){
        Utility.showAlertWithOKBtn(onViewController: self, title: AlertMessages.TITLE_ON_NOTIFICATION_SWITCH, message: AlertMessages.MSG_ON_NOTIFICATION_SWITCH)
    }
    
    func checkWhetherLocalNotificationOnFromSetting(){
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                DispatchQueue.main.async{
                    AppDelegate.shared.isLocalNotificationGranted = true
                }
                print("User gave permissions for local notifications")
            }
            else{
                self.switchNotification.isOn = false
            }
        }
    }
    //========================================================================================================
    //MARK: Remove Pending Notification When SwitchOff..
    //========================================================================================================
    func removePendingNotificationWhenSwitchOff(){
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [Key.kIsTerminatereminder])
        UNUserNotificationCenter.current().getPendingNotificationRequests(completionHandler: {requests -> () in
            print("\(requests.count) requests -------")
            for request in requests{
                print(request.identifier)
            }
        })
    }
}

