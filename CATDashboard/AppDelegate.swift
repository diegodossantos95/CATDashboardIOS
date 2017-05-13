//
// AppDelegate.swift
// CATDashboard
//
// Created by SAP Cloud Platform SDK for iOS Assistant application on 13/05/17
//

import UIKit
import SAPFoundation
import SAPFiori

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - LOCAL VARIABLES
    var window: UIWindow?
    var catServiceClass: CATServiceDataAccess!
    var urlSession: SAPURLSession? {
        didSet {
            self.catServiceClass = CATServiceDataAccess(urlSession: urlSession!)
        }
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
    
    func applicationDidFinishLaunching(_ application: UIApplication) {
        
        let urlSession = SAPURLSession(configuration: URLSessionConfiguration.default)
        urlSession.register(SAPcpmsObserver(applicationID: Constants.appId, deviceID: UIDevice.current.identifierForVendor!.uuidString))
        self.urlSession = urlSession
        
        UINavigationBar.applyFioriStyle()
        
        // Override point for customization after application launch.
        let splitViewController = self.window!.rootViewController as! UISplitViewController
        let navigationController = splitViewController.viewControllers[splitViewController.viewControllers.count - 1] as! UINavigationController
        navigationController.topViewController!.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem
    }
}
