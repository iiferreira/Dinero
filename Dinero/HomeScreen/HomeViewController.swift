//
//  HomeViewController.swift
//  Dinero
//
//  Created by Iuri Ferreira on 30/06/23.
//

import UIKit

class HomeViewController : UIViewController {
    
    weak var delegate : LogoutDelegate?
    
    let welcomeLabel = UILabel()
    let logoutButton = UIButton(type: .roundedRect)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        layout()
        
    }
    
    func style() {
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        welcomeLabel.text = "Welcome"
        welcomeLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.setTitle("Logout", for: [])
        logoutButton.setTitleColor(.white, for: .normal)
        logoutButton.backgroundColor = .blue
        logoutButton.layer.cornerRadius = 12
        logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .primaryActionTriggered)
    }
    
    func layout() {
        view.addSubview(welcomeLabel)
        view.addSubview(logoutButton)
        
        NSLayoutConstraint.activate([
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            welcomeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            logoutButton.topAnchor.constraint(equalToSystemSpacingBelow: welcomeLabel.bottomAnchor, multiplier: 2),
            logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoutButton.widthAnchor.constraint(equalToConstant: 180),
            logoutButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 44),
        ])
    }
}


// Button actions

extension HomeViewController {
    
    @objc func logoutButtonTapped(sender:UIButton) {
        delegate?.didLogout()
    }
    
}
