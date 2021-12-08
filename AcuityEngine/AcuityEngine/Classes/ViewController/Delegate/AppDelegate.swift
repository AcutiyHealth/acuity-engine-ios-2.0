//
//  AppDelegate.swift
//  AcuityEngine
//
//  Created by Bhoomi Jagani on 25/02/21.
//

import UIKit
import CoreData
import AuthenticationServices
import Firebase
@main
class AppDelegate: UIResponder, UIApplicationDelegate,UNUserNotificationCenterDelegate {
    var window: UIWindow?
    var isLocalNotificationGranted:Bool = false
    static var shared: AppDelegate { return UIApplication.shared.delegate as! AppDelegate }
    var arrMedications:[MedicationDataDisplayModel] = []
    var isSymptomsNotificationStop = true
    var navigationController:UINavigationController!
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        WebServiceConstants.mode = .LIVE
        if Utility.fetchObject(forKey: Key.kIsNotificationOnOff) == nil{
            Utility.setBoolForKey(true, key: Key.kIsNotificationOnOff)
        }
        
      
        UNUserNotificationCenter.current().getPendingNotificationRequests(completionHandler: {requests -> () in
            print("\(requests.count) requests -------")
            /*for request in requests{
                print(request.identifier)
                print(request.trigger)
            }*/
        })
        //Set Notification Permisssion
        setNotificationPermisssion()
        // Override point for customization after application launch.
        return true
    }
    //========================================================================================================
    //MARK: Set Notification Permisssion..
    //========================================================================================================
    func setNotificationPermisssion(){
        // Override point for customization after application launch.
        //UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                self.isLocalNotificationGranted = true
                print("User gave permissions for local notifications")
            }
        }
        
    }
    func checkIfAppleUserIsStored(){
        let appleUserId = getFromKeyChain(key: Key.kAppleUserID)
        
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        appleIDProvider.getCredentialState(forUserID: appleUserId) { (credentialState, error) in
            switch credentialState {
            case .authorized:
                DispatchQueue.main.async {
                    self.moveToHomeScreen()
                }
                break // The Apple ID credential is valid.
            case .revoked, .notFound:
                // The Apple ID credential is either revoked or was not found, so show the sign-in UI.
                DispatchQueue.main.async {
                    self.moveToHomeScreen()
                }
                break
            default:
                break
            }
        }
        
        
    }
    //========================================================================================================
    //MARK: Move to tutorial screen
    //========================================================================================================
    func moveToTutorialScreen(){
        let storyboard = UIStoryboard(name: Storyboard.main.rawValue, bundle: nil)
        self.navigationController = storyboard.instantiateInitialViewController() as UINavigationController
        let rootViewController = storyboard.instantiateViewController(withIdentifier: "OnboardingViewController") as! OnboardingViewController
        navigationController.viewControllers = [rootViewController]
        self.window?.rootViewController = navigationController
    }
    //========================================================================================================
    //MARK: Move to login screen
    //========================================================================================================
    func moveToLoginScreen(){
        let storyboard = UIStoryboard(name: Storyboard.main.rawValue, bundle: nil)
        self.navigationController = storyboard.instantiateInitialViewController() as UINavigationController
        let rootViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        navigationController.viewControllers = [rootViewController]
        self.window?.rootViewController = navigationController
    }
    //========================================================================================================
    //MARK: Move to home screen
    //========================================================================================================
    func moveToHomeScreen(){
        let storyboard = UIStoryboard(name: Storyboard.main.rawValue, bundle: nil)
        self.navigationController = storyboard.instantiateInitialViewController() as UINavigationController
        let rootViewController = storyboard.instantiateViewController(withIdentifier: "AcuityMainViewController") as! AcuityMainViewController
        navigationController.viewControllers = [rootViewController]
        self.window?.rootViewController = navigationController
    }
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "AcuityEngine")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual Condition was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}

