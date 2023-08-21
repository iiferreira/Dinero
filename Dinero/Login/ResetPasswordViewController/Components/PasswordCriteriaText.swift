//
//  PasswordCriteriaView.swift
//  Dinero
//
//  Created by Iuri Ferreira on 21/08/23.
//

import Foundation
import UIKit

enum CriteriaType {
    case success,fail
}

class PasswordCriteriaText : UIView {
    
    let text : String
    let criteriaType : CriteriaType
    
    let criteriaImage = UIImageView()
    let criteriaLabel = UILabel()
    let criteriaHStack = UIStackView()
    
    init(text:String, condition:CriteriaType) {
        self.text = text
        self.criteriaType = condition
        super.init(frame: .zero)
        style()
        layout()
        
        switch condition {
        case .success:
            let image = UIImage(systemName: "checkmark.circle")?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
            criteriaImage.image = image
        case .fail:
            let image = UIImage(systemName: "x.circle")?.withTintColor(.systemRed, renderingMode: .alwaysOriginal)
            criteriaImage.image = image
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 240, height: 22)
    }
    
    func style() {
        
        criteriaImage.translatesAutoresizingMaskIntoConstraints = false
        criteriaLabel.translatesAutoresizingMaskIntoConstraints = false
        criteriaHStack.translatesAutoresizingMaskIntoConstraints = false
        
        criteriaHStack.axis = .horizontal
        criteriaHStack.spacing = 7
        
        criteriaLabel.text = text
        criteriaLabel.textColor = .systemGray
        criteriaLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
    }
    
    func layout() {
        criteriaHStack.addArrangedSubview(criteriaImage)
        criteriaHStack.addArrangedSubview(criteriaLabel)
        addSubview(criteriaHStack)
        
        NSLayoutConstraint.activate([
            criteriaImage.heightAnchor.constraint(equalToConstant: 20),
            criteriaImage.widthAnchor.constraint(equalToConstant: 20),
            criteriaHStack.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
            criteriaHStack.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1)
        ])
    }
}
