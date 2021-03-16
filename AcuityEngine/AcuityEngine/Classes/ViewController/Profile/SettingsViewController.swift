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
    }
    
    func setFontForLabel(){
        lblNotification.font = Fonts.kCellTitleFont
    }
    
    //MARK:
    @IBAction func switchChanged(){
        
    }
    
}

