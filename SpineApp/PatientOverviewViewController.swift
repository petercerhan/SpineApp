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
    
    init(nibName: String, presenter: PatientOverviewPresenter) {
        self.presenter = presenter
        
        super.init(nibName: nibName, bundle: nil)
        
        presenter.attach(view: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) should not be used with PatientOverviewViewController. Use init(nibName:presenter:) instead")
    }
    
    //actions
    
    @IBAction func done() {
        presenter.someAction()
    }
    
}
