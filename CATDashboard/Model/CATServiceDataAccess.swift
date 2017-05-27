//
//  CATServiceDataAccess.swift
//  CATDashboard
//
//  Created by Diego dos Santos on 13/05/17.
//  Copyright © 2017 SAP. All rights reserved.
//

import Foundation
import SAPCommon
import SAPFoundation
import SAPOData
import SAPOfflineOData

class CATServiceDataAccess {
    var service: CATService<OfflineODataProvider>
    var offlineODataProvider: OfflineODataProvider
    var isStoreOpened = false
    
    init(urlSession: SAPURLSession) {
        var offlineParameters = OfflineODataParameters()
        
        // append the X-SMP-APPID header
        offlineParameters.customHeaders = ["X-SMP-APPID": Constants.appId]
        offlineParameters.storeName = "OFFLINE_STORE"
        offlineParameters.enableRepeatableRequests = true
        
        // create offline data provider
        self.offlineODataProvider = try! OfflineODataProvider(
            serviceRoot: Constants.appUrl,
            parameters: offlineParameters,
            sapURLSession: urlSession
        )
        
        // define offline defining query
        let projectQuery = OfflineODataDefiningQuery(name: "Project", query: "Projects", automaticallyRetrievesStreams: false)
        try! self.offlineODataProvider.add(definingQuery: projectQuery)
        
        let issuesQuery = OfflineODataDefiningQuery(name: "Issue", query: "Issues", automaticallyRetrievesStreams: false)
        try! self.offlineODataProvider.add(definingQuery: issuesQuery)
        
        self.service = CATService(provider: self.offlineODataProvider)
    }

    func loadProjects(completionHandler: @escaping([Project]?, Error?) -> Void) {
        let query = DataQuery().select(Project.id, Project.name, Project.startDate, Project.endDate)
        self.executeRequest(query: query, request: self.service.projects, completionHandler: completionHandler)
    }
    
    func loadIssuesByProjectId(projectId: Int, completionHandler: @escaping([Issue]?, Error?) -> Void) {
        let query = DataQuery().filter(Issue.project.equal(projectId)).expand(Issue.issueCategoryDetails, Issue.issuePriorityDetails, Issue.issueStatusDetails)
        self.executeRequest(query: query, request: self.service.issues, completionHandler: completionHandler)
    }
    
    private func executeRequest<T>(query: DataQuery, request: @escaping(DataQuery) throws -> [T],
                                completionHandler: @escaping([T]?, Error?) -> Void) {
        DispatchQueue.global().async {
            if (!self.isStoreOpened) {
                
                // try opening the store
                self.service.open { error in
                    guard error == nil else {
                        print(error.debugDescription)
                        return;
                    }
                    
                    // set flag indicating store is open
                    self.isStoreOpened = true
                    
                    // download data
                    self.service.download { error in
                        guard error == nil else {
                            // in case of error, close store and reset flag
                            print(error.debugDescription)
                            self.isStoreOpened = false
                            return
                        }
                        
                        do {
                            // perform query
                            let result = try request(query)
                            completionHandler(result, nil)
                        } catch let error {
                            print(error.localizedDescription)
                            completionHandler(nil, error)
                        }
                        
                        // once finished, close store and reset flag
                        self.isStoreOpened = false
                    }
                }
            }
        }
    }

}
