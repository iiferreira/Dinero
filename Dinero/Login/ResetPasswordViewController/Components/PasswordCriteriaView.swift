//
//  PasswordCriteriaView.swift
//  Dinero
//
//  Created by Iuri Ferreira on 21/08/23.
//

import UIKit

class PasswordCriteriaView : UIView {
    
    let passwordCriteriaVStack = UIStackView()
    
    let charCondition = PasswordCriteriaText(text: "8-32 characters", condition: .fail)
    let upperCaseLetterCondition = PasswordCriteriaText(text: "uppercase letter (A-Z)", condition: .success)
    let lowerCaserLetterCondition = PasswordCriteriaText(text: "lowercase letter (a-z)", condition: .fail)
    let digitCondition = PasswordCriteriaText(text: "digit (0-9)", condition: .success)
    let specialCharCondition = PasswordCriteriaText(text: "special characater (e.g. !@#$%^&)", condition: .fail)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 260, height: 150)
    }
    
    func setup() {
        backgroundColor = .systemFill
        layer.cornerRadius = 12
        
        passwordCriteriaVStack.translatesAutoresizingMaskIntoConstraints = false
        charCondition.translatesAutoresizingMaskIntoConstraints = false
        upperCaseLetterCondition.translatesAutoresizingMaskIntoConstraints = false
        lowerCaserLetterCondition.translatesAutoresizingMaskIntoConstraints = false
        digitCondition.translatesAutoresizingMaskIntoConstraints = false
        specialCharCondition.translatesAutoresizingMaskIntoConstraints = false
        
        passwordCriteriaVStack.axis = .vertical
        passwordCriteriaVStack.spacing = 5
    }
    
    func layout() {
        passwordCriteriaVStack.addArrangedSubview(charCondition)
        passwordCriteriaVStack.addArrangedSubview(upperCaseLetterCondition)
        passwordCriteriaVStack.addArrangedSubview(lowerCaserLetterCondition)
        passwordCriteriaVStack.addArrangedSubview(digitCondition)
        passwordCriteriaVStack.addArrangedSubview(specialCharCondition)
        
        addSubview(passwordCriteriaVStack)
        
        NSLayoutConstraint.activate([
            passwordCriteriaVStack.topAnchor.constraint(equalTo: topAnchor, constant: 1),
            passwordCriteriaVStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 1)
        ])
        
    }
}
