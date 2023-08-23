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
    
    let criteriaVStack = UIStackView()
    let passwordTextField = PasswordTextField(placeholder: "Enter password.")
    let passwordStatusView = PasswordStatusView()
    let confirmPasswordTextField = PasswordTextField(placeholder: "Re-enter new password.")

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setup()
        layout()
        
    }
    
    func setup() {
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        confirmPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordStatusView.translatesAutoresizingMaskIntoConstraints = false
        criteriaVStack.translatesAutoresizingMaskIntoConstraints = false
        
        criteriaVStack.axis = .vertical
        criteriaVStack.spacing = 20
    }
    
    func layout() {
        view.addSubview(criteriaVStack)
        criteriaVStack.addArrangedSubview(passwordTextField)
        criteriaVStack.addArrangedSubview(passwordStatusView)
        criteriaVStack.addArrangedSubview(confirmPasswordTextField)
        
        NSLayoutConstraint.activate([
            criteriaVStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            criteriaVStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            criteriaVStack.widthAnchor.constraint(equalToConstant: 260)
        ])
    }

}

//MARK: - Actions
extension ResetPasswordViewController {
//    @objc func resetPasswordTapped() {
//        if passwordTextField.textField.text != "" {
//            delegate?.resetPassword()
//        } else {
//            infoLabel.isHidden = false
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
//                self.fadeAnimation()
//            }
//        }
//    }
//
//    @objc func backButtonTapped() {
//        delegate?.resetPassword()
//    }
}

//MARK: - Animations

extension ResetPasswordViewController {
    private func fadeAnimation() {
        let animator = UIViewPropertyAnimator(duration: 1.2, curve: .easeInOut) {
            self.passwordTextField.errorLabel.alpha = 0
        }
        animator.startAnimation(afterDelay: 0.65)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.passwordTextField.errorLabel.isHidden = true
            self.passwordTextField.errorLabel.alpha = 1
        }
    }
}


