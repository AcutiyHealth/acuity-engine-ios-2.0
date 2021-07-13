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
        moveToHealhDataScreen()
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
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
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
            if let appleUser = AppleUser(appleIDCredential: appleIDCredential),
               let appleUserData = try? JSONEncoder().encode(appleUser){
                UserDefaults.standard.setValue(appleUserData, forKey: "appleUser")
                print("save apple user",appleUserData)
            }
            else{
                print("missing some fields", appleIDCredential.email, appleIDCredential.fullName, appleIDCredential.user)
                
                guard
                    let appleUserData = UserDefaults.standard.data(forKey: "appleUser"),
                    let appleUser = try? JSONDecoder().decode(AppleUser.self, from: appleUserData)
                else { return }
                
                print(appleUser)
            }
            moveToHealhDataScreen()
            //Write your code
        } else if let passwordCredential = authorization.credential as? ASPasswordCredential {
            let appleUsername = passwordCredential.user
            let applePassword = passwordCredential.password
            moveToHealhDataScreen()
        }
    }
    
   @IBAction func moveToHealhDataScreen(){
        guard let detailVC = UIStoryboard(name: Storyboard.main.rawValue, bundle: nil).instantiateViewController(withIdentifier: "AcuityMainViewController")  as? AcuityMainViewController else {return }
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
    //For present window
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}

