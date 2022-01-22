//
//  PullUpController+Animation.swift
//  PullUpController
//
//  Created by Ahmad Sofi on 12/4/19.
//

import Foundation
@available(iOS 10.0, *)
extension SOPullUpControl {
    
    // Handle tap gesture recognizer
    @objc
    public func handleCardTap(recognzier:UITapGestureRecognizer) {
        switch recognzier.state {
            // Animate card when tap finishes
        case .ended:
            animateTransitionIfNeeded(state: nextState, duration: pullUpAnimationTime)
        default:
            break
        }
    }
    
    // Handle pan gesture recognizer
    @objc
    func handleCardPan (recognizer:UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            // Start animation if pan begins
            startInteractiveTransition(state: nextState, duration: pullUpAnimationTime)
        case .changed:
            let translation = recognizer.translation(in: self.pullUpVC.view)
            var fractionComplete = translation.y / endCardHeight
            if cardVisible{
                //fractionComplete = fractionComplete
            }else if cardHalfOpened==true{
                fractionComplete = fractionComplete/2
            }else{
                fractionComplete = -fractionComplete
            }
            //fractionComplete = cardVisible ? fractionComplete : -fractionComplete
            updateInteractiveTransition(fractionCompleted: fractionComplete)
        case .ended:
            // End animation when pan ends
            continueInteractiveTransition()
        default:
            break
        }
    }
    
    func animateTransitionIfNeeded (state:PullUpStatus, duration:TimeInterval) {
        // Check if frame animator is empty
        //self.visualEffectView.backgroundColor = UIColor.clear
        //pullUpVC.view.isUserInteractionEnabled = false
        //Below removeAll line is added newly....it wasn't before..
        self.runningAnimations.removeAll()
        if runningAnimations.isEmpty {
            
            // Create a UIViewPropertyAnimator depending on the state of the popover view
            let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state {
                case .expanded:
                    // If expanding set popover y to the ending height and blur background
                    self.pullUpVC.view.frame.origin.y = self.heightView - self.endCardHeight
                    //  self.visualEffectView.effect = UIBlurEffect(style: .extraLight)
                case .halfOpened:
                    // If expanding set popover y to the ending height and blur background
                    self.pullUpVC.view.frame.origin.y = self.heightView - self.halfOpenedCardHeight
                    //  self.visualEffectView.effect = UIBlurEffect(style: .extraLight)
                case .collapsed:
                    // If collapsed set popover y to the starting height and remove background blur
                    self.pullUpVC.view.frame.origin.y =  self.heightView -    self.startCardHeight
                    // self.visualEffectView.effect = UIBlurEffect(style: .extraLight)
                }
            }
            // Complete animation frame
            frameAnimator.addCompletion { _ in
                //self.pullUpVC.view.isUserInteractionEnabled = true
                /*
                 This will be called after delegates...
                 So it will set next state of pullup...So after delegate calles and if user tap handle again, collapse will set according to this variables...
                 NOTE: If we want to expanded pullup from halfOpened, we call function expand() from code directly...
                 This below code mostly set collapse->halfOpend and halfOpened->collapse
                 */
                if self.cardVisible == false && self.cardHalfOpened == false{
                    //self.cardVisible = true
                    //If pullup not expanded and half opened meanse -> collapsed, make it half opened for nextstate..
                    self.cardHalfOpened = true
                }/*else if self.cardHalfOpened == true && self.cardVisible == false{
                  //If pullup half opened and not expande...make it collapsed again for next state...
                  self.cardVisible = true
                  //self.cardHalfOpened = false
                  }*/else{
                      //Make pullup -> collapsed
                      self.cardVisible = false
                      self.cardHalfOpened = false
                  }
                //self.cardVisible = !self.cardVisible
                self.runningAnimations.removeAll()
            }
            // Start animation
            frameAnimator.startAnimation()
            // Append animation to running animations
            runningAnimations.append(frameAnimator)
        }
        spreadDelegate(state: state)
    }
    
    func spreadDelegate(state:PullUpStatus) {
        switch state {
        case .expanded:
            do{
                //Here spreadDelegate will call before frameAnimator.addCompletion
                //So by making this both variable make self.cardHalfOpened = true, so when again handle tap nextState will call and in it for self.cardHalfOpened = true, collapse will be state...So to make collapse from expand, we set like this...
                self.cardHalfOpened = false
                self.cardVisible = false
                
                delegate?.pullUpViewStatus(pullUpVC, didChangeTo: .expanded)
            }
        case .collapsed:
            delegate?.pullUpViewStatus(pullUpVC, didChangeTo: .collapsed)
        case .halfOpened:
            delegate?.pullUpViewStatus(pullUpVC, didChangeTo: .halfOpened)
        }
        
    }
    
    // Function to start interactive animations when view is dragged
    func startInteractiveTransition(state:PullUpStatus, duration:TimeInterval) {
        // If animation is empty start new animation
        if runningAnimations.isEmpty {
            animateTransitionIfNeeded(state: state, duration: duration)
        }
        // For each animation in runningAnimations
        for animator in runningAnimations {
            // Pause animation and update the progress to the fraction complete percentage
            animator.pauseAnimation()
            animationProgressWhenInterrupted = animator.fractionComplete
            //print("animationProgressWhenInterrupted==\(animationProgressWhenInterrupted)")
        }
    }
    
    // Funtion to update transition when view is dragged
    func updateInteractiveTransition(fractionCompleted:CGFloat) {
        // For each animation in runningAnimations
        for animator in runningAnimations {
            // Update the fraction complete value to the current progress
            animator.fractionComplete = fractionCompleted + animationProgressWhenInterrupted
            //print("animator.fractionComplete==\(fractionCompleted)")
        }
    }
    
    // Function to continue an interactive transisiton
    func continueInteractiveTransition () {
        // For each animation in runningAnimations
        for animator in runningAnimations {
            // Continue the animation forwards or backwards
            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        }
    }
}
