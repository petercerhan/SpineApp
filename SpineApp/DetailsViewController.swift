//
//  DetailsViewController.swift
//  SpineApp
//
//  Created by Peter Cerhan on 7/18/17.
//  Copyright © 2017 Peter Cerhan. All rights reserved.
//

import UIKit

protocol DetailsViewControllerDelegate: NSObjectProtocol {
    func dismiss(_ detailsViewController: DetailsViewController)
}

class DetailsViewController: UIViewController {

    weak var delegate: DetailsViewControllerDelegate?
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionTextView: UITextView!
    @IBOutlet var doneButton: UIButton!
    
    private var data: DetailsViewControllerData
    
    init(nibName: String, delegate: DetailsViewControllerDelegate, data: DetailsViewControllerData) {
        self.delegate = delegate
        self.data = data
        
        super.init(nibName: nibName, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) should not be used with DetailsViewController. Use init(nibName:presenter:) instead")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = data.title
        descriptionTextView.text = data.description
        doneButton.setTitle(data.dismissTitle, for: .normal)
    }
    
    @IBAction func done() {
        delegate?.dismiss(self)
    }

}

struct DetailsViewControllerData {
    let title: String
    let description: String
    let dismissTitle: String
}

