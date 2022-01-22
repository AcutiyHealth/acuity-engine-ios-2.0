//
//  PullUpController.swift
//  PullUpController
//
//  Created by Ahmad Sofi on 12/4/19.
//

import UIKit
extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
public let pullUpAnimationTime:Double = 0.8
public let pullUpViewFadeAnimationTimeAtCollapse:Double = 0.4
@available(iOS 10.0, *)

public class SOPullUpControl {
    
    public init() {}
    public weak var dataSource : SOPullUpViewDataSource?
    public weak var delegate: SOPullUpViewDelegate?
    
    // Variable determines the next state of the card expressing that the card starts and collapased
    var nextState: PullUpStatus {
        if cardVisible{
            return .collapsed //Card is expanded, so make it collapse
        }else if cardHalfOpened{
            return .collapsed // (if you want to make collapse->half open->expanded....expanded...)Here I need .collapse->half, half open->collapse
        }else{
            return .halfOpened //Card is collapse, so make it half open
        }
        
    }
    
    // Variable determines the height of main view
    var heightView: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    var defaultpullUpViewHeight: CGFloat {
        return UIScreen.main.bounds.height * 0.7
    }
    
    // Variable determines the width of main view
    var widthView: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    // Variable for card view controller
    public var pullUpVC: UIViewController!
    
    // Variable for effects visual effect view
    var visualEffectView:UIVisualEffectView!
    
    // Starting and end card heights will be determined later
    var endCardHeight:CGFloat = 0.0
    var halfOpenedCardHeight:CGFloat = 0.0
    var startCardHeight:CGFloat = 0.0
    
    // Current visible state of the card
    var cardVisible = false
    // Current visible state of the card
    public var cardHalfOpened = false
    
    // Empty property animator array
    var runningAnimations = [UIViewPropertyAnimator]()
    var animationProgressWhenInterrupted:CGFloat = 0
    
    let pullUpViewTag = -1996
    // main view
    var parentView: UIView?
    public var isExpanded: Bool = false
    public var isHalfOpened: Bool = false
    public func setupCard(from view: UIView) {
        
        endCardHeight   = (dataSource?.pullUpViewExpandedViewHeight?()) ?? defaultpullUpViewHeight
        startCardHeight = dataSource?.pullUpViewCollapsedViewHeight() ?? 0.0
        halfOpenedCardHeight = dataSource?.pullUpViewHalfOpenedViewHeight() ?? 0.0
        
        parentView = view
        // Add Visual Effects View
        //visualEffectView = UIVisualEffectView()
        
        // Add CardViewController xib to the bottom of the screen, clipping bounds so that the corners can be rounded
        guard let safePullUpViewController = dataSource?.pullUpViewController() else {return}
        pullUpVC = safePullUpViewController
        pullUpVC.view.tag = pullUpViewTag
        
        view.addSubview(pullUpVC.view)
    
        pullUpVC.view.frame = CGRect(x: 0, y: heightView - startCardHeight, width: widthView, height: endCardHeight)
        pullUpVC.view.clipsToBounds = true
        pullUpVC.view.roundCorners(corners: [.topLeft, .topRight], radius: 25)
     
        // Add tap and pan recognizers
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleCardTap(recognzier:)))
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handleCardPan(recognizer:)))
        
        let handleArea = delegate?.pullUpHandleArea(pullUpVC)
        handleArea?.addGestureRecognizer(tapGestureRecognizer)
        handleArea?.addGestureRecognizer(panGestureRecognizer)
        
    }
    
    public func setupCardWithAnimation(from view: UIView) {
        
        self.setupCard(from: view)
        animation()
    }
    // used to hide the pullUpView from parentView
    public func hide() {
        parentView?.subviews.forEach { (subView) in
            if subView.tag == self.pullUpViewTag {
                    subView.isHidden = true
            }
        }
    }
    // used to hide the pullUpView from parentView
    public func animation() {
        pullUpVC.view.alpha = 0.0
        UIView.animate(withDuration: pullUpAnimationTime-0.3) { [weak self] in
            self?.pullUpVC.view.alpha = 1.0
        }
    }
    // used to show the pullUpView from parentView
    public func show() {
        parentView?.subviews.forEach { (subView) in
            if subView.tag == self.pullUpViewTag {
                    subView.isHidden = true
            }
        }
    }
    public func tapOnHandle(){
        let tapGestureRecognizer = UITapGestureRecognizer()
        self.handleCardTap(recognzier: tapGestureRecognizer)
    }
     // used to change the status of pullUpView to expanded
    public func expanded() {
        isExpanded = true
        isHalfOpened = false
        animateTransitionIfNeeded(state: .expanded, duration: pullUpAnimationTime)
    }
    
    // used to change the status of pullUpView to half opened
    public func collapsed() {
        isExpanded = false
        isHalfOpened = false
        animateTransitionIfNeeded(state: .collapsed, duration: pullUpAnimationTime)
    }
    // used to change the status of pullUpView to collapsed
    public func halfOpened() {
        isExpanded = false
        isHalfOpened = true
        self.cardHalfOpened = false
        self.cardVisible = false
        animateTransitionIfNeeded(state: .halfOpened, duration: pullUpAnimationTime)
    }
}
