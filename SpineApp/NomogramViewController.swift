//
//  NomogramViewController.swift
//  SpineApp
//
//  Created by Peter Cerhan on 7/24/17.
//  Copyright © 2017 Peter Cerhan. All rights reserved.
//

import UIKit

class NomogramViewController: UIViewController {

    fileprivate var presenter: NomogramPresenter
    
    fileprivate var nomogramElements = [NomogramViewControllerElement]()
    var score: Double = 0 {
        didSet {
            scoreLabel.text = "\(score)"
        }
    }
    
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var scoreLabel: UILabel!
    
    init(nibName: String, presenter: NomogramPresenter) {
        self.presenter = presenter
        
        super.init(nibName: nibName, bundle: nil)
        
        presenter.attach(view: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) should not be used with NomogramViewController. Use init(nibName:presenter:) instead")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Nomogram"
        
        tableView.register(UINib(nibName:"NomogramTableViewCell", bundle: nil), forCellReuseIdentifier: "NomogramTableViewCell")
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
        
        presenter.loadData()
    }
    
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
        cell.scoreLabel.text = element.present ? "\(element.points)" : "0"
        cell.checkLabel.text = element.present ? "x" : ""
        
        return cell
    }
    
}

extension NomogramViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        presenter.updatePresent(atIndex: indexPath.item)
    }
    
}

