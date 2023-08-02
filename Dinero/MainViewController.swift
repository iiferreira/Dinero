//
//  MainViewController.swift
//  Dinero
//
//  Created by Iuri Ferreira on 03/07/23.
//

import UIKit

class MainViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupTabBar()
        
    }
    
    private func setupViews() {
        let summaryVC = AccountSummaryViewController()
        let moneyVC = MoveMoneyViewController()
        let moreVC = MoreViewController()
        
        summaryVC.setTabBarImage(imageName: "list.dash.header.rectangle", title: "Summary")
        moneyVC.setTabBarImage(imageName: "arrow.left.arrow.right", title: "Move Money")
        moreVC.setTabBarImage(imageName: "ellipsis.circle", title: "More")
        
        let summaryNC = UINavigationController(rootViewController: summaryVC)
        let moneyNC = UINavigationController(rootViewController: moneyVC)
        let moreNC = UINavigationController(rootViewController: moreVC)
        
        summaryNC.navigationBar.tintColor = appColor
        
        let tabBarList = [summaryNC,moneyNC,moreNC]
        
        viewControllers = tabBarList
    }
    
    private func hideNavigationBarLine(_ navigationBar: UINavigationBar) {
        let img = UIImage()
        navigationBar.shadowImage = img
        navigationBar.setBackgroundImage(img, for: .default)
        navigationBar.isTranslucent = false
    }
    
    private func setupTabBar() {
        tabBar.tintColor = appColor
        tabBar.isTranslucent = false
    }
    
}

//class DummySummaryViewController : UIViewController {
//    
//    weak var delegate : LogoutDelegate?
//    let logoutButton = UIButton(type: .system)
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .orange
//        style()
//        layout()
//    }
//    
//    private func style() {
//        logoutButton.translatesAutoresizingMaskIntoConstraints = false
//        logoutButton.setTitle("Logout", for: [])
//        logoutButton.tintColor = .blue
//        logoutButton.addTarget(self, action: #selector(logoutTapped), for: .primaryActionTriggered)
//    }
//    
//    private func layout() {
//        view.addSubview(logoutButton)
//        
//        NSLayoutConstraint.activate([
//            logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            logoutButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            logoutButton.widthAnchor.constraint(equalToConstant: 100),
//            logoutButton.heightAnchor.constraint(equalToConstant: 44)
//        ])
//    }
//}

class MoveMoneyViewController : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
    }
}

class MoreViewController : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
    }
}
