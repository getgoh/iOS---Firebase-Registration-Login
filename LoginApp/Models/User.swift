//
//  User.swift
//  LoginApp
//
//  Created by Al Roben Adriane P. Goh on 15/09/2017.
//  Copyright © 2017 Chrysalis. All rights reserved.
//

import Foundation

class User {
    
    // [{"id":1,"fname":"get","lname":"goh","email":"test@gmail.com"}]
    
    var id: Int
    var fname: String?
    var lname: String?
    var email: String
    
    init?(id: Int, fname: String, lname: String, email: String) {
        
        if email.isEmpty {
            return nil
        }
        
        self.id = id
        self.fname = fname
        self.lname = lname
        self.email = email
    }
    
}
