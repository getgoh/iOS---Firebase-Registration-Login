//
//  LoginViewController.swift
//  LoginApp
//
//  Created by Al Roben Adriane P. Goh on 13/09/2017.
//  Copyright © 2017 Chrysalis. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import Toaster

class LoginViewController: UIViewController {
    
    // MARK: UI Declarations
    let bgImage : UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "loginBG2")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let loginRegisterSC : UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Login", "Register"])
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.tintColor = UIColor.white
        sc.selectedSegmentIndex = 0
        sc.addTarget(self, action: #selector(handleSCchange), for: .valueChanged)
        return sc
    }()
    
    let inputContainerView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 1.0, alpha: 0.85)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    let emailTextField : UITextField = {
        let txt = UITextField()
        txt.placeholder = "Email"
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    let separator : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let passwordSeparator : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let passwordTextField : UITextField = {
        let txt = UITextField()
        txt.placeholder = "Password"
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.isSecureTextEntry = true
        return txt
    }()
    
    let repeatPasswordTextField : UITextField = {
        let txt = UITextField()
        txt.placeholder = "Repeat password"
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.isSecureTextEntry = true
        return txt
    }()
    
    lazy var loginRegisterBtn : UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Login", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = UIFont(name: "Helvetica", size: 18)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = UIColor(red: 73/255, green: 115/255, blue: 193/255, alpha: 0.95)
        
        btn.addTarget(self, action: #selector(self.handleLoginRegister), for: .touchUpInside)
        
        return btn
    }()
    
    // MARK: Constraints declaration
    var inputContainerViewHeightConstraint: NSLayoutConstraint?
    var emailHeightConstraint: NSLayoutConstraint?
    var passwordHeightConstraint: NSLayoutConstraint?
    var repeatPasswordHeightConstraint: NSLayoutConstraint?
    
    // MARK: Initialization
    override func viewDidLoad() {
        super.viewDidLoad()

        // I like to keep the main entry points clean, put dirt somewhere else
        setupViews()
    }
    
    // MARK: UI
    func setupViews()
    {
        view.backgroundColor = UIColor.gray
        
        view.addSubview(bgImage)
        view.addSubview(loginRegisterSC)
        view.addSubview(inputContainerView)
        view.addSubview(loginRegisterBtn)
        
        setupBgImage()
        setupInputContainerView()
        setupLoginRegisterSC()
        setupLoginRegisterButton()
    }
    
    func setupBgImage()
    {
        bgImage.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        bgImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        bgImage.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        bgImage.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
    
    func setupInputContainerView()
    {
        inputContainerView.addSubview(emailTextField)
        inputContainerView.addSubview(separator)
        inputContainerView.addSubview(passwordTextField)
        inputContainerView.addSubview(passwordSeparator)
        inputContainerView.addSubview(repeatPasswordTextField)
        
        inputContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputContainerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150).isActive = true
        inputContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        inputContainerViewHeightConstraint = inputContainerView.heightAnchor.constraint(equalToConstant: 120)
        inputContainerViewHeightConstraint?.isActive = true
        
        emailTextField.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor, constant: 10).isActive = true
        emailTextField.topAnchor.constraint(equalTo: inputContainerView.topAnchor).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        emailHeightConstraint = emailTextField.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: 1/2)
        emailHeightConstraint?.isActive = true
        
        // x, y, width, height
        separator.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor).isActive = true
        separator.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        separator.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        passwordTextField.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor, constant: 10).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: separator.bottomAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        passwordHeightConstraint = passwordTextField.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: 1/2)
        passwordHeightConstraint?.isActive = true
        
        passwordSeparator.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor).isActive = true
        passwordSeparator.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor).isActive = true
        passwordSeparator.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        passwordSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        repeatPasswordTextField.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor, constant: 10).isActive = true
        repeatPasswordTextField.topAnchor.constraint(equalTo: passwordSeparator.bottomAnchor).isActive = true
        repeatPasswordTextField.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        repeatPasswordHeightConstraint = repeatPasswordTextField.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: 1/3)
        repeatPasswordHeightConstraint?.isActive = true
    }
    
    func setupLoginRegisterSC()
    {
        loginRegisterSC.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterSC.bottomAnchor.constraint(equalTo: inputContainerView.topAnchor, constant: -10).isActive = true
        loginRegisterSC.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        loginRegisterSC.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func setupLoginRegisterButton()
    {
        loginRegisterBtn.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor).isActive = true
        loginRegisterBtn.topAnchor.constraint(equalTo: inputContainerView.bottomAnchor, constant: 8).isActive = true
        loginRegisterBtn.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        loginRegisterBtn.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    // MARK: Handler functions
    @objc func handleSCchange()
    {
        let isLogin = loginRegisterSC.selectedSegmentIndex == 0 ? true : false
        
        loginRegisterBtn.setTitle(isLogin ? "Login" : "Register", for: .normal)
        
        // so awesome
        UIView.animate(withDuration: 0.2) {
            self.inputContainerViewHeightConstraint?.isActive = false
            self.inputContainerViewHeightConstraint = self.inputContainerView.heightAnchor.constraint(equalToConstant: isLogin ? 120 : 180)
            self.inputContainerViewHeightConstraint?.isActive = true
            
            self.emailHeightConstraint?.isActive = false
            self.emailHeightConstraint = self.emailTextField.heightAnchor.constraint(equalTo: self.inputContainerView.heightAnchor, multiplier: isLogin ? 1/2 : 1/3)
            self.emailHeightConstraint?.isActive = true
            
            self.passwordHeightConstraint?.isActive = false
            self.passwordHeightConstraint = self.passwordTextField.heightAnchor.constraint(equalTo: self.inputContainerView.heightAnchor, multiplier: isLogin ? 1/2 : 1/3)
            self.passwordHeightConstraint?.isActive = true
            
            self.repeatPasswordHeightConstraint?.isActive = false
            self.repeatPasswordHeightConstraint = self.repeatPasswordTextField.heightAnchor.constraint(equalTo: self.inputContainerView.heightAnchor, multiplier: isLogin ? 0 : 1/3)
            self.repeatPasswordHeightConstraint?.isActive = true
            
            self.view.layoutIfNeeded()
        }
        
    }
    
    @objc func handleLoginRegister()
    {
        guard let email = emailTextField.text, !email.isEmpty else {
            print("Email is empty!")
            Toast(text: "Please enter email address", delay: 0, duration: 3.0).show()
            return
        }
        guard email.isValidEmail() else {
            print("Invalid email")
            Toast(text: "Please enter a valid email address", delay: 0, duration: 3.0).show()
            return
        }
        guard let pass = passwordTextField.text, !pass.isEmpty else {
            print("Password is empty!")
            Toast(text: "Please enter a password", delay: 0, duration: 3.0).show()
            return
        }
        
        loginRegisterSC.selectedSegmentIndex == 0 ? handleLogin(email: email, pass: pass) : handleRegister(email: email, pass: pass)
    }
    
    func handleRegister(email:String, pass: String)
    {
        guard let repeatpass = repeatPasswordTextField.text, !repeatpass.isEmpty else {
            print("Repeat password is empty!")
            Toast(text: "Please re-enter password", delay: 0, duration: 3.0).show()
            return
        }
        guard repeatpass == pass else {
            print("Password does not match!")
            Toast(text: "Password does not match", delay: 0, duration: 3.0).show()
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: pass) { (user, error) in
            if error != nil {
                print(error!)
                Toast(text: error?.localizedDescription, delay: 0, duration: 3.0).show()
                return
            }
            
            print("User registered!")
            Toast(text: "User successfully registered", delay: 0, duration: 3.0).show()
            let ref = Database.database().reference(fromURL: "https://fir-test-3da54.firebaseio.com/")
            ref.updateChildValues(["email": email], withCompletionBlock: { (err, ref) in
                if err != nil {
                    print(err!)
                    return
                }
                
                print("User saved into Firebase DB")
                
            })
            self.showNextView()
        }
    }
    
    func handleLogin(email:String, pass: String)
    {
        Auth.auth().signIn(withEmail: email, password: pass) { (user, error) in
            if error != nil {
                print(error!)
                Toast(text: error?.localizedDescription, delay: 0, duration: 3.0).show()
                return
            }
            Toast(text: "Login successful", delay: 0, duration: 3.0).show()
            self.showNextView()
        }
    }
    
    func showNextView()
    {
        let nextView = LoggedInViewController()
        self.present(nextView, animated: true, completion: nil)
    }
}











