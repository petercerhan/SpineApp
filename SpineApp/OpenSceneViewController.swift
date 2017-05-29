//
//  ViewController.swift
//  SpineApp
//
//  Created by Peter Cerhan on 5/26/17.
//  Copyright © 2017 Peter Cerhan. All rights reserved.
//

import UIKit

protocol OpenSceneViewControllerDelegate: NSObjectProtocol {
    func openSceneComplete(_ openSceneViewController: OpenSceneViewController)
}

class OpenSceneViewController: UIViewController {

    var delegate: OpenSceneViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        delegate?.openSceneComplete(self)
    }

}

