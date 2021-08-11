//
//  NavigationManager.swift
//  BeverageDB
//
//  Created by Gugu Ndaba on 2021/08/06.
//

import Foundation
import UIKit

class NavigationManager {
    enum Screen {
        case onboarding
        case home
    }
    
    func show(screen: Screen, inController: UIViewController) {
        
        var viewController: UIViewController!
        
        switch screen {
        case .onboarding:
            viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "OnboardingVC")
            
        case .home:
            viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "HomeTabBar")
        }
        
        if let sceneDelegate = inController.view.window?.windowScene?.delegate as? SceneDelegate, let window = sceneDelegate.window {
            window.rootViewController = viewController
            UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil, completion: nil)
        }
    }
}
