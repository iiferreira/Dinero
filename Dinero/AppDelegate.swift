//
//  AppDelegate.swift
//  Dinero
//
//  Created by Iuri Ferreira on 20/06/23.
//

import UIKit

let appColor : UIColor = .systemTeal

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let defaults = UserDefaults()
    
    var accountViewController = AccountSummaryViewController()
    var loginViewController = LoginViewController()
    var onboardingContainerViewController = OnboardingContainerViewController()
    var mainViewController = MainViewController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground

        loginViewController.delegate = self
        onboardingContainerViewController.delegate = self
        accountViewController.delegate = self

        window?.rootViewController = loginViewController
        return true
    }
}

extension AppDelegate : LoginViewControllerDelegate {
    func didLogin() {
        
        if LocalState.hasOnboarded {
            setRootViewController(mainViewController)
        } else {
            setRootViewController(onboardingContainerViewController)
        }
    }
}

extension AppDelegate : OnboardingContainerViewControllerDelegate {
    func didFinishedOnboarding() {
        LocalState.hasOnboarded = true
        setRootViewController(mainViewController)
    }
}

extension AppDelegate : LogoutDelegate {
    func didLogout() {
        print("pew")
    }
}

extension AppDelegate {
    func setRootViewController(_ vc: UIViewController, animated: Bool = true) {
        guard animated, let window = self.window else {
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
            return
        }
        
        
        window.rootViewController = vc
        window.makeKeyAndVisible()
        UIView.transition(with: window,
                          duration: 0.7,
                          options: .transitionCrossDissolve,
                          animations: nil,
                          completion: nil)
        
    }
}
