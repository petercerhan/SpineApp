//
//  UserProfile.swift
//  SpineApp
//
//  Created by Peter Cerhan on 7/29/17.
//  Copyright © 2017 Peter Cerhan. All rights reserved.
//
//https://medium.com/@ryuichi/swift-struct-nscoding-107fc2d6ba5e

import Foundation

struct UserProfile {
    var disclaimerAgreed: Bool
}

//MARK: - NSCoding

extension UserProfile {
    class Coding: NSObject, NSCoding {
        let userProfile: UserProfile?
        
        init(userProfile: UserProfile) {
            self.userProfile = userProfile
        }
        
        required init?(coder decoder: NSCoder) {
            let disclaimerAgreed = decoder.decodeBool(forKey: "disclaimerAgreed")
            
            userProfile = UserProfile(disclaimerAgreed: disclaimerAgreed)
        }
        
        func encode(with aCoder: NSCoder) {
            guard let userProfile = userProfile else {
                return
            }
            
            aCoder.encode(userProfile.disclaimerAgreed, forKey: "disclaimerAgreed")
        }
    }
}
