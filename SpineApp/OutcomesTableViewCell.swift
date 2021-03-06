//
//  OutcomesTableViewCell.swift
//  SpineApp
//
//  Created by Peter Cerhan on 7/16/17.
//  Copyright © 2017 Peter Cerhan. All rights reserved.
//

import UIKit

class OutcomesTableViewCell: UITableViewCell {

    @IBOutlet var detailsButton: UIButton!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var percentageLabel: UILabel!
    
    var detailsCallback: (() -> ())?
    
    @IBAction func detailsPressed() {
        detailsCallback?()
    }
}
