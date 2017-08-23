//
//  DisclaimerPresenter.swift
//  SpineApp
//
//  Created by Peter Cerhan on 7/13/17.
//  Copyright © 2017 Peter Cerhan. All rights reserved.
//

import Foundation

protocol DisclaimerPresenterDelegate: class {
    func sceneComplete(_ disclaimerPresenter: DisclaimerPresenter)
}

class DisclaimerPresenter {
    
    //MARK: - Dependencies
    
    weak var delegate: DisclaimerPresenterDelegate?
    weak var view: DisclaimerViewController?
    let userProfileManager: UserProfileManager

    //MARK: - Initialization
    
    init(delegate: DisclaimerPresenterDelegate, userProfileManager: UserProfileManager) {
        self.delegate = delegate
        self.userProfileManager = userProfileManager
    }
    
    //MARK: - Interface for view
    
    func attach(view: DisclaimerViewController) {
        self.view = view
    }
    
    func userAgreed() {
        userProfileManager.setDisclaimerAgreed(true)
        delegate?.sceneComplete(self)
    }
    
}
