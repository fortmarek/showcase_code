//
//  AppDelegate.swift
//  Cards
//
//  Created by Marek Fořt on 8/6/17.
//  Copyright © 2017 Marek Fořt. All rights reserved.
//

import UIKit
import CoreData
import KeychainAccess
import FBSDKCoreKit
import FirebaseCore
import Fabric
import Crashlytics
import UserNotifications
import FirebaseMessaging
import ReactiveSwift



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let userDefaults = UserDefaults.standard
        let currentAppLaunchIndex: Int = userDefaults.integer(forKey: "numberOfTimesLaunched")
        userDefaults.set(currentAppLaunchIndex + 1, forKey: "numberOfTimesLaunched")
        
        Fabric.with([Crashlytics.self])
        
        Messaging.messaging().delegate = self
        
        FirebaseApp.configure()
        
        UISearchBar.appearance().tintColor = .cornflower
        
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UINavigationBar.classForCoder() as! UIAppearanceContainer.Type]).setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 18, weight: .bold)], for: .normal)
        
        let controller: UIViewController = getController()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = controller
        window?.makeKeyAndVisible()
        
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        
        
        return true
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
    }
    
    private func getController() -> UIViewController {
        let userManager = UserManager()
        
        if userManager.isLoggedIn() {
            let tabBarController = TabBarController()
            return tabBarController
        }
        else {
            let welcomeViewController = WelcomeViewController()
            let navigationController = UINavigationController(rootViewController: welcomeViewController)
            navigationController.navigationBar.isTranslucent = true
            let backImage = UIImage(asset: Asset.back)
            navigationController.navigationBar.backIndicatorImage = backImage
            navigationController.navigationBar.backIndicatorTransitionMaskImage = backImage
            navigationController.navigationBar.tintColor = .cornflower
            let backgroundImage = UIImage(color: .paleGrey, size: nil)
            navigationController.navigationBar.setBackgroundImage(backgroundImage, for: UIBarMetrics.default)
            navigationController.navigationBar.shadowImage = backgroundImage
            navigationController.navigationBar.isTranslucent = false
            
            return navigationController
        }
    }
    
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        let handledShortCutItem = handleShortCutItem(shortcutItem: shortcutItem)
        
        completionHandler(handledShortCutItem)
    }
    
    func handleShortCutItem(shortcutItem: UIApplicationShortcutItem) -> Bool {
        
        guard let shortCutType = shortcutItem.type as String?,
        let tabBarController = window?.rootViewController as? UITabBarController
        else {return false}
        
        switch shortCutType {
        case "Type2":
            guard let tabBarViewControllers = tabBarController.viewControllers, !tabBarViewControllers.isEmpty,
                let homeNavigationController = tabBarViewControllers.first as? UINavigationController else {return false}
            homeNavigationController.popToRootViewController(animated: false)
            guard let homeViewController = homeNavigationController.viewControllers.first as? HomeViewController else {return false}
            
            
            if #available(iOS 11.0, *) {
                homeViewController.shouldShowSearchController = true 
                homeViewController.navigationItem.searchController?.isActive = true
            }
            tabBarController.selectedIndex = 0
            
            return true
            
        case "Type3":
            tabBarController.selectedIndex = 1
        default:
            tabBarController.selectedIndex = 3
        }
        
        return true
    }
    
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        var token = ""
        for i in 0..<deviceToken.count {
            token = token + String(format: "%02.2hhx", arguments: [deviceToken[i]])
        }
        
        Messaging.messaging().apnsToken = deviceToken
        
    }
    
    func messaging(_ messaging: Messaging, didRefreshRegistrationToken fcmToken: String) {
        let authenticationAPIService = AuthenticationAPIService()
        print(fcmToken)
        authenticationAPIService.sendNotificationToken(fcmToken).start()
    }
    
    func application(received remoteMessage: MessagingRemoteMessage) {
        
    }
    
//    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
//
//        if shortcutItem.type == "Type1" {
//
//            controller
//
//            completionHandler(true)
//        } else if shortcutItem.type == "Type2" {
//
//            //handle action Type02
//
//            completionHandler(true)
//        } else {
//            completionHandler(false)
//        }
//
//    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Did Fail to register for Remote Notifications with error \(error)")
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
        
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Cards")
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
                 Check the error message to determine what the actual problem was.
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

//https://stackoverflow.com/questions/35644128/how-do-i-make-text-labels-scale-the-font-size-with-different-apple-product-scree?noredirect=1&lq=1
extension AppDelegate {
    static var isScreenSmall: Bool {
        return max(UIScreen.main.bounds.width, UIScreen.main.bounds.height) == 568.0
    }
    static var isScreenMedium: Bool {
        return max(UIScreen.main.bounds.width, UIScreen.main.bounds.height) == 667.0
    }
    static var isScreenBig: Bool {
        return max(UIScreen.main.bounds.width, UIScreen.main.bounds.height) == 736.0
    }
    
    static var isiPad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
}

