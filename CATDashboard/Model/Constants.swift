//
//  Constants.swift
//  CATDashboard
//
//  Created by Diego dos Santos on 13/05/17.
//  Copyright © 2017 SAP. All rights reserved.
//

import Foundation
import SAPFoundation

struct Constants {
    
    static let appId = "catdashboard"
    private static let sapcpmsUrlString = "https://hcpms-i848202trial.hanatrial.ondemand.com/"
    static let sapcpmsUrl = URL(string: sapcpmsUrlString)!
    static let appUrl = Constants.sapcpmsUrl.appendingPathComponent(appId)
    static let configurationParameters = SAPcpmsSettingsParameters(backendURL: Constants.sapcpmsUrl, applicationID: Constants.appId)
}
