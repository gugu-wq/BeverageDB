//
//  LoadingViewController.swift
//  BeverageDB
//
//  Created by Gugu Ndaba on 2021/08/06.
//

import Foundation
import UIKit

class LoadingViewController: UIViewController {
    
    private var OnboardingViewed: Bool!        //has the onboarding screen been seen?
    
    private let navigationManager = NavigationManager()
    private let storageManager = StorageManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        OnboardingViewed = storageManager.isOnboardingViewd()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showInitialScreen()
    }
    
    private func showInitialScreen() {
        if OnboardingViewed {
            navigationManager.show(screen: .home, inController: self)
        } else {
            navigationManager.show(screen: .onboarding, inController: self)
        }
    }
}
