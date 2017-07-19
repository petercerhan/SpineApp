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
    @IBOutlet var descriptionText: UITextView!
    @IBOutlet var doneButton: UIButton!
    
    init(nibName: String, delegate: DetailsViewControllerDelegate) {
        self.delegate = delegate
        
        super.init(nibName: nibName, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) should not be used with DetailsViewController. Use init(nibName:presenter:) instead")
    }
    
    @IBAction func done() {
        delegate?.dismiss(self)
    }

}
