//
//  OutcomesCoordinator.swift
//  SpineApp
//
//  Created by Peter Cerhan on 7/13/17.
//  Copyright © 2017 Peter Cerhan. All rights reserved.
//

import UIKit

protocol OutcomesCoordinatorDelegate: class {
    func outcomesComplete(_ outcomesCoordinator: OutcomesCoordinator)
}

class OutcomesCoordinator {
    
    //MARK: - Dependencies
    
    weak var delegate: OutcomesCoordinatorDelegate?
    let navigationController: UINavigationController
    let outcomesStateController: OutcomesStateController
    let compositionRoot: CompositionRootProtocol
    
    init(delegate: OutcomesCoordinatorDelegate, navigationController: UINavigationController, outcomesStateController: OutcomesStateController, compositionRoot: CompositionRootProtocol) {
        self.delegate = delegate
        self.navigationController = navigationController
        self.outcomesStateController = outcomesStateController
        self.compositionRoot = compositionRoot
    }
    
    func start() {
        let vc = compositionRoot.composeOutcomesScene(outcomesCoordinator: self, outcomesStateController: outcomesStateController)
        navigationController.setViewControllers([vc], animated: false)
    }
    
}

extension OutcomesCoordinator: OutcomesPresenterDelegate {
    func sceneComplete(_ outcomesPresenter: OutcomesPresenter) {
        delegate?.outcomesComplete(self)
    }
    
    func nomogramSelected(_ outcomesPresenter: OutcomesPresenter, atIndex index: Int) {
        let vc = compositionRoot.composeNomogramScene(outcomesCoordinator: self, outcomesStateController: outcomesStateController, nomogramIndex: index)
        navigationController.pushViewController(vc, animated: true)
    }
}

extension OutcomesCoordinator: NomogramPresenterDelegate {
    
    func sceneComplete(_ presenter: NomogramPresenter) {
        navigationController.popViewController(animated: true)
    }
    
}
