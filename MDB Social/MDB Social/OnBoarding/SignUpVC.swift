//
//  SignUpVC.swift
//  MDB Social
//
//  Created by Marco Monfiglio on 4/4/22.
//

import UIKit

class SignUpVC: UIViewController {
    
    private let contentEdgeInset = UIEdgeInsets(top: 120, left: 40, bottom: 30, right: 40)
    
    private let stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 25
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let welcomeHeader: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.text = "Sign Up Below"
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 45, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let signUpButton: LoadingButton = {
        let btn = LoadingButton()
        btn.layer.backgroundColor = UIColor.primary.cgColor
        btn.setTitle("Sign Up", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        btn.isUserInteractionEnabled = true
        btn.layer.cornerRadius = 22
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let nameTextField: AuthTextField = {
        let tf = AuthTextField(title: "Full Name:")
        tf.textField.isSecureTextEntry = false
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private let usernameTextField: AuthTextField = {
        let tf = AuthTextField(title: "Username:")
        tf.textField.isSecureTextEntry = false
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private let emailTextField: AuthTextField = {
        let tf = AuthTextField(title: "Email:")
        tf.textField.isSecureTextEntry = false
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private let passwordTextField: AuthTextField = {
        let tf = AuthTextField(title: "Password:")
        tf.textField.isSecureTextEntry = true
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private let confPasswordTextField: AuthTextField = {
        let tf = AuthTextField(title: "Confirm Password:")
        tf.textField.isSecureTextEntry = true
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private let returnButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Back", for: .normal)
        button.backgroundColor = .white
        button.layer.borderWidth = 3
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubViews()
        setUpConstraints()
        returnButton.addTarget(self, action: #selector(tapReturnHandler(_:sender:)), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(didTapSignUp(_:)), for: .touchUpInside)
    }
    
    func addSubViews() {
        view.addSubview(welcomeHeader)
        view.addSubview(returnButton)
        view.addSubview(signUpButton)
        view.addSubview(stack)
        stack.addArrangedSubview(nameTextField)
        stack.addArrangedSubview(usernameTextField)
        stack.addArrangedSubview(emailTextField)
        stack.addArrangedSubview(passwordTextField)
        stack.addArrangedSubview(confPasswordTextField)
    }
    
    func setUpConstraints() {
        welcomeHeader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        welcomeHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        welcomeHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        welcomeHeader.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: CGFloat(125)).isActive = true
        
        returnButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        returnButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
        returnButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        returnButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: CGFloat(25)).isActive = true
        
        signUpButton.leadingAnchor.constraint(equalTo: stack.leadingAnchor).isActive = true
        signUpButton.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 30).isActive = true
        signUpButton.trailingAnchor.constraint(equalTo: stack.trailingAnchor).isActive = true
        signUpButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        stack.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                       constant: contentEdgeInset.left).isActive = true
        stack.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                        constant: -contentEdgeInset.right).isActive = true
        stack.topAnchor.constraint(equalTo: welcomeHeader.bottomAnchor,
                                   constant: 50).isActive = true
    }

    @objc func tapReturnHandler(_ action: UIAction, sender: UIButton) {
        dismiss(animated: true)
    }
    
    @objc func didTapSignUp(_ sender: UIButton) {
        /*
         CHECK FOR EMAIL IN USE IN FIREBASE DATABASE
         CHECK FOR WEAK PASSWORD
         ADD USER TO THE FIREBASE DATABASE (REGISTER THEM WITH FIREBASE AUTH - THEN USE UID FOR NAME DATA)
         SIGN IN THE USER AFTER CREATING THE USER
         */
        
        let vc = SigninVC()
        
        guard let name = nameTextField.text, name != "" else {
            vc.showErrorBanner(withTitle: "Missing password", subtitle: "Please enter your password")
            return
        }
        guard let username = usernameTextField.text, username != "" else {
            vc.showErrorBanner(withTitle: "Missing username", subtitle: "Please enter your username")
            return
        }
        guard let email = emailTextField.text, email != "" else {
            vc.showErrorBanner(withTitle: "Missing email", subtitle: "Please enter you email address")
            return
        }
        guard let password = passwordTextField.text, password != "" else {
            vc.showErrorBanner(withTitle: "Missing password", subtitle: "Please enter your password")
            return
        }
        guard let confPassword = confPasswordTextField.text, confPassword != "" else {
            vc.showErrorBanner(withTitle: "Missing password", subtitle: "Please confirm your password")
            return
        }
        
        if passwordTextField.text != confPasswordTextField.text {
            vc.showErrorBanner(withTitle: "Passwords don't match", subtitle: "Re-confirm Password")
        } else {
            AuthManager.shared.addUser(name: nameTextField.text!, username: usernameTextField.text!, email: emailTextField.text!, password: passwordTextField.text!) {[weak self] result in
                
                guard let self = self else { return }
                
                switch result {
                case .success:
                guard let window = self.view.window else { return }
                let vc = FeedNavigationVC(rootViewController: FeedVC())
                window.rootViewController = vc
                let options: UIView.AnimationOptions = .transitionCrossDissolve
                let duration: TimeInterval = 0.3
                UIView.transition(with: window, duration: duration, options: options, animations: {}, completion: nil)
    
                
                case .failure(let error):
                    switch error {
                    case .weakPassword:
                        vc.showErrorBanner(withTitle: "Weak Password", subtitle: "Please strengthen password")
                    case .emailAlreadyInUse:
                        vc.showErrorBanner(withTitle: "Email already in use", subtitle: "Please check your email addresss")
                    default:
                        vc.showErrorBanner(withTitle: "Internal error", subtitle: "Internal Errpr")
                    }
                }
            }
            
            
            
            
        }
    }
}
