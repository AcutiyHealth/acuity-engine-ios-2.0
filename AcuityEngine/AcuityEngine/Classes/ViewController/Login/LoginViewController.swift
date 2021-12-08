//
//  LoginViewController.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 24/02/21.
//

import Foundation
import AuthenticationServices

class LoginViewController: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = ColorSchema.kMainThemeColor
        //fetch data from healthkit and load in tableview
        //self.setupSOAppleSignIn()
        //moveToHealhDataScreen()
    }
    
    //Add button for Sign in with Apple
    func setupSOAppleSignIn() {
        let btnAuthorization = ASAuthorizationAppleIDButton()
        btnAuthorization.frame = CGRect(x: 0, y: 0, width: 200, height: 40)
        btnAuthorization.center = self.view.center
        btnAuthorization.addTarget(self, action: #selector(actionHandleAppleSignin), for: .touchUpInside)
        self.view.addSubview(btnAuthorization)
    }
    
    // Perform acton on click of Sign in with Apple button
    @IBAction func actionHandleAppleSignin() {
       /*
        if #available(iOS 13.0, *) {
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            let request = appleIDProvider.createRequest()
            request.requestedScopes = [.fullName, .email]
            let authorizationController = ASAuthorizationController(authorizationRequests: [request])
            authorizationController.delegate = self
            authorizationController.performRequests()
        } else {
            // Fallback on earlier versions
        }*/
        moveToHealhDataScreen()
    }
    
    //========================================================================================================
    //MARK:- Call Login Api
    //========================================================================================================
    func loginWithApple(){
        
    }
}

extension LoginViewController: ASAuthorizationControllerDelegate {
    
    // ASAuthorizationControllerDelegate function for authorization failed
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print(error.localizedDescription)
    }
    
    // ASAuthorizationControllerDelegate function for successful authorization
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            // Create an account as per your requirement
            print(appleIDCredential)
            var name = ""
            if let nm = appleIDCredential.fullName?.givenName
            {
                name = "\(nm)"
                setKeyChain(key: Key.kAppleFirstName, value: name)
            }
            
            if let nm = appleIDCredential.fullName?.familyName
            {
                name = "\(name)"
                setKeyChain(key: Key.kAppleLastName, value: name)
            }
            
            if let em = appleIDCredential.email
            {
                setKeyChain(key: Key.kAppleLastName, value: em)
            }
            
            setKeyChain(key: Key.kAppleUserID, value: appleIDCredential.user)
//
//            print("kAppleFirstName",getFromKeyChain(key: Key.kAppleFirstName))
//            print("kAppleFirstName",getFromKeyChain(key: Key.kAppleLastName))
//            print("kAppleFirstName",getFromKeyChain(key: Key.kAppleUserID))
//
            //Write your code
        } else if let passwordCredential = authorization.credential as? ASPasswordCredential {
            let appleUsername = passwordCredential.user
            setKeyChain(key: Key.kAppleFirstName, value: appleUsername)
            let applePassword = passwordCredential.password
        }
        moveToHealhDataScreen()
    }
    
    @IBAction func moveToHealhDataScreen(){
        Utility.setBoolForKey(true, key: Key.kIsLoggedIn)
        guard let detailVC = UIStoryboard(name: Storyboard.main.rawValue, bundle: nil).instantiateViewController(withIdentifier: "AcuityMainViewController")  as? AcuityMainViewController else {return }
        //guard let detailVC = UIStoryboard(name: Storyboard.main.rawValue, bundle: nil).instantiateViewController(withIdentifier: "ProfiletempVC")  as? ProfiletempVC else {return }
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
    //For present window
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}

