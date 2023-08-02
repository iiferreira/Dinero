//
//  ViewController.swift
//  Dinero
//
//  Created by Iuri Ferreira on 20/06/23.
//

import UIKit

protocol LogoutDelegate : AnyObject {
    func didLogout()
}

protocol LoginViewControllerDelegate : AnyObject {
    func didLogin()
}

class LoginViewController: UIViewController {

    weak var delegate : LoginViewControllerDelegate?
    
    let logoLabel = UILabel()
    let subtitleLabel = UILabel()
    let loginView = LoginView()
    let signInButton = UIButton(type: .system)
    let errorMessageLabel = UILabel()
    
    var username : String? {
        return loginView.usernameTextField.text
    }
    
    var password : String? {
        return loginView.passwordTextfield.text
    }
    
    // animation
    
    var leadingEdgeOnScreen : CGFloat = 120
    var leadingEdgeOffScreen : CGFloat = -1000
    
    var titleLeadingAnchor : NSLayoutConstraint?
    
    var subtitleTrailingEdgeOnScreen : CGFloat = 280
    var subtitleTrailingEdgeOffScreen : CGFloat = 1000
    
    var subtitleTrailingAnchor : NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        style()
        layout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animate()
        subtitleAnimate()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        signInButton.configuration?.showsActivityIndicator = false
        loginView.passwordTextfield.text = ""
    }

}


extension LoginViewController {
    private func style() {
        loginView.usernameTextField.text = defaultUser.username
        
        logoLabel.translatesAutoresizingMaskIntoConstraints = false
        logoLabel.text = "Dinero"
        logoLabel.textColor = .systemOrange
        logoLabel.font = UIFont.systemFont(ofSize: 48)
        
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.text = "Your premium source for all \n things banking!"
        subtitleLabel.textAlignment = .center
        subtitleLabel.textColor = .label
        subtitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .light)
        subtitleLabel.numberOfLines = 0
        
        loginView.translatesAutoresizingMaskIntoConstraints = false
        
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.setTitle("Sign In", for: .normal)
        signInButton.configuration = .filled()
        signInButton.configuration?.imagePadding = 8
        signInButton.addTarget(self, action: #selector(signInTapped), for: .primaryActionTriggered)
        
        errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        //errorMessageLabel.text = "Username / Password cannot be blank"
        errorMessageLabel.numberOfLines = 0
        errorMessageLabel.textColor = .systemRed
        errorMessageLabel.isHidden = true
        
    }
    
    private func layout() {
        view.addSubview(logoLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(loginView)
        view.addSubview(signInButton)
        view.addSubview(errorMessageLabel)
        
        // Title
        NSLayoutConstraint.activate([
            logoLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
            logoLabel.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 15)
        ])
        
        titleLeadingAnchor = logoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingEdgeOffScreen)
        titleLeadingAnchor?.isActive = true
        
        // Subtitle
        NSLayoutConstraint.activate([
            subtitleLabel.topAnchor.constraint(equalTo: logoLabel.bottomAnchor, constant: 3),
            //subtitleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            subtitleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10)
        ])
        
        subtitleTrailingAnchor = subtitleLabel.trailingAnchor.constraint(equalTo: view.leadingAnchor, constant: subtitleTrailingEdgeOffScreen)
        subtitleTrailingAnchor?.isActive = true
        
        // LoginView
        NSLayoutConstraint.activate([
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 1),
        ])
        
        // Button
        NSLayoutConstraint.activate([
            signInButton.topAnchor.constraint(equalToSystemSpacingBelow: loginView.bottomAnchor, multiplier: 2),
            signInButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            signInButton.heightAnchor.constraint(equalToConstant: 44),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: signInButton.trailingAnchor, multiplier: 1)
        ])
        
        // Error label
        
        NSLayoutConstraint.activate([
            errorMessageLabel.topAnchor.constraint(equalToSystemSpacingBelow: signInButton.bottomAnchor, multiplier: 2),
            errorMessageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}


//MARK: Actions
extension LoginViewController {
    @objc func signInTapped() {
        errorMessageLabel.isHidden = true
        login()
    }
    
    private func login() {
        guard let username = username, let password = password else {
            assertionFailure("Username / password should never be nil")
            return
        }
        
        if username.isEmpty || password.isEmpty {
            configureView(withMessage: "Username and password cannot be blank !")
            return
        }
        
        if username == "Iuri" && password == "welcome" {
            defaultUser.username = username
            signInButton.configuration?.showsActivityIndicator = true
            delegate?.didLogin()
        } else {
            configureView(withMessage: "Incorrect username or password !")
        }
    }
    
    private func configureView(withMessage message: String) {
        errorMessageLabel.isHidden = false
        errorMessageLabel.text = message
        shakeButton()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            self.fadeErrorMessage()
        }
    }
    
    private func shakeButton() {
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position.x"
        animation.values = [0,10,-10,10,0]
        animation.keyTimes = [0,0.16, 0.5, 0.83, 1]
        animation.duration = 0.245
        
        animation.isAdditive = true
        signInButton.layer.add(animation, forKey: "shake")
    }
    
}

// Animations

extension LoginViewController {
    
    private func animation() {
        self.titleLeadingAnchor?.constant = self.leadingEdgeOnScreen
        self.view.layoutIfNeeded()
    }
    
    private func animate() {
        let animator1 = UIViewPropertyAnimator(duration: 0.55, curve: .easeInOut, animations: animation)
        animator1.startAnimation()
    }
    
    private func subtitleAnimate() {
        let animator2 = UIViewPropertyAnimator(duration: 0.55, curve: .easeInOut) {
            self.subtitleTrailingAnchor?.constant = self.subtitleTrailingEdgeOnScreen
            self.view.layoutIfNeeded()
        }
        animator2.startAnimation()
    }
    
    private func fadeErrorMessage() {
        let animator3 = UIViewPropertyAnimator(duration: 0.45, curve: .easeInOut) {
            self.errorMessageLabel.alpha = 0
        }
        animator3.startAnimation(afterDelay: 0.25)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.errorMessageLabel.isHidden = true
            self.errorMessageLabel.alpha = 1
        }
    }
}

