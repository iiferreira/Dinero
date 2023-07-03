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
    let loginView = LoginView()
    let signInButton = UIButton(type: .system)
    let errorMessageLabel = UILabel()
    
    var username : String? {
        return loginView.usernameTextField.text
    }
    
    var password : String? {
        return loginView.passwordTextfield.text
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        style()
        layout()
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
        view.addSubview(loginView)
        view.addSubview(signInButton)
        view.addSubview(errorMessageLabel)
        
        
        NSLayoutConstraint.activate([
            logoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoLabel.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 15)
        ])
        
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
            configureView(withMessage: "Username and password cannot be blank")
            return
        }
        
        if username == "Iuri" && password == "welcome" {
            defaultUser.username = username
            signInButton.configuration?.showsActivityIndicator = true
            delegate?.didLogin()
        } else {
            configureView(withMessage: "Incorrect username or password")
        }
    }
    
    private func configureView(withMessage message: String) {
        errorMessageLabel.isHidden = false
        errorMessageLabel.text = message
    }
}

