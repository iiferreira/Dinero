//
//  PasswordTextField.swift
//  Dinero
//
//  Created by Iuri Ferreira on 16/08/23.
//

import Foundation
import UIKit

class PasswordTextField : UIView {
    
    let placeholderText: String
    
    let passwordStack = UIStackView()
    let lockImage = UIImageView()
    let passwordTextField = UITextField()
    let eyeImage = UIImageView()
    
    init(placeholderText: String ) {
        self.placeholderText = placeholderText
        
        super.init(frame: .zero)
        
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 240, height: 44)
    }
    
    func setup() {
        passwordStack.translatesAutoresizingMaskIntoConstraints = false
        lockImage.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        eyeImage.translatesAutoresizingMaskIntoConstraints = false
        
        passwordStack.axis = .horizontal
        passwordStack.spacing = 5
    
        lockImage.image = UIImage(systemName: "lock.fill")?.withRenderingMode(.automatic)
        eyeImage.image = UIImage(systemName: "eye.slash.circle")?.withRenderingMode(.automatic)
        
        passwordTextField.placeholder = placeholderText
        passwordTextField.textColor = .label
        passwordTextField.widthAnchor.constraint(equalToConstant: 220).isActive = true
        passwordTextField.isSecureTextEntry = true
        //passwordTextField.delegate = self
        passwordTextField.enablePasswordToggle()
        
    }
    
    func layout() {
        passwordStack.addArrangedSubview(lockImage)
        passwordStack.addArrangedSubview(passwordTextField)
        addSubview(passwordStack)
        
        NSLayoutConstraint.activate([
            passwordStack.topAnchor.constraint(equalTo: topAnchor),
            passwordStack.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }
    
}
