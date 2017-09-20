//
//  Extensions.swift
//  LoginApp
//
//  Created by Al Roben Adriane P. Goh on 19/09/2017.
//  Copyright © 2017 Chrysalis. All rights reserved.
//

import Foundation

extension String {
    
    // NOTE: This is an extension I found online. The regex checks for the '@' symbol for sure, but not too sure about anything else.
    func isValidEmail() -> Bool {
        // here, `try!` will always succeed because the pattern is valid
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: characters.count)) != nil
    }
}
