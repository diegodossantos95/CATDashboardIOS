//
// ViewController.swift
// CATDashboard
//
// Created by SAP Cloud Platform SDK for iOS Assistant application on 13/05/17
//

import UIKit
import SAPOData
import SAPFiori

class MasterTableViewController: UITableViewController, ActivityIndicator {
    
    // MARK: LOCAL VARIABLES
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private var _projects: [Project] = [Project]()
    private var activityIndicator: UIActivityIndicatorView!
    private var dataAccess: CATServiceDataAccess {
        return appDelegate.catServiceClass
    }
    
    // MARK: VC LIFECYLE
    override func viewDidLoad() {
        super.viewDidLoad()
        // Initialize activity indicator
        self.activityIndicator = self.initActivityIndicator()
        self.activityIndicator.center = self.tableView.center
        self.tableView.addSubview(self.activityIndicator)
        // add refreshcontrol UI
        self.refreshControl?.addTarget(self, action: #selector(self.refresh), for: UIControlEvents.valueChanged)
        self.tableView.addSubview(refreshControl!)
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 98
        
        self.updateTableWithActivityIndicator()
    }
    
    // MARK: PRIVATE FUNCTION
    func refresh() {
        DispatchQueue.global().async {
            self.updateTable(completionHandler: {
                DispatchQueue.main.async {
                    self.refreshControl?.endRefreshing()
                }
            })
        }
    }
    
    private func updateTableWithActivityIndicator() {
        self.showActivityIndicator(self.activityIndicator)
        DispatchQueue.global().async {
            self.updateTable(completionHandler: {
                DispatchQueue.main.async {
                    self.hideActivityIndicator(self.activityIndicator)
                }
            })
        }
    }
    
    private func updateTable(completionHandler: @escaping() -> Void) {
        self.requestProjects { (error) in
            defer {
                completionHandler()
            }
            
            guard error != nil else {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                return
            }
        }
    }

    private func requestProjects(completionHandler: @escaping(Error?) -> Void) {
        self.dataAccess.loadProjects { (projects, error) in
            guard let projects = projects else {
                completionHandler(error!)
                return
            }
            self._projects = projects
            completionHandler(nil)
        }
    }
    
    // MARK: Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails" {
            if let toViewController = segue.destination as? DetailsViewController {
                // Pass the selected object to the new view controller.
                if let indexPath = self.tableView.indexPathForSelectedRow {
                    let selectedProject = self._projects[indexPath.row]
                    toViewController.project = selectedProject
                }
            }
        }
    }
    
    
    // MARK: MASTER TABLE DELEGATE
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self._projects.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
        
        let project = self._projects[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FUIObjectTableViewCell",
                                                 for: indexPath as IndexPath)
        guard let objectCell = cell as? FUIObjectTableViewCell else {
            return cell
        }
        
        objectCell.headlineText = project.name!
        objectCell.subheadlineText = "CAT: " + project.getCATDate()
        
        return objectCell
    }
}
