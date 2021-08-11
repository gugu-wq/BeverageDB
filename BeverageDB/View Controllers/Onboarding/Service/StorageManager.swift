//
//  StorageManager.swift
//  BeverageDB
//
//  Created by Gugu Ndaba on 2021/08/06.
//

import Foundation

class StorageManager {
    
    enum Key: String {
        case onboardingSeen
    }
    
    func isOnboardingViewd() -> Bool {
        UserDefaults.standard.bool(forKey: Key.onboardingSeen.rawValue) //'rawValue' -> turns Key into type that you specified; string in this case.
    }
    
    func setOnboardingViewed() {
        UserDefaults.standard.set(true, forKey: Key.onboardingSeen.rawValue)
    }
    
    func resetOnboardingViewed() {        //resets 'onboardingSeen' to false, ie. it will show again when app is launched
        UserDefaults.standard.set(false, forKey: Key.onboardingSeen.rawValue)
    }
}
