//
//  OnboardingViewController.swift
//  Dinero
//
//  Created by Iuri Ferreira on 26/06/23.
//

import UIKit

class OnboardingViewController : UIViewController {
    
    var heroImage : UIImage?
    var titleText : String?
    
    let stackView = UIStackView()
    
    let image = UIImageView()
    
    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    
    init(heroImage: String, titleText: String) {
        super.init(nibName: nil, bundle: nil)
        self.heroImage = UIImage(named: heroImage)
        self.titleText = titleText
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func style() {
        view.backgroundColor = .systemBackground
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.image = heroImage
        
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = self.titleText
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        label.textAlignment = .center
        
    }
    
    private func layout() {
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(image)
        stackView.addArrangedSubview(label)
        
        // Image View
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        // Bankey Label
        NSLayoutConstraint.activate([
            label.heightAnchor.constraint(equalToConstant: 100),
            label.widthAnchor.constraint(equalToConstant: 330)
        ])
    }
}


