//
//  ResetPasswordTextField.swift
//  ResetPasswordTextField
//
//  Created by Iuri Ferreira on 22/08/23.
//

import Foundation
import UIKit

class PasswordTextField : UIView {
    
    let placeholderText : String
    
    let lockImage = UIImageView(image: UIImage(systemName: "lock.fill")?.withRenderingMode(.alwaysOriginal))
    
    let textField = UITextField()
    let eyeButton = UIButton(type: .custom)
    let dividerView = UIView()
    let errorLabel = UILabel()
    
    init(placeholder: String) {
        self.placeholderText = placeholder
        super.init(frame: .zero)
        
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 220, height: 24)
    }
    
    func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        lockImage.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.placeholder = placeholderText
        textField.isSecureTextEntry = true
        textField.keyboardType = .asciiCapable
        
        eyeButton.translatesAutoresizingMaskIntoConstraints = false
        eyeButton.setImage(UIImage(systemName: "eye.circle"), for: .normal)
        eyeButton.setImage(UIImage(systemName: "eye.slash.circle"), for: .selected)
        eyeButton.addTarget(self, action: #selector(togglePasswordView), for: .touchUpInside)
        
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        dividerView.backgroundColor = .separator

        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.textColor = .systemRed
        errorLabel.font = .preferredFont(forTextStyle: .footnote)
        errorLabel.text = "Error label"
        errorLabel.numberOfLines = 0
        errorLabel.lineBreakMode = .byWordWrapping
        errorLabel.isHidden = false
        
    }
    
    func layout() {
        addSubview(lockImage)
        addSubview(textField)
        addSubview(eyeButton)
        addSubview(dividerView)
        addSubview(errorLabel)
        
        NSLayoutConstraint.activate([
            lockImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            lockImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            lockImage.widthAnchor.constraint(equalToConstant: 20),
            lockImage.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            textField.centerYAnchor.constraint(equalTo: centerYAnchor),
            textField.leadingAnchor.constraint(equalTo: lockImage.trailingAnchor, constant: 5),
            textField.trailingAnchor.constraint(equalTo: eyeButton.leadingAnchor, constant: 0.5),
            textField.widthAnchor.constraint(equalToConstant: 210)
        ])
        
        NSLayoutConstraint.activate([
            eyeButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            eyeButton.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            dividerView.topAnchor.constraint(equalTo: textField.bottomAnchor,constant: 1.5),
            dividerView.leadingAnchor.constraint(equalTo: lockImage.leadingAnchor),
            dividerView.trailingAnchor.constraint(equalTo: eyeButton.trailingAnchor),
            dividerView.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        NSLayoutConstraint.activate([
            errorLabel.topAnchor.constraint(equalTo: dividerView.bottomAnchor, constant: 1.5),
            errorLabel.leadingAnchor.constraint(equalTo: lockImage.leadingAnchor),
            errorLabel.trailingAnchor.constraint(equalTo: eyeButton.trailingAnchor)
        ])
        
        //CHCR
        
        lockImage.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
        textField.setContentHuggingPriority(.defaultLow, for: .horizontal)
      //  eyeButton.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
    }
}

extension PasswordTextField: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
  //      delegate?.editingDidEnd(self)
    }

    // Called when 'return' key pressed. Necessary for dismissing keyboard.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true) // resign first responder
        return true
    }
}

// MARK: - Actions
extension PasswordTextField {
    @objc func togglePasswordView(_ sender: Any) {
        textField.isSecureTextEntry.toggle()
        eyeButton.isSelected.toggle()
    }

    @objc func textFieldEditingChanged(_ sender: UITextField) {
       // delegate?.editingChanged(self)
    }
}

// MARK: - Validation
//extension PasswordTextField {
//    func validate() -> Bool {
//        if let customValidation = customValidation,
//            let customValidationResult = customValidation(text),
//            customValidationResult.0 == false {
//            showError(customValidationResult.1)
//            return false
//        }
//        clearError()
//        return true
//    }
//
//    private func showError(_ errorMessage: String) {
//        errorLabel.isHidden = false
//        errorLabel.text = errorMessage
//    }
//
//    private func clearError() {
//        errorLabel.isHidden = true
//        errorLabel.text = ""
//    }
//}
