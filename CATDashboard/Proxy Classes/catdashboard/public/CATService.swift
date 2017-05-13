// # Proxy Compiler 1.7.3.17

import Foundation
import SAPOData

open class CATService<Provider: DataServiceProvider>: DataService<Provider> {

    public override init(provider: Provider) {
        super.init(provider: provider)
        self.provider.metadata = CATServiceMetadata.document
    }

    open func issueCategories(query: DataQuery = DataQuery()) throws -> Array<IssueCategory> {
        return try IssueCategory.array(from: self.executeQuery(query.from(CATServiceMetadata.EntitySets.issueCategories)).entityList())
    }

    open func issueCategories(query: DataQuery = DataQuery(), completionHandler: @escaping(Array<IssueCategory>?, Error?) -> Void) -> Void {
        self.addBackgroundOperation {
            do {
                let result: Array<IssueCategory> = try self.issueCategories(query: query)
                OperationQueue.main.addOperation {
                    completionHandler(result, nil)
                }
            }
            catch let error {
                OperationQueue.main.addOperation {
                    completionHandler(nil, error)
                }
            }
        }
    }

    open func issuePriorities(query: DataQuery = DataQuery()) throws -> Array<IssuePriority> {
        return try IssuePriority.array(from: self.executeQuery(query.from(CATServiceMetadata.EntitySets.issuePriorities)).entityList())
    }

    open func issuePriorities(query: DataQuery = DataQuery(), completionHandler: @escaping(Array<IssuePriority>?, Error?) -> Void) -> Void {
        self.addBackgroundOperation {
            do {
                let result: Array<IssuePriority> = try self.issuePriorities(query: query)
                OperationQueue.main.addOperation {
                    completionHandler(result, nil)
                }
            }
            catch let error {
                OperationQueue.main.addOperation {
                    completionHandler(nil, error)
                }
            }
        }
    }

    open func issueStatuses(query: DataQuery = DataQuery()) throws -> Array<IssueStatus> {
        return try IssueStatus.array(from: self.executeQuery(query.from(CATServiceMetadata.EntitySets.issueStatuses)).entityList())
    }

    open func issueStatuses(query: DataQuery = DataQuery(), completionHandler: @escaping(Array<IssueStatus>?, Error?) -> Void) -> Void {
        self.addBackgroundOperation {
            do {
                let result: Array<IssueStatus> = try self.issueStatuses(query: query)
                OperationQueue.main.addOperation {
                    completionHandler(result, nil)
                }
            }
            catch let error {
                OperationQueue.main.addOperation {
                    completionHandler(nil, error)
                }
            }
        }
    }

    open func issues(query: DataQuery = DataQuery()) throws -> Array<Issue> {
        return try Issue.array(from: self.executeQuery(query.from(CATServiceMetadata.EntitySets.issues)).entityList())
    }

    open func issues(query: DataQuery = DataQuery(), completionHandler: @escaping(Array<Issue>?, Error?) -> Void) -> Void {
        self.addBackgroundOperation {
            do {
                let result: Array<Issue> = try self.issues(query: query)
                OperationQueue.main.addOperation {
                    completionHandler(result, nil)
                }
            }
            catch let error {
                OperationQueue.main.addOperation {
                    completionHandler(nil, error)
                }
            }
        }
    }

    open func projects(query: DataQuery = DataQuery()) throws -> Array<Project> {
        return try Project.array(from: self.executeQuery(query.from(CATServiceMetadata.EntitySets.projects)).entityList())
    }

    open func projects(query: DataQuery = DataQuery(), completionHandler: @escaping(Array<Project>?, Error?) -> Void) -> Void {
        self.addBackgroundOperation {
            do {
                let result: Array<Project> = try self.projects(query: query)
                OperationQueue.main.addOperation {
                    completionHandler(result, nil)
                }
            }
            catch let error {
                OperationQueue.main.addOperation {
                    completionHandler(nil, error)
                }
            }
        }
    }
}
