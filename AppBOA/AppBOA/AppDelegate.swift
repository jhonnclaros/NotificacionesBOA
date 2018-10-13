//
//  AppDelegate.swift
//  AppBOA
//
//  Created by macmini on 9/23/18.
//  Copyright © 2018 BOA. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        loadInitialViewController()
        //initUserDefaultValue()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
        self.saveContext()
    }
    
    static func getDelegate() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    /*private func initUserDefaultValue() {
        if UserDefaults.standard.string(forKey: "userSession") == nil {
            UserDefaults.standard.setValue("nil", forKey: "userSession")
        }
    }*/

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "AppBOA")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
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
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    private func loadInitialViewController() {
        if let _ = UserDefaults.standard.string(forKey: "userSession") {
            segueToHomeViewController()
            UserDefaults.standard.removeObject(forKey: "userSession")
            UserDefaults.standard.removeObject(forKey: "employeeIDSession")
            UserDefaults.standard.removeObject(forKey: "employeeNameSession")
            UserDefaults.standard.removeObject(forKey: "itemIDSession")
            //logout()
         }
         else {
            segueToLoginViewController()
        }
    }
    
    func segueToLoginViewController() {
        let loginScene = AppStoryboard.Login.initialViewController()
        self.window?.rootViewController = loginScene
    }
    
    func segueToHomeViewController() {
        let homeScene = AppStoryboard.Home.initialViewController()
        self.window?.rootViewController = homeScene
    }
    
    func logout() {
        /*var baseURL = Constants.API.BaseServer
        baseURL = baseURL.replacingOccurrences(of: "http", with: "https")
        UserDefaults.standard.set(baseURL, forKey: "BrandingBaseURL")*/
        UserDefaults.standard.setValue("", forKey: "userSession")
        segueToLoginViewController()
    }
    
    /*func presentMenuViewController(controller: UIViewController) {
        let menuScene = AppStoryboard.Menu.initialViewController()
        controller.present(menuScene!, animated: true)
    }*/

}

