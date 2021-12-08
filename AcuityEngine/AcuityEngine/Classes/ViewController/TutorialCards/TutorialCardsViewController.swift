//
//  TutorialCardsVC.swift
//  AcuityEngine
//
//  Created by Bhoomi Jagani on 31/10/21.
//

import Foundation
import UIKit

class TutorialCardsViewController:UIViewController,UIScrollViewDelegate{
    
    // MARK: - Controller Life Cycle
    //View1..
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var imgView1: UIImageView!
    @IBOutlet weak var labelTitleV1: UILabel!
    @IBOutlet weak var labelDescV1: UILabel!
    //View2..
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var imgView2: UIImageView!
    @IBOutlet weak var labelTitleV2: UILabel!
    @IBOutlet weak var labelDescV2: UILabel!
    //View3..
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var imgView3: UIImageView!
    @IBOutlet weak var labelTitleV3: UILabel!
    @IBOutlet weak var labelDescV3: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!{
        didSet{
            scrollView.delegate = self
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //view1.removeAllConstraints()
        //view2.removeAllConstraints()
        //view3.removeAllConstraints()
        //setupSlideScrollView(slideCount: 3)
    }
    
    //========================================================================================================
    //MARK: First Next Button..
    //========================================================================================================
    @IBAction func btnFirstNextClicked(_ sender: Any) {
        scrollView.setContentOffset(CGPoint(x: scrollView.frame.size.width*1, y: 0), animated: true)
    }
    //========================================================================================================
    //MARK: Second Next Button..
    //========================================================================================================
    @IBAction func btnSecondNextClicked(_ sender: Any) {
        scrollView.setContentOffset(CGPoint(x: scrollView.frame.size.width*2, y: 0), animated: true)
    }
    //========================================================================================================
    //MARK: Skip Button..
    //========================================================================================================
    @IBAction func btnSKipOrDoneClicked(_ sender: Any) {
            Utility.setBoolForKey(true, key: Key.kIsTutorialCardShown)
        let isLoggedIn = Utility.fetchObject(forKey: Key.kIsLoggedIn)
         if isLoggedIn == nil || (isLoggedIn != nil) == false{
             AppDelegate.shared.moveToLoginScreen()
        }
        else{
            AppDelegate.shared.checkIfAppleUserIsStored()
        }
    }
    
    func setupSlideScrollView(slideCount:Int) {
        //scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slideCount), height: scrollView.frame.height)
        scrollView.isPagingEnabled = true
        
        for i in 0 ..< slideCount {
            switch i{
            case 0:
                view1.frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
                imgView1.frame = view1.frame
                scrollView.addSubview(view1)
                break
            case 1:
                view2.frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
                imgView2.frame = view2.frame
                scrollView.addSubview(view2)
                break
            case 2:
                view3.frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
                imgView3.frame = view3.frame
                scrollView.addSubview(view3)
                break
            default: break
            }
           
        }
    }
}
