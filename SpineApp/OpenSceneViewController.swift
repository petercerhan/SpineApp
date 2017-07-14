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
    
    init(nibName: String, presenter: OpenScenePresenter) {
        self.presenter = presenter
        
        super.init(nibName: nibName, bundle: nil)
        
        presenter.attach(view: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) should not be used with OpenScenViewController. Use init(nibName:presenter:) instead")
    }
    
    func animateStuff() {
        //do the intro animation
        
        
    }

}