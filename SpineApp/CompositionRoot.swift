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
    func assembleWindow() -> UIWindow
    func assembleMainCoordinator() -> MainContainerCoordinator
}

class CompositionRoot: CompositionRootProtocol {
    
    func assembleWindow() -> UIWindow {
        return UIWindow(frame: UIScreen.main.bounds)
    }
    
    func assembleMainCoordinator() -> MainContainerCoordinator {
        return MainContainerCoordinator(containerViewController: MainContainerViewController())
    }
    
}

