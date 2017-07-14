//
//  MainContainerCoordinator.swift
//  SpineApp
//
//  Created by Peter Cerhan on 7/13/17.
//  Copyright © 2017 Peter Cerhan. All rights reserved.
//

import Foundation

class MainContainerCoordinator: NSObject {
    
    let mainContainerViewController: MainContainerViewController
    
    init(containerViewController: MainContainerViewController) {
        mainContainerViewController = containerViewController
    }
    
    func start() {
        let presenter = OpenScenePresenter(delegate: self)
        let vc = OpenSceneViewController(nibName: "OpenSceneViewController", presenter: presenter)
        
        mainContainerViewController.show(viewController: vc, animated: false)
    }
    
}

extension MainContainerCoordinator: OpenScenePresenterDelegate {
    func sceneComplete(_ openScenePresenter: OpenScenePresenter) {
        print("Open scene complete")
    }
}
