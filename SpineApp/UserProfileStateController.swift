//
//  UserProfileStateController.swift
//  SpineApp
//
//  Created by Peter Cerhan on 7/29/17.
//  Copyright © 2017 Peter Cerhan. All rights reserved.
//

import Foundation

class UserProfileStateController {
    
    //MARK: - Dependencies
    
    let userDefaults: UserDefaults
    
    //MARK: - State
    
    var userProfile: UserProfile

    //MARK: - Initialization
    
    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
        
        if let data = userDefaults.object(forKey: "userProfile") as? Data,
            let userProfileCoded = NSKeyedUnarchiver.unarchiveObject(with: data) as? UserProfile.Coding,
            let userProfile = userProfileCoded.userProfile {
                self.userProfile = userProfile
        } else {
                userProfile = UserProfile(disclaimerAgreed: false)
        }
    }
    
    //MARK: - Interface
    
    func disclaimerAgreed() -> Bool {
        return userProfile.disclaimerAgreed
    }
    
    func setDisclaimerAgreed(_ agreed: Bool) {
        userProfile.disclaimerAgreed = agreed
        let data = NSKeyedArchiver.archivedData(withRootObject: UserProfile.Coding(userProfile: userProfile))
        userDefaults.set(data, forKey: "userProfile")
    }
    
}
