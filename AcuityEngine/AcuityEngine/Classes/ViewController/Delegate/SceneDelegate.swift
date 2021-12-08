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
    static var shared: SceneDelegate { return UIApplication.shared.delegate as! SceneDelegate }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            AppDelegate.shared.window = window
            //Configure Notification......
            configureUserNotifications()
            
            // Save App Version
            saveAppVersion()
            //AppDelegate.shared.moveToLoginScreen()
            let delayInSeconds = 0.10
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) { [weak self] in
                //AppDelegate.shared.moveToLoginScreen()
                
                //Tutorial Screen
                let isTutorialCardShown = Utility.fetchObject(forKey: Key.kIsTutorialCardShown)
                let isLoggedIn = Utility.fetchBool(forKey: Key.kIsLoggedIn)
                if isTutorialCardShown == nil || (isTutorialCardShown != nil) == false{
                    AppDelegate.shared.moveToTutorialScreen()
                }
                
                else if (isLoggedIn) == false{
                    AppDelegate.shared.moveToLoginScreen()
                }
                else{
                    AppDelegate.shared.checkIfAppleUserIsStored()
                }
                window.makeKeyAndVisible()
            }
            
            
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
        let isLoggedIn = Utility.fetchBool(forKey: Key.kIsLoggedIn)
        if isLoggedIn{
            if Utility.fetchBool(forKey: Key.kIsNotificationOnOff) && AppDelegate.shared.isLocalNotificationGranted {
                UNUserNotificationCenter.current().removePendingNotificationRequests( withIdentifiers: [Key.kIsTerminatereminder])
                
                //Prepare Notification Model...
                //            var dayComponent    = DateComponents()
                //            dayComponent.day    = NUMBER_OF_DAYS_FOR_APP_OPEN // For removing one day (yesterday): -1
                //            let theCalendar     = Calendar.current
                //            let newDate        = theCalendar.date(byAdding: dayComponent, to: Date())
                //
                let notificationModel = NotificationModel(title: AlertMessages.TERMINATOR_NOTIFICATION_TITLE, body: AlertMessages.TERMINATOR_NOTIFICATION_MESSAGE, numberOfDays: NUMBER_OF_DAYS_FOR_APP_OPEN, identifier: Key.kIsTerminatereminder, isRepeat: true)
                if notificationModel.numberOfDays ?? 0 > 0{
                    NotificationManager.shared.setNotificationForAppOpen(model: notificationModel)
                }
            }
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


// MARK: - UNUserNotificationCenterDelegate
extension SceneDelegate: UNUserNotificationCenterDelegate {
    
    private func configureUserNotifications() {
        UNUserNotificationCenter.current().delegate = self
    }
    // This method will be called when app received push notifications in foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void)
    {
        completionHandler([.alert, .badge, .sound])
    }
    // 1
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        let request:UNNotificationRequest = response.notification.request
        if request.identifier == Key.kIsSymptomseminder{
            DispatchQueue.main.async {
                if AppDelegate.shared.navigationController != nil{
                    let topVC = AppDelegate.shared.navigationController.topViewController
                    if ((topVC?.isKind(of: AcuityMainViewController.self)) != nil){
                        NotificationCenter.default.post(name: Notification.Name(NSNotificationName.showSymptomsListScreen.rawValue), object: nil)
                    }
                }
            }
            
        }
        completionHandler()
    }
}
