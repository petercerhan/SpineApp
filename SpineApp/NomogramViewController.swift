//
//  NomogramViewController.swift
//  SpineApp
//
//  Created by Peter Cerhan on 7/24/17.
//  Copyright © 2017 Peter Cerhan. All rights reserved.
//

import UIKit

class NomogramViewController: UIViewController {

    //MARK: - Dependencies
    
    fileprivate var presenter: NomogramPresenter
    
    //MARK: - State
    
    fileprivate var nomogramElements = [NomogramViewControllerElement]()
    var failurePct: Double = 0.0 {
        didSet {
            failurePctLabel.text = failurePct.displayAsPercent(decimals: 2)
        }
    }
    var outcome = "" {
        didSet {
            outcomeLabel.text = outcome
        }
    }
    
    //MARK: - XIB Components
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var failurePctLabel: UILabel!
    @IBOutlet var outcomeLabel: UILabel!

    //MARK: - Initialization
    
    init(nibName: String, presenter: NomogramPresenter) {
        self.presenter = presenter
        
        super.init(nibName: nibName, bundle: nil)
        
        presenter.attach(view: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) should not be used with NomogramViewController. Use init(nibName:presenter:) instead")
    }
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Nomogram"
        
        tableView.register(UINib(nibName:"NomogramTableViewCell", bundle: nil), forCellReuseIdentifier: "NomogramTableViewCell")
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        presenter.loadData()
    }
    
    //MARK: - User Actions
    
    @IBAction func done() {
        presenter.sceneComplete()
    }
    
    @IBAction func reset() {
        presenter.resetNomogram()
    }
    
    //MARK: - View Actions
    
    func showDetailsForPredictor(index: Int) {
        let data = DetailsViewControllerData(title: nomogramElements[index].name,
                                             description: nomogramElements[index].description ?? "",
                                             dismissTitle: "Done")
        
        let vc = DetailsViewController(nibName: "DetailsViewController", delegate: self, data: data)
        present(vc, animated: true, completion: nil)
    }
    
    //MARK: - Presenter interface
    
    func set(elements: [NomogramViewControllerElement]) {
        nomogramElements = elements
        tableView.reloadData()
    }
    
    func set(element: NomogramViewControllerElement, atIndex index: Int) {
        nomogramElements[index] = element
        tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
        tableView.selectRow(at: IndexPath(row: index, section: 0), animated: false, scrollPosition: .none)
        tableView.deselectRow(at: IndexPath(row: index, section: 0), animated: true)
    }
}

//MARK: - UITableViewDataSource

extension NomogramViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nomogramElements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NomogramTableViewCell") as! NomogramTableViewCell
        let element = nomogramElements[indexPath.item]
        //configure cell
        cell.titleLabel.text = element.name
        cell.infoButton.isHidden = (element.description == nil)
        cell.checkLabel.text = element.present ? "✓" : ""
        cell.detailsCallback = { [unowned self] in
            self.showDetailsForPredictor(index: indexPath.item)
        }
        
        return cell
    }
    
}

//MARK: - UITableViewDelegate

extension NomogramViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        presenter.updatePresent(atIndex: indexPath.item)
    }
    
}

//MARK: - DetailsViewControllerDelegate

extension NomogramViewController: DetailsViewControllerDelegate {
    func dismiss(_ detailsViewController: DetailsViewController) {
        dismiss(animated: true, completion: nil)
    }
}
