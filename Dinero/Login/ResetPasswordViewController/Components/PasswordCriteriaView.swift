//
//  PasswordCriteriaView.swift
//  Dinero
//
//  Created by Iuri Ferreira on 21/08/23.
//

import UIKit

class PasswordCriteriaView : UIView {
    
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
    
    var charCondition = PasswordCriteriaText(text: "8-32 characters", condition: .fail)
    var upperCaseLetterCondition = PasswordCriteriaText(text: "uppercase letter (A-Z)", condition: .success)
    var lowerCaserLetterCondition = PasswordCriteriaText(text: "lowercase letter (a-z)", condition: .fail)
    var digitCondition = PasswordCriteriaText(text: "digit (0-9)", condition: .success)
    var specialCharCondition = PasswordCriteriaText(text: "special characater (e.g. !@#$%^&)", condition: .fail)
    
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

