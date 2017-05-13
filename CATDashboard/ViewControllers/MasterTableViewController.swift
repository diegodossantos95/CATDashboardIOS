//
// ViewController.swift
// CATDashboard
//
// Created by SAP Cloud Platform SDK for iOS Assistant application on 13/05/17
//

import UIKit
import SAPOData

class MasterTableViewController: UITableViewController {
    
    // LOCAL VARIABLES
    private var _projects: [Project] = [Project]()
    var projects: [EntityValue] {
        get { return _projects }
        set { self._projects = newValue as! [Project]
        }
    }

    // VC LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MASTER TABLE DELEGATE
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self._projects.count
    }
}
