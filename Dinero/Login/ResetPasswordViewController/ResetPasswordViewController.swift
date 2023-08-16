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
    
    let passwordStack = UIStackView()
    let lockImage = UIImageView()
    let passwordTextField = UITextField()
    let eyeImage = UIImageView()
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
        
        passwordStack.translatesAutoresizingMaskIntoConstraints = false
        lockImage.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        eyeImage.translatesAutoresizingMaskIntoConstraints = false
        divider.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        resetPasswordBtn.translatesAutoresizingMaskIntoConstraints = false
        
        
        passwordStack.axis = .horizontal
        passwordStack.spacing = 5
    
        lockImage.image = UIImage(systemName: "lock.fill")?.withRenderingMode(.automatic)
        eyeImage.image = UIImage(systemName: "eye.slash.circle")?.withRenderingMode(.automatic)
        
        passwordTextField.placeholder = "New Password"
        passwordTextField.textColor = .label
        passwordTextField.widthAnchor.constraint(equalToConstant: 220).isActive = true
        passwordTextField.isSecureTextEntry = true
        //passwordTextField.delegate = self
        passwordTextField.enablePasswordToggle()
        
        resetPasswordBtn.setTitle("Reset Password", for: .normal)
        resetPasswordBtn.configuration = .filled()
        resetPasswordBtn.configuration?.imagePadding = 8
        resetPasswordBtn.addTarget(self, action: #selector(resetPasswordTapped), for: .primaryActionTriggered)
        
        divider.backgroundColor = .gray
        
        infoLabel.text = "Enter your password."
        infoLabel.textColor = .red
        infoLabel.isHidden = true
    }
    
    func layout() {
        passwordStack.addArrangedSubview(lockImage)
        passwordStack.addArrangedSubview(passwordTextField)
        view.addSubview(resetPasswordBtn)
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
        
        NSLayoutConstraint.activate([
            resetPasswordBtn.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 12),
            resetPasswordBtn.leadingAnchor.constraint(equalTo: passwordStack.leadingAnchor),
            resetPasswordBtn.trailingAnchor.constraint(equalTo: passwordStack.trailingAnchor),
        ])
    }
}

//MARK: - Actions
extension ResetPasswordViewController {
    @objc func resetPasswordTapped() {
        if passwordTextField.text != "" {
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


