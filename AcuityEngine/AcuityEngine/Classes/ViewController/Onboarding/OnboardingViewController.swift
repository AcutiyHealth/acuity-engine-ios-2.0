//
//  OnboardingViewController.swift
//  Yummie
//
//  Created by Emmanuel Okwara on 30/01/2021.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var skipBtn: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var slides: [OnboardingSlide] = []
    
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
            if currentPage == slides.count - 1 {
                skipBtn.isHidden = true
                nextBtn.setTitle("Get Started", for: .normal)
            } else {
                skipBtn.isHidden = false
                nextBtn.setTitle("Next", for: .normal)
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slides = [
            OnboardingSlide(title: "Medical Information", description: "Welcome to MyWell.\n A platform that connects you with your health, continuously. The MyWell score is a consolidation of your clinical data into one number. First, tell us about yourself. Fill out your current conditions, add vitals and connect your wearables to track your daily self.", image: UIImage(named: "slide1")!),
            OnboardingSlide(title: "Medical Condition And Symptoms", description: "Next, we monitor you in the background by tracking your vitals from your wearables, such as your steps, sleep and water intake. When we connect with your labs your doctor obtains, your MyWell score is further refined. We will also help you track your symptoms and conditions which also influence your daily score. ", image: UIImage(named: "slide2")!),
            OnboardingSlide(title: "System Score Calculation", description: "Finally we bring all your data together to calculate your MyWell score, we provide a simple way to navigate your data and a place to consolidate your medical information. Our physicians created a score of you to give the most complete medical picture to understand a little bit more about yourself.", image: UIImage(named: "slide3")!)
        ]
        nextBtn.titleLabel?.font = Fonts.kStartEndValueFont
        skipBtn.titleLabel?.font = Fonts.kAcuityOnBoardingSkipFont
        pageControl.numberOfPages = slides.count
        
        //        if #available(iOS 14.0, *) {
        //            pageControl.preferredIndicatorImage = UIImage.init(systemName: "heart.fill")
        //        } else {
        //            // Fallback on earlier versions
        //        }
    }
    
    @IBAction func nextBtnClicked(_ sender: UIButton) {
        if currentPage == slides.count - 1 {
            self.btnSkipOrDoneClicked(sender)
        } else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    @IBAction func btnSkipOrDoneClicked(_ sender: Any)
    {
        Utility.setBoolForKey(true, key: Key.kIsTutorialCardShown)
        let isLoggedIn = Utility.fetchObject(forKey: Key.kIsLoggedIn)
        if isLoggedIn == nil || (isLoggedIn != nil) == false{
            AppDelegate.shared.moveToLoginScreen()
        }
        else{
            AppDelegate.shared.checkIfAppleUserIsStored()
        }
    }
}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as! OnboardingCollectionViewCell
        cell.setup(slides[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
        if currentPage == slides.count - 1 {
            skipBtn.isHidden = true
        }else{
            skipBtn.isHidden = false
        }
    }
}
