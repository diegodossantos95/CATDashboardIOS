//
// ViewController.swift
// CATDashboard
//
// Created by SAP Cloud Platform SDK for iOS Assistant application on 13/05/17
//

import UIKit
import SAPOData
import SAPFiori

class MasterTableViewController: UITableViewController {
    
    // LOCAL VARIABLES
    private var _projects: [Project] = [Project]()
    
    // MASTER TABLE DELEGATE
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
        objectCell.subheadlineText = "CAT: " + project.startDate!.toString() + " - " + project.endDate!.toString()
        
        return objectCell
    }
}
