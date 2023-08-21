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
//    let digitCondition = PasswordCriteriaText(text: "digit (0-9)", condition: .success)
//    let specialCharCondition = PasswordCriteriaText(text: "special characater", condition: .fail)
    let passwordCriteriaView = PasswordCriteriaView()
    
    // Buttons
    
    let resetPasswordBtn = UIButton(type: .system)
    let backButton = UIButton(type: .system)
    
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
        backButton.translatesAutoresizingMaskIntoConstraints = false
        passwordCriteriaView.translatesAutoresizingMaskIntoConstraints = false
        
        resetPasswordBtn.setTitle("Reset Password", for: .normal)
        resetPasswordBtn.configuration = .filled()
        resetPasswordBtn.configuration?.imagePadding = 8
        resetPasswordBtn.addTarget(self, action: #selector(resetPasswordTapped), for: .primaryActionTriggered)
        
        backButton.setTitle("Back", for: .normal)
        backButton.configuration = .filled()
        backButton.configuration?.imagePadding = 8
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .primaryActionTriggered)
        
        divider.backgroundColor = .separator
        
        infoLabel.text = "Enter your password."
    
        infoLabel.textColor = .systemRed
        infoLabel.numberOfLines = 0
        infoLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        infoLabel.isHidden = true
        
        passwordCriteriaView.charCondition.criteriaType = randomCriteria()
        passwordCriteriaView.upperCaseLetterCondition.criteriaType = randomCriteria()
        passwordCriteriaView.lowerCaserLetterCondition.criteriaType = randomCriteria()

    }
    
    func layout() {
        view.addSubview(passwordTextField)
        view.addSubview(divider)
        view.addSubview(infoLabel)
        view.addSubview(passwordCriteriaView)

//        view.addSubview(resetPasswordBtn)
//        view.addSubview(backButton)
        
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
            infoLabel.topAnchor.constraint(equalToSystemSpacingBelow: divider.bottomAnchor, multiplier: 0.2),
            infoLabel.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
            infoLabel.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
            infoLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            passwordCriteriaView.topAnchor.constraint(equalToSystemSpacingBelow: infoLabel.bottomAnchor, multiplier: 1),
            passwordCriteriaView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        
        ])

//        NSLayoutConstraint.activate([
//            resetPasswordBtn.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 12),
//            resetPasswordBtn.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
//            resetPasswordBtn.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
//        ])
//        
//        NSLayoutConstraint.activate([
//           backButton.topAnchor.constraint(equalTo: resetPasswordBtn.bottomAnchor, constant: 12),
//           backButton.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
//           backButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
//        ])
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
    
    @objc func backButtonTapped() {
        delegate?.resetPassword()
    }
}

//MARK: - Animations

extension ResetPasswordViewController {
    private func fadeAnimation() {
        let animator = UIViewPropertyAnimator(duration: 1.2, curve: .easeInOut) {
            self.infoLabel.alpha = 0
        }
        animator.startAnimation(afterDelay: 0.65)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.infoLabel.isHidden = true
            self.infoLabel.alpha = 1
        }
    }
}


//MARK: - Random View Will Appear Test
extension ResetPasswordViewController {
    func randomCriteria() -> CriteriaType {
        let i = Int.random(in: 0...1)
        var criteria : CriteriaType?
        
        if i == 0 {
            criteria = CriteriaType.success
        } else if ( i == 1) {
            criteria = CriteriaType.fail
        }
        
        return criteria!
    }
}
