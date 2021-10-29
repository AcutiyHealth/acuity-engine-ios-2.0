//
//  SceneDelegate.swift
//  AcuityEngine
//
//  Created by Bhoomi Jagani on 25/02/21.
//

import UIKit
import AuthenticationServices

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            
            WebServiceConstants.mode = .DEBUG
            
            let window = UIWindow(windowScene: windowScene)
            /*guard
             let appleUserData = UserDefaults.standard.data(forKey: "appleUser"),
             let appleUser = try? JSONDecoder().decode(AppleUser.self, from: appleUserData)
             else { return }
             
             
             let appleIDProvider = ASAuthorizationAppleIDProvider()
             appleIDProvider.getCredentialState(forUserID: appleUser.userId) { (credentialState, error) in
             switch credentialState {
             case .authorized:
             DispatchQueue.main.async {
             // Override point for customization after application launch.
             let storyboard = UIStoryboard(name: "Main", bundle: nil)
             let navigationController = storyboard.instantiateInitialViewController() as UINavigationController
             let rootViewController = storyboard.instantiateViewController(withIdentifier: "AcuityMainViewController") as! AcuityMainViewController
             navigationController.viewControllers = [rootViewController]
             self.window?.rootViewController = navigationController
             
             }
             break // The Apple ID credential is valid.
             case .revoked, .notFound:
             // The Apple ID credential is either revoked or was not found, so show the sign-in UI.
             break
             default:
             break
             }
             }
             */
            
            // Save App Version
            saveAppVersion()
            
            window.makeKeyAndVisible()
            AppDelegate.shared.window = window
        }
    }
    
    //========================================================================================================
    //MARK: Save App Version
    //========================================================================================================
    
    func saveAppVersion() {
        let defaults = UserDefaults.standard
        let currentVersion = versionNumberString()
        defaults.set(currentVersion, forKey: VERSION_KEY)
    }
    
    //========================================================================================================
    //MARK: -
    //========================================================================================================
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
        if Utility.fetchBool(forKey: Key.kIsNotificationOnOff) && AppDelegate.shared.isLocalNotificationGranted {
            UNUserNotificationCenter.current().removePendingNotificationRequests( withIdentifiers: [Key.kIsTerminatereminder])
            
            //Prepare Notification Model...
            var dayComponent    = DateComponents()
            dayComponent.day    = NUMBER_OF_DAYS_FOR_APP_OPEN // For removing one day (yesterday): -1
            let theCalendar     = Calendar.current
            let newDate        = theCalendar.date(byAdding: dayComponent, to: Date())
            
            let notificationModel = NotificationModel(title: AlertMessages.TERMINATOR_NOTIFICATION_TITLE, body: AlertMessages.TERMINATOR_NOTIFICATION_MESSAGE, triggerDate: newDate!, identifier: Key.kIsTerminatereminder, isRepeat: false)
            NotificationManager.shared.setNotificationForAppOpen(model: notificationModel)
        }
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        
        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
    
}

