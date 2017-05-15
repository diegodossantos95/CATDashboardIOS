//
//  DetailsViewController.swift
//  CATDashboard
//
//  Created by Diego dos Santos on 14/05/17.
//  Copyright © 2017 SAP. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
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
    private var issues: [Issue]?
    
    // MARK: Outlets
    @IBOutlet weak var projectNameLabel: UILabel!
    @IBOutlet weak var CATDateLabel: UILabel!
    
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
            self.requestProjectDetails(completionHandler: {_ in
            })
        }
    }
    
    private func requestProjectDetails(completionHandler: @escaping(Error?) -> Void) {
        self.dataAccess.loadProjectDetailsById(projectId: self.project!.id!) { (projects, error) in
            guard let projects = projects else {
                completionHandler(error!)
                return
            }
            
            self.project = projects[0]
            self.issues = self.project?.issueDetails
            
            completionHandler(nil)
        }
    }
}
