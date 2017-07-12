//
//  NomogramManager.swift
//  SpineApp
//
//  Created by Peter Cerhan on 7/11/17.
//  Copyright © 2017 Peter Cerhan. All rights reserved.
//

import Foundation

class NomogramManager {
    
    var nomograms: [Nomogram]
    
    init(nomogramService: NomogramService) {
        if let nomogram1 = nomogramService.nomogram(named: "Failure of non-operative management"){
            nomograms = [nomogram1]
        } else {
            nomograms = [Nomogram]()
        }
    }
    
}
