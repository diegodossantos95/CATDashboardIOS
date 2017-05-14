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
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {

    // MARK: - LOCAL VARIABLES
    var window: UIWindow?
    var catServiceClass: CATServiceDataAccess!
    var urlSession: SAPURLSession? {
        didSet {
            self.catServiceClass = CATServiceDataAccess(urlSession: urlSession!)
        }
    }
    
    func applicationDidFinishLaunching(_ application: UIApplication) {
        
        let urlSession = SAPURLSession(configuration: URLSessionConfiguration.default)
        urlSession.register(SAPcpmsObserver(applicationID: Constants.appId, deviceID: UIDevice.current.identifierForVendor!.uuidString))
        self.urlSession = urlSession
        
        UINavigationBar.applyFioriStyle()
        
        let splitViewController = self.window!.rootViewController as! UISplitViewController
        splitViewController.delegate = self
    }
    
    // MARK: - SplitView Delegate
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        guard let secondaryAsDetails = secondaryViewController as? DetailsViewController else {
            return false
        }
        // Without this, on iPhone the main screen is the detailview and the masterview can not be reached.
        guard secondaryAsDetails.project != nil else {
              // Return true to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
            return true
        }
        
        return false
    }
}
