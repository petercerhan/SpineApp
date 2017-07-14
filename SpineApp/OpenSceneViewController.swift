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
        fatalError("init(coder:) should not be used with OpenScenViewController. Use init(nibName:presenter:) instead")
    }
    
    override func viewDidLoad() {
        super.viewDidLayoutSubviews()
        animateStuff()
    }
    
    func animateStuff() {
        //do the intro animation
        UIView.animate(withDuration: 0.4,
                       delay: 1.5,
                       options: .curveEaseOut,
                       animations: {self.label!.center.x += 100},
                       completion: {_ in self.presenter.sceneComplete()})
        
    }

}
