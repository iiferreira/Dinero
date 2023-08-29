//
//  ViewController.swift
//  PasswordReset
//
//  Created by Iuri Ferreira on 16/08/23.
//

import UIKit

class ResetPasswordViewController: UIViewController {
    
    //let criteria = PasswordCriteria()
    typealias CustomValidation = PasswordTextField.CustomValidation
    
    let stackView = UIStackView()
    let newPasswordTextField = PasswordTextField(placeHolderText: "New password")
    let statusView = PasswordStatusView()
    let confirmPasswordTextField = PasswordTextField(placeHolderText: "Re-enter new password")
    let resetButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        style()
        layout()
    }
}

extension ResetPasswordViewController {
    
    func setup() {
        
        setupDismissPasswordGesture()
    }
    
    private func setupNewPassword() {
        let newPasswordValidation : CustomValidation = { text in
            
            guard let text = text, !text.isEmpty else {
                self.statusView.reset()
                return(false, "Enter your password!")
            }
            return(true,"")
        }
        newPasswordTextField.customValidation = newPasswordValidation
    }
    
    private func setupDismissPasswordGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapOutGesture(_:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    func style() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        newPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        newPasswordTextField.delegate = self
        
        statusView.translatesAutoresizingMaskIntoConstraints = false
        statusView.layer.cornerRadius = 5
        statusView.clipsToBounds = true
        
        confirmPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        confirmPasswordTextField.delegate = self
        
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.configuration = .filled()
        resetButton.setTitle("Reset password", for: [])
        resetButton.addTarget(self, action: #selector(resetPassword(_:)), for: .touchUpInside)
        // resetButton.addTarget(self, action: #selector(resetPasswordButtonTapped), for: .primaryActionTriggered)
        
    }
    
    func layout() {
        stackView.addArrangedSubview(newPasswordTextField)
        stackView.addArrangedSubview(statusView)
        stackView.addArrangedSubview(confirmPasswordTextField)
        stackView.addArrangedSubview(resetButton)
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 2),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
    }
}

//MARK: - Actions
extension ResetPasswordViewController {
    
    @objc func resetPassword(_ sender: UIButton) {
        if newPasswordTextField.text == confirmPasswordTextField.text && newPasswordTextField.text != "" {
            print("Password Match")
        } else {
            print("Something wrong")
        }
    }
    
}



//MARK: - Delegate Methods
extension ResetPasswordViewController: PasswordTextFieldDelegate {
    func editingChanged(_ sender: PasswordTextField) {
        if sender === newPasswordTextField {
            statusView.updateDisplay(sender.textField.text ?? "")
        }
    }
    
    func editingDidEnd(_ sender: PasswordTextField) {
        if sender === newPasswordTextField {
            _ = newPasswordTextField.validate()
        }
    }
    
    @objc func tapOutGesture(_ recognizer: UITapGestureRecognizer) {
        print("Fora")
        newPasswordTextField.textField.resignFirstResponder()
    }
}


