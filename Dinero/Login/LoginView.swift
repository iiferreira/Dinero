//
//  LoginView.swift
//  Dinero
//
//  Created by Iuri Ferreira on 20/06/23.
//

import Foundation
import UIKit

class LoginView : UIView {
    
    let loginTextField = UITextField()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 200)
    }
    
}

extension LoginView {
    func style() {
        translatesAutoresizingMaskIntoConstraints = false
        
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        loginTextField.placeholder = ""
        backgroundColor = .gray
    }
    
    func layout() {
        addSubview(loginTextField)
       
        
        NSLayoutConstraint.activate([
            loginTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 1),
            loginTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 1),
            loginTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -1)
        ])

    }
}
