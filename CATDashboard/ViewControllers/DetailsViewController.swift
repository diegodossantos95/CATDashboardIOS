//
//  DetailsViewController.swift
//  CATDashboard
//
//  Created by Diego dos Santos on 14/05/17.
//  Copyright © 2017 SAP. All rights reserved.
//

import UIKit
import SAPFiori

class DetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: LOCAL VARIABLES
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private var dataAccess: CATServiceDataAccess {
        return appDelegate.catServiceClass
    }
    private var activityIndicator: UIActivityIndicatorView!
    var project: Project? {
        didSet {
            self.updateProject()
        }
    }
    private var issues: [Issue] = [Issue]()
    
    // MARK: Outlets
    @IBOutlet weak var projectNameLabel: UILabel!
    @IBOutlet weak var CATDateLabel: UILabel!
    @IBOutlet weak var issuesTable: UITableView!
    
    // MARK: VC LIFECYLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }
    
    // MARK: Private functions
    private func configureView() {
        self.projectNameLabel.text = "\(project?.name ?? "")"
        self.CATDateLabel.text = "CAT: \(project?.getCATDate() ?? "")"
    }
    
    private func updateProject() {
        DispatchQueue.global().async {
            self.requestProjectDetails(completionHandler: {error in
                guard error != nil else {
                    DispatchQueue.main.async {
                        self.issuesTable.reloadData()
                    }
                    return
                }
            })
        }
    }
    
    private func requestProjectDetails(completionHandler: @escaping(Error?) -> Void) {
        self.dataAccess.loadIssuesByProjectId(projectId: self.project!.id!) { (issues, error) in
            guard let issues = issues else {
                completionHandler(error!)
                return
            }
            self.issues = issues
            
            completionHandler(nil)
        }
    }
    
    // MARK: Details TABLE DELEGATE
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.issues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        
        let issue = self.issues[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "IssueCell",
                                                 for: indexPath as IndexPath)
        guard let issueCell = cell as? FUIObjectTableViewCell else {
            return cell
        }
        
        issueCell.headlineText = issue.name
        issueCell.subheadlineText = issue.description
        
        return issueCell
    }
}
