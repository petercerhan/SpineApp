//
//  CompositionRoot.swift
//  SpineApp
//
//  Created by Peter Cerhan on 9/12/17.
//  Copyright © 2017 Peter Cerhan. All rights reserved.
//

import Foundation
import UIKit

protocol CompositionRootProtocol {
    func composeWindow() -> UIWindow
    func composeMainCoordinator() -> MainContainerCoordinator
    func composeOpenScene(mainContainerCoordinator: MainContainerCoordinator) -> OpenSceneViewController
    func composeOutcomesModule(mainContainerCoordinator: MainContainerCoordinator) -> OutcomesCoordinator
    func composeDisclaimerScene(mainContainerCoordinator: MainContainerCoordinator, userProfileStateController: UserProfileStateController) -> DisclaimerViewController
    func composeOutcomesScene(outcomesCoordinator: OutcomesCoordinator, outcomesStateController: OutcomesStateControllerProtocol) -> OutcomesViewController
    func composeNomogramScene(outcomesCoordinator: OutcomesCoordinator, outcomesStateController: OutcomesStateControllerProtocol, nomogramIndex: Int) -> NomogramViewController
}

class CompositionRoot: CompositionRootProtocol {
    
    func composeWindow() -> UIWindow {
        return UIWindow(frame: UIScreen.main.bounds)
    }
    
    func composeMainCoordinator() -> MainContainerCoordinator {
        return MainContainerCoordinator(containerViewController: ContainerViewController(),
                                        userProfileStateController: UserProfileStateController(userDefaults: UserDefaults.standard),
                                        compositionRoot: self)
    }
    
    func composeOpenScene(mainContainerCoordinator: MainContainerCoordinator) -> OpenSceneViewController {
        let presenter = OpenScenePresenter(delegate: mainContainerCoordinator)
        return OpenSceneViewController(nibName: "OpenSceneViewController",
                                       presenter: presenter)
    }
    
    func composeDisclaimerScene(mainContainerCoordinator: MainContainerCoordinator, userProfileStateController: UserProfileStateController) -> DisclaimerViewController {
        let presenter = DisclaimerPresenter(delegate: mainContainerCoordinator, userProfileStateController: userProfileStateController)
        return DisclaimerViewController(nibName: "DisclaimerViewController", presenter: presenter)
    }
    
    func composeOutcomesModule(mainContainerCoordinator: MainContainerCoordinator) -> OutcomesCoordinator {
        let nomogramService = NomogramService()
        let outcomesStateController = OutcomesStateController(nomogramService: nomogramService)
        
        let navigationController = UINavigationController()
        navigationController.navigationBar.isTranslucent = false
        
        return OutcomesCoordinator(delegate: mainContainerCoordinator,
                                   navigationController: navigationController,
                                   outcomesStateController: outcomesStateController,
                                   compositionRoot: self)
    }
    
    func composeOutcomesScene(outcomesCoordinator: OutcomesCoordinator, outcomesStateController: OutcomesStateControllerProtocol) -> OutcomesViewController {
        let presenter = OutcomesPresenter(delegate: outcomesCoordinator, outcomesStateController: outcomesStateController)
        return OutcomesViewController(nibName: "OutcomesViewController", presenter: presenter)
    }
    
    func composeNomogramScene(outcomesCoordinator: OutcomesCoordinator, outcomesStateController: OutcomesStateControllerProtocol, nomogramIndex: Int) -> NomogramViewController {
        let presenter = NomogramPresenter(delegate: outcomesCoordinator, outcomesStateController: outcomesStateController, nomogramIndex: nomogramIndex)
        return NomogramViewController(nibName: "NomogramViewController", presenter: presenter)
    }
    
}


