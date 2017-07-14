//
//  OpenScenePresenter.swift
//  SpineApp
//
//  Created by Peter Cerhan on 7/13/17.
//  Copyright © 2017 Peter Cerhan. All rights reserved.
//

import Foundation

protocol OpenScenePresenterDelegate: NSObjectProtocol {
    func sceneComplete(_ openScenePresenter: OpenScenePresenter)
}

class OpenScenePresenter {

    weak var delegate: OpenScenePresenterDelegate?
    weak var view: OpenSceneViewController?
    
    init(delegate: OpenScenePresenterDelegate) {
        self.delegate = delegate
    }
    
    func attach(view: OpenSceneViewController) {
        self.view = view
    }
    
    func sceneComplete() {
        delegate?.sceneComplete(self)
    }
}
