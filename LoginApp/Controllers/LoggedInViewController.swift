//
//  LoggedInViewController.swift
//  LoginApp
//
//  Created by Al Roben Adriane P. Goh on 20/09/2017.
//  Copyright © 2017 Chrysalis. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoggedInViewController: UIViewController {

    let txtLogged : UILabel = {
        let txt = UILabel()
        txt.text = "You are logged in!"
        txt.font = UIFont(name: "Helvetica", size: 20)
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.textAlignment = .center
        return txt
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white

        view.addSubview(txtLogged)
        
        txtLogged.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1, constant: -24).isActive = true
        txtLogged.heightAnchor.constraint(equalToConstant: 60).isActive = true
        txtLogged.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        txtLogged.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        if let email = Auth.auth().currentUser?.email {
            txtLogged.text = "You are logged in using: \(email)"
        }
    }

}
