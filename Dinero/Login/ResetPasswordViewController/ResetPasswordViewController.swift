//
//  ViewController.swift
//  PasswordReset
//
//  Created by Iuri Ferreira on 16/08/23.
//

import UIKit

protocol ResetPasswordDelegate : AnyObject {
    func resetPassword()
}

class ResetPasswordViewController: UIViewController {
    
    weak var delegate : ResetPasswordDelegate?
    
    let passwordTextField = PasswordTextField(placeholderText: "New Password")
    let divider = UIView()
    let infoLabel = UILabel()
    
    // Buttons
    
    let resetPasswordBtn = UIButton(type: .system)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        layout()
    }
    
    func setup() {
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        divider.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        resetPasswordBtn.translatesAutoresizingMaskIntoConstraints = false
        
        resetPasswordBtn.setTitle("Reset Password", for: .normal)
        resetPasswordBtn.configuration = .filled()
        resetPasswordBtn.configuration?.imagePadding = 8
        resetPasswordBtn.addTarget(self, action: #selector(resetPasswordTapped), for: .primaryActionTriggered)
        
        divider.backgroundColor = .separator
        
        infoLabel.text = "Enter your password."
        infoLabel.textColor = .red
        infoLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        infoLabel.isHidden = true
    }
    
    func layout() {
        view.addSubview(passwordTextField)
        view.addSubview(divider)
        view.addSubview(infoLabel)
        view.addSubview(resetPasswordBtn)
        
        NSLayoutConstraint.activate([
            passwordTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        NSLayoutConstraint.activate([
            divider.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 0.5),
            divider.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
            divider.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
            divider.heightAnchor.constraint(equalToConstant: 1.5)
        ])
        
        NSLayoutConstraint.activate([
            infoLabel.topAnchor.constraint(equalToSystemSpacingBelow: divider.bottomAnchor, multiplier: 1),
            infoLabel.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
            infoLabel.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
        ])

        NSLayoutConstraint.activate([
            resetPasswordBtn.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 12),
            resetPasswordBtn.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
            resetPasswordBtn.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
        ])
    }
}

//MARK: - Actions
extension ResetPasswordViewController {
    @objc func resetPasswordTapped() {
        if passwordTextField.textfield.text != "" {
            delegate?.resetPassword()
        } else {
            infoLabel.isHidden = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                self.fadeAnimation()
            }
        }
    }
}

//MARK: - Animations

extension ResetPasswordViewController {
    private func fadeAnimation() {
        let animator = UIViewPropertyAnimator(duration: 0.45, curve: .easeInOut) {
            self.infoLabel.alpha = 0
        }
        animator.startAnimation(afterDelay: 0.25)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.infoLabel.isHidden = true
            self.infoLabel.alpha = 1
        }
    }
}


