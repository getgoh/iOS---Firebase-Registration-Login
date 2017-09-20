//
//  ViewController.swift
//  LoginApp
//
//  Created by Al Roben Adriane P. Goh on 13/09/2017.
//  Copyright © 2017 Chrysalis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.brown
        
        let loginController = LoginViewController()
        self.present(loginController, animated: true, completion: nil)
    }

}

