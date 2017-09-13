//
//  AppDelegate.swift
//  SpineApp
//
//  Created by Peter Cerhan on 5/26/17.
//  Copyright © 2017 Peter Cerhan. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var compositionRoot: CompositionRootProtocol!
    var mainContainerCoordinator: MainContainerCoordinator!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        //Development Only
        UserDefaults.standard.removeObject(forKey: "userProfile")
        //
        
        compositionRoot = CompositionRoot()

        mainContainerCoordinator = compositionRoot.assembleMainCoordinator()
        mainContainerCoordinator.start()
        
        window = compositionRoot.assembleWindow()
        window?.rootViewController = mainContainerCoordinator.mainContainerViewController
        window?.makeKeyAndVisible()
        
        return true
    }

}


