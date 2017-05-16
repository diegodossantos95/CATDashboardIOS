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

class CATServiceDataAccess {
    var service: CATService<OnlineODataProvider>
    
    init(urlSession: SAPURLSession) {
        let odataProvider = OnlineODataProvider(serviceName: "CATService", serviceRoot: Constants.appUrl, sapURLSession: urlSession)
        odataProvider.serviceOptions.checkVersion = false // this disables version validation of the backend OData service and should only be used in demo and test applications
        self.service = CATService(provider: odataProvider)
        // To update entity force to use X-HTTP-Method header
        _ = self.service.provider.networkOptions.tunneledMethods.append("MERGE")
    }

    func loadProjects(completionHandler: @escaping([Project]?, Error?) -> Void) {
        let query = DataQuery().select(Project.id, Project.name, Project.startDate, Project.endDate)
        self.executeRequest(query: query, request: self.service.projects, completionHandler: completionHandler)
    }
    
    func loadIssuesByProjectId(projectId: Int, completionHandler: @escaping([Issue]?, Error?) -> Void) {
        let query = DataQuery().filter(Issue.project.equal(projectId)).expand(Issue.issueCategoryDetails, Issue.issuePriorityDetails, Issue.issueStatusDetails)
        self.executeRequest(query: query, request: self.service.issues, completionHandler: completionHandler)
    }
    
    private func executeRequest<T>(query: DataQuery, request: @escaping(DataQuery) throws -> [T], completionHandler: @escaping([T]?, Error?) -> Void) {
        DispatchQueue.global().async {
            do {
                let result = try request(query)
                completionHandler(result, nil)
            } catch let error {
                completionHandler(nil, error)
            }
        }
    }
}
