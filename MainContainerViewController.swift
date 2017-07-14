//
//  MainContainerViewController.swift
//  SpineApp
//
//  Created by Peter Cerhan on 5/29/17.
//  Copyright © 2017 Peter Cerhan. All rights reserved.
//

import UIKit

class MainContainerViewController: UIViewController {
    
    private var contentViewController = UIViewController()
    let appStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    var hideStatusBar = true
    override var prefersStatusBarHidden: Bool {
        return hideStatusBar
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(contentViewController.view)
    }
    
    func show(viewController: UIViewController, animated: Bool) {
        if animated {
            updateAnimated(contentViewController: viewController)
        } else {
            print("this called")
            update(contentViewController: viewController)
        }
    }
    
    func update(contentViewController newViewController: UIViewController) {
        
        let priorViewController = contentViewController
        
        contentViewController = newViewController
        
        addChildViewController(newViewController)
        
        newViewController.view.frame = view.bounds
        view.addSubview(newViewController.view)
        
        priorViewController.willMove(toParentViewController: nil)
        newViewController.didMove(toParentViewController: self)
        
        //animate here
        
        priorViewController.view.removeFromSuperview()
        priorViewController.removeFromParentViewController()
    }
    
    func updateAnimated(contentViewController newViewController: UIViewController) {
        
        let priorViewController = contentViewController
        
        contentViewController = newViewController
        
        addChildViewController(newViewController)
        
        newViewController.view.frame = view.bounds
        newViewController.view.center.x += view.frame.width
        view.addSubview(newViewController.view)
        
        priorViewController.willMove(toParentViewController: nil)
        newViewController.didMove(toParentViewController: self)
        
        //animate here
        UIView.animate(withDuration: 0.3, animations: {
            _ in
            newViewController.view.center.x -= self.view.frame.width
            priorViewController.view.center.x -= self.view.frame.width
        }, completion:{
            _ in
            priorViewController.view.removeFromSuperview()
            priorViewController.removeFromParentViewController()
        })
        
    }
}




