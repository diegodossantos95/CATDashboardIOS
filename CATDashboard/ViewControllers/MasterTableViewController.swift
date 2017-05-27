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
    private var projects: [Project] = [Project]()
    private var activityIndicator: UIActivityIndicatorView!
    private var dataAccess: CATServiceDataAccess {
        return appDelegate.catServiceClass
    }
    
    // MARK: VC LIFECYLE
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.configureActivityIndicator()
        // add refreshcontrol UI
        self.refreshControl?.addTarget(self, action: #selector(self.refresh), for: UIControlEvents.valueChanged)
        self.tableView.addSubview(refreshControl!)
        
        // Remove the separators below the table
        self.tableView.tableFooterView = UIView()
        
        self.updateTableWithActivityIndicator()
    }
    
    // MARK: PRIVATE FUNCTION
    private func configureActivityIndicator(){
        // Initialize activity indicator
        self.activityIndicator = self.initActivityIndicator()
        self.activityIndicator.center = self.tableView.center
        self.tableView.addSubview(self.activityIndicator)
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
            self.projects = projects
            completionHandler(nil)
        }
    }
    
    //MARK: Refresh Control
    func refresh() {
        DispatchQueue.global().async {
            self.updateTable(completionHandler: {
                DispatchQueue.main.async {
                    self.refreshControl?.endRefreshing()
                }
            })
        }
    }
    
    // MARK: Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails" {
            if let toViewController = segue.destination as? DetailsViewController {
                // Pass the selected object to the new view controller.
                if let indexPath = self.tableView.indexPathForSelectedRow {
                    let selectedProject = self.projects[indexPath.row]
                    toViewController.project = selectedProject
                }
            }
        }
    }
    
    
    // MARK: MASTER TABLE DELEGATE
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.projects.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension

        let project = self.projects[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectCell",
                                                 for: indexPath as IndexPath)
        guard let projectCell = cell as? FUIObjectTableViewCell else {
            return cell
        }
        
        projectCell.headlineText = project.name!
        projectCell.subheadlineText = "CAT: " + project.getCATDate()
        
        return projectCell
    }
}
