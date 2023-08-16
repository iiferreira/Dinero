//
//  ViewController.swift
//  PasswordReset
//
//  Created by Iuri Ferreira on 16/08/23.
//

import UIKit

class ResetPasswordViewController: UIViewController {
    
    let passwordStack = UIStackView()
    let lockImage = UIImageView()
    let passwordTextField = UITextField()
    let eyeImage = UIImageView()
    let divider = UIView()
    let infoLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        layout()
    }
    
    func setup() {
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showInfoLabel))
        
        view.addGestureRecognizer(tapGesture)
        
        passwordStack.translatesAutoresizingMaskIntoConstraints = false
        lockImage.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        eyeImage.translatesAutoresizingMaskIntoConstraints = false
        divider.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        passwordStack.axis = .horizontal
        passwordStack.spacing = 5
    
        lockImage.image = UIImage(systemName: "lock.fill")?.withRenderingMode(.automatic)
        eyeImage.image = UIImage(systemName: "eye.slash.circle")?.withRenderingMode(.automatic)
        
        passwordTextField.placeholder = "New Password"
        passwordTextField.textColor = .label
        passwordTextField.widthAnchor.constraint(equalToConstant: 220).isActive = true
        passwordTextField.isSecureTextEntry = true
        passwordTextField.enablePasswordToggle()
        
        divider.backgroundColor = .gray
        
        infoLabel.text = "Enter your password."
        infoLabel.textColor = .red
        infoLabel.isHidden = true
    }
    
    func layout() {
        passwordStack.addArrangedSubview(lockImage)
        passwordStack.addArrangedSubview(passwordTextField)
        //passwordStack.addArrangedSubview(eyeImage)
        
        view.addSubview(passwordStack)
        view.addSubview(divider)
        view.addSubview(infoLabel)
        
        NSLayoutConstraint.activate([
            passwordStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordStack.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            divider.topAnchor.constraint(equalTo: passwordStack.bottomAnchor, constant: 8),
            divider.leadingAnchor.constraint(equalTo: passwordStack.leadingAnchor),
            divider.trailingAnchor.constraint(equalTo: passwordStack.trailingAnchor),
            divider.heightAnchor.constraint(equalToConstant: 0.5)
        ])
        
        NSLayoutConstraint.activate([
            infoLabel.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 8),
            infoLabel.leadingAnchor.constraint(equalTo: passwordStack.leadingAnchor),
            infoLabel.trailingAnchor.constraint(equalTo: passwordStack.trailingAnchor),
        ])
    }
}

//MARK: -Tap Gesture
extension ResetPasswordViewController {
    @objc func showInfoLabel() {
        self.dismiss(animated: true)
    }
}


