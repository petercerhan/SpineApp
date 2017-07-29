//
//  PatientOverviewViewController.swift
//  SpineApp
//
//  Created by Peter Cerhan on 7/13/17.
//  Copyright © 2017 Peter Cerhan. All rights reserved.
//

import UIKit

class PatientOverviewViewController: UIViewController {

    //MARK: - Dependencies
    
    let presenter: PatientOverviewPresenter
    
    //MARK: - State
    
    fileprivate var patientOverviewElements = [PatientOverviewElement]()
    
    //MARK: - XIB Components
    
    @IBOutlet var tableView: UITableView!
    
    //MARK: - Initialization
    
    init(nibName: String, presenter: PatientOverviewPresenter) {
        self.presenter = presenter
        
        super.init(nibName: nibName, bundle: nil)
        
        presenter.attach(view: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) should not be used with PatientOverviewViewController. Use init(nibName:presenter:) instead")
    }
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Appcess"
        
        tableView.register(UINib(nibName:"PatientOverviewTableViewCell", bundle: nil), forCellReuseIdentifier: "PatientOverviewCell")
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
        self.tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        presenter.loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.loadData()
    }
    
    //MARK: - Interface for presenter
    
    func set(elements: [PatientOverviewElement]) {
        patientOverviewElements = elements
        tableView.reloadData()
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
    }
    
    //MARK: - User Actions
    
    @IBAction func done() {
        presenter.someAction()
    }
    
    //MARK: - Application Actions
    
    func showDetailsForOutcome(index: Int) {
        let data = DetailsViewControllerData(title: patientOverviewElements[index].outcome,
                                             description: patientOverviewElements[index].description ?? "",
                                             dismissTitle: "Done")
        
        let vc = DetailsViewController(nibName: "DetailsViewController", delegate: self, data: data)
        present(vc, animated: true, completion: nil)
    }
}

//MARK: - UITableViewDataSource

extension PatientOverviewViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return patientOverviewElements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PatientOverviewCell") as! PatientOverviewTableViewCell
        
        cell.titleLabel.text = patientOverviewElements[indexPath.item].outcome
        cell.percentageLabel.text = patientOverviewElements[indexPath.item].failurePct.displayAsPercent(decimals: 2)
        cell.detailsButton.isHidden = (patientOverviewElements[indexPath.item].description == nil)
        cell.detailsCallback = { [unowned self] in
            self.showDetailsForOutcome(index: indexPath.item)
        }
        
        return cell
    }
    
}

//MARK: - UITableViewDelegate

extension PatientOverviewViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.nomogramSelected(atIndex: indexPath.item)
    }
    
}

//MARK: - DetailsViewControllerDelegate

extension PatientOverviewViewController: DetailsViewControllerDelegate {
    func dismiss(_ detailsViewController: DetailsViewController) {
        dismiss(animated: true, completion: nil)
    }
}


