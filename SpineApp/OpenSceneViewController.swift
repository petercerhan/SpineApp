//
//  OpenSceneViewController.swift
//  SpineApp
//
//  Created by Peter Cerhan on 7/13/17.
//  Copyright © 2017 Peter Cerhan. All rights reserved.
//

import UIKit

class OpenSceneViewController: UIViewController {

    let presenter: OpenScenePresenter
    
    @IBOutlet var label: UILabel?
    
    init(nibName: String, presenter: OpenScenePresenter) {
        self.presenter = presenter
        
        super.init(nibName: nibName, bundle: nil)
        
        presenter.attach(view: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) should not be used with OpenSceneViewController. Use init(nibName:presenter:) instead")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        entrySequence()
    }
    
    func entrySequence() {

        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
            self.presenter.sceneComplete()
        })
        
    }

}
