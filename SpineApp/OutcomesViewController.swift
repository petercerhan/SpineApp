//
//  OutcomesViewController.swift
//  SpineApp
//
//  Created by Peter Cerhan on 7/13/17.
//  Copyright © 2017 Peter Cerhan. All rights reserved.
//

import UIKit

struct OutcomesElement {
    var outcome: String
    var description: String?
    var evaluated: Bool
    var failurePct: Double
}

protocol OutcomesViewProtocol: class {
    func set(elements: [OutcomesElement], evaluated: [Bool])
    func set(element: OutcomesElement, evaluated: Bool, atIndex index: Int) -> Bool
}

class OutcomesViewController: UIViewController, OutcomesViewProtocol {

    //MARK: - Dependencies
    
    let presenter: OutcomesPresenterProtocol
    
    //MARK: - State
    
    fileprivate var outcomesElements = [OutcomesElement]()
    fileprivate var outcomeEvaluated = [Bool]()
    
    //MARK: - XIB Components
    
    @IBOutlet var tableView: UITableView!
    
    //MARK: - Initialization
    
    init(nibName: String, presenter: OutcomesPresenterProtocol) {
        self.presenter = presenter
        
        super.init(nibName: nibName, bundle: nil)
        
        presenter.attach(view: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) should not be used with OutcomesViewController. Use init(nibName:presenter:) instead")
    }
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Appcess"
        
        tableView.register(UINib(nibName:"OutcomesTableViewCell", bundle: nil), forCellReuseIdentifier: "OutcomesCell")
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        
        presenter.loadDataToView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.loadDataToView()
    }
    
    //MARK: - Interface for presenter
    
    func set(elements: [OutcomesElement], evaluated: [Bool]) {
        outcomesElements = elements
        outcomeEvaluated = evaluated
        tableView.reloadData()
    }
    
    func set(element: OutcomesElement, evaluated: Bool, atIndex index: Int) -> Bool {
        guard index < outcomesElements.count else {
            return false
        }
        
        outcomesElements[index] = element
        outcomeEvaluated[index] = evaluated
        
        tableView.reloadData()
        
        return true
    }
    
    //MARK: - User Input
    
    @IBAction func resetAll() {
        confirmationAlert(title: nil, message: "Reset all?", cancelButtonTitle: "Cancel", confirmButtonTitle: "Confirm") {
            [weak self] in
            self?.presenter.resetAllData()
        }
        
    }
    
    //MARK: - View Logic
    
    func showDetailsForOutcome(index: Int) {
        let data = DetailsViewControllerData(title: outcomesElements[index].outcome,
                                             description: outcomesElements[index].description ?? "",
                                             dismissTitle: "Done")
        
        let vc = DetailsViewController(nibName: "DetailsViewController", delegate: self, data: data)
        present(vc, animated: true, completion: nil)
    }
}

//MARK: - UITableViewDataSource

extension OutcomesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return outcomesElements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OutcomesCell") as! OutcomesTableViewCell
        
        cell.titleLabel.text = outcomesElements[indexPath.item].outcome
        
        if outcomeEvaluated[indexPath.item] {
            cell.percentageLabel.text = outcomesElements[indexPath.item].failurePct.displayAsPercent(significantFigures: 2)
        } else {
            cell.percentageLabel.text = "-"
        }
        
        cell.detailsButton.isHidden = (outcomesElements[indexPath.item].description == nil)
        cell.detailsCallback = { [unowned self] in
            self.showDetailsForOutcome(index: indexPath.item)
        }
        
        return cell
    }
    
}

//MARK: - UITableViewDelegate

extension OutcomesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.nomogramSelected(atIndex: indexPath.item)
    }
    
}

//MARK: - DetailsViewControllerDelegate

extension OutcomesViewController: DetailsViewControllerDelegate {
    func dismiss(_ detailsViewController: DetailsViewController) {
        dismiss(animated: true, completion: nil)
    }
}






