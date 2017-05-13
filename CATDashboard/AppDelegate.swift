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
    
    func applicationDidFinishLaunching(_ application: UIApplication) {
        
        let urlSession = SAPURLSession(configuration: URLSessionConfiguration.default)
        urlSession.register(SAPcpmsObserver(applicationID: Constants.appId, deviceID: UIDevice.current.identifierForVendor!.uuidString))
        self.urlSession = urlSession
        
        UINavigationBar.applyFioriStyle()
    }
}
