//
//  UIViewController.swift
//  SpineApp
//
//  Created by Peter Cerhan on 7/28/17.
//  Copyright © 2017 Peter Cerhan. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func confirmationAlert(title: String?, message: String, cancelButtonTitle: String, confirmButtonTitle: String, confirmAction: @escaping () -> ()) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: confirmButtonTitle, style: .default, handler: {_ in confirmAction()})
        alert.addAction(confirmAction)
        
        let cancelAction = UIAlertAction(title: cancelButtonTitle, style: .default, handler: nil)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
}
