//
//  PatientOverviewViewController.swift
//  SpineApp
//
//  Created by Peter Cerhan on 7/13/17.
//  Copyright © 2017 Peter Cerhan. All rights reserved.
//

import UIKit

class PatientOverviewViewController: UIViewController {

    let presenter: PatientOverviewPresenter
    fileprivate var patientOverviewElements = [PatientOverviewElement]()
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var label: UILabel!
    
    init(nibName: String, presenter: PatientOverviewPresenter) {
        self.presenter = presenter
        
        super.init(nibName: nibName, bundle: nil)
        
        
        presenter.attach(view: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) should not be used with PatientOverviewViewController. Use init(nibName:presenter:) instead")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Appcess"
        extendedLayoutIncludesOpaqueBars = false
        tableView.register(UINib(nibName:"PatientOverviewTableViewCell", bundle: nil), forCellReuseIdentifier: "PatientOverviewCell")
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
        
        presenter.loadData()
    }
    
    //Interface for presenter
    
    func set(elements: [PatientOverviewElement]) {
        patientOverviewElements = elements
        //reload data
        print("1st element: \(patientOverviewElements[0].outcome)")
    }
    
    func set(element: PatientOverviewElement, atIndex index: Int) -> Bool {
        guard index < patientOverviewElements.count else {
            return false
        }
        
        patientOverviewElements[index] = element
        
        tableView.reloadData()
        
        return true
    }
    
    func set(outcomes: [String]) {
        guard outcomes.count > 0 else {
            return
        }
        
        label.text = outcomes[0]
    }
    
    //actions
    
    @IBAction func done() {
        presenter.someAction()
    }
    
    func detailsForOutcome(index: Int) {
        let vc = DetailsViewController(nibName: "DetailsViewController", delegate: self)
        present(vc, animated: true, completion: nil)
    }
}

extension PatientOverviewViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return patientOverviewElements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PatientOverviewCell") as! PatientOverviewTableViewCell
        
        cell.titleLabel.text = patientOverviewElements[indexPath.item].outcome
        cell.percentageLabel.text = "\(patientOverviewElements[indexPath.item].failurePct * 100)%"
        cell.detailsButton.isHidden = !patientOverviewElements[indexPath.item].hasDetails
        cell.detailsCallback = {
            self.detailsForOutcome(index: indexPath.item)
        }
        
        return cell
    }
    
}

extension PatientOverviewViewController: DetailsViewControllerDelegate {
    func dismiss(_ detailsViewController: DetailsViewController) {
        dismiss(animated: true, completion: nil)
    }
}






