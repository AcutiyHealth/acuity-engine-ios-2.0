//
//  Header.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 23/02/21.
//

import Foundation
import UIKit
import UIKit

protocol HeaderDelegate {
    func btnAddClickedCallBack()
    func btnProfileClickedCallBack()
}

class Header: UIView {
    
    // Our custom view from the XIB file
    var view: UIView!
    var delegate:HeaderDelegate?
    // Outlets
    @IBOutlet weak var lblMyWell: UILabel!
    @IBOutlet weak var lblSystemName: UILabel!
    @IBOutlet weak var lblSystemScore: UILabel!
    @IBOutlet weak var containerViewMain: UIView!
    @IBOutlet weak var ContainverViewSub: UIView!
    @IBOutlet weak var centerMyWellConstraint:NSLayoutConstraint!
    
    override init(frame: CGRect) {
        // 1. setup any properties here
        
        // 2. call super.init(frame:)
        super.init(frame: frame)
        
        // 3. Setup view from .xib file
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        // 1. setup any properties here
        
        // 2. call super.init(coder:)
        super.init(coder: aDecoder)
        
        // 3. Setup view from .xib file
        xibSetup()
        //        self.view = loadViewFromNib() as! CustomView
    }
    
    func xibSetup() {
        view = loadViewFromNib()
        
        // use bounds not frame or it'll be offset
        view.frame = bounds
        
        // Make the view stretch with containing view
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of:self))
        let nib = UINib(nibName: "Header", bundle: bundle)
        
        // Assumes UIView is top level and only object in CustomView.xib file
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
    @IBAction func btnAddClicked(sender:UIButton){
        delegate?.btnAddClickedCallBack()
    }
    
    @IBAction func btnProfileClicked(sender:UIButton){
        delegate?.btnProfileClickedCallBack()
    }
    /*
     // Only override drawRect: if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func drawRect(rect: CGRect) {
     
     // If you add custom drawing, it'll be behind any view loaded from XIB
     
     
     }
     */
    
}

