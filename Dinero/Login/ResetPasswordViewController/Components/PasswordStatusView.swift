//
//  PasswordCriteriaView.swift
//  Dinero
//
//  Created by Iuri Ferreira on 21/08/23.
//

import UIKit
import Foundation

class PasswordStatusView : UIView {
    
    let imageView = UIImageView()
    
    let checkmarkImage = UIImage(systemName: "checkmark.circle")?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
    let xmarkImage = UIImage(systemName: "xmark.circle")?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
    let circleImage = UIImage(systemName: "circle")?.withTintColor(.tertiaryLabel, renderingMode: .alwaysOriginal)
    
    var isCriteriaMet: Bool = false {
        didSet {
            if isCriteriaMet {
                imageView.image = checkmarkImage
            } else {
                imageView.image = xmarkImage
            }
        }
    }
    
    func reset() {
        isCriteriaMet = false
        imageView.image = circleImage
    }
    
    let passwordCriteriaVStack = UIStackView()
    
    var lenghtCriteriaView = PasswordCriteriaText(text: "8-32 characters", condition: .fail)
    var uppercaseCriteriaView = PasswordCriteriaText(text: "uppercase letter (A-Z)", condition: .success)
    var lowercaseCriteriaView = PasswordCriteriaText(text: "lowercase letter (a-z)", condition: .fail)
    var digitCriteriaView = PasswordCriteriaText(text: "digit (0-9)", condition: .success)
    var specialCharacterCriteriaView = PasswordCriteriaText(text: "special characater (e.g. !@#$%^&)", condition: .fail)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 320, height: 150)
    }
    
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
    
    func setup() {
        backgroundColor = .systemFill
        layer.cornerRadius = 6
        clipsToBounds = true
        
        passwordCriteriaVStack.translatesAutoresizingMaskIntoConstraints = false
        lenghtCriteriaView.translatesAutoresizingMaskIntoConstraints = false
        uppercaseCriteriaView.translatesAutoresizingMaskIntoConstraints = false
        lowercaseCriteriaView.translatesAutoresizingMaskIntoConstraints = false
        digitCriteriaView.translatesAutoresizingMaskIntoConstraints = false
        specialCharacterCriteriaView.translatesAutoresizingMaskIntoConstraints = false
        
        passwordCriteriaVStack.axis = .vertical
        passwordCriteriaVStack.spacing = 5

        
    }
    
    func layout() {
        passwordCriteriaVStack.addArrangedSubview(lenghtCriteriaView)
        passwordCriteriaVStack.addArrangedSubview(uppercaseCriteriaView)
        passwordCriteriaVStack.addArrangedSubview(lowercaseCriteriaView)
        passwordCriteriaVStack.addArrangedSubview(digitCriteriaView)
        passwordCriteriaVStack.addArrangedSubview(specialCharacterCriteriaView)
        
        addSubview(passwordCriteriaVStack)
        
        NSLayoutConstraint.activate([
            passwordCriteriaVStack.centerYAnchor.constraint(equalTo: centerYAnchor),
            passwordCriteriaVStack.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
    }
}

