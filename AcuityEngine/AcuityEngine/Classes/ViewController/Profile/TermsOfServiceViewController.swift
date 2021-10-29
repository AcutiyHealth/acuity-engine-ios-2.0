//
//  TermsOfServiceViewController.swift
//  AcuityEngine
//
//  Created by Bhoomi Jagani on 03/03/21.
//

import Foundation


class TermsOfServiceViewController: UIViewController {
    
    // MARK: - Outlet
    @IBOutlet weak var switchNotification: UISwitch!
    @IBOutlet weak var txtView: UITextView!
    @IBOutlet weak var btnClose: UIButton!
   
    // MARK: - Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        setFontForLabel()
    }
    
    func setFontForLabel(){
        txtView.font = Fonts.kTermsNConditionFont
    }
    
    //MARK:
    @IBAction func switchChanged(){
        
    }
    
}

