//
//  DisclaimerPresenter.swift
//  SpineApp
//
//  Created by Peter Cerhan on 7/13/17.
//  Copyright © 2017 Peter Cerhan. All rights reserved.
//

import Foundation

protocol DisclaimerPresenterDelegate: NSObjectProtocol {
    func sceneComplete(_ disclaimerPresenter: DisclaimerPresenter)
}

class DisclaimerPresenter {
    
    weak var delegate: DisclaimerPresenterDelegate?
    weak var view: DisclaimerViewController?
    
    init(delegate: DisclaimerPresenterDelegate) {
        self.delegate = delegate
    }
    
    func attach(view: DisclaimerViewController) {
        self.view = view
    }
    
    //Presenter functions
    
    func userAgreed() {
        //update UserManager with disclaimerAgreed = true
        sceneComplete()
    }
    
    func sceneComplete() {
        delegate?.sceneComplete(self)
    }
    
}
