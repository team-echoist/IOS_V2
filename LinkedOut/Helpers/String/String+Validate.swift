//
//  String+Validate.swift
//  LinkedOut
//
//  Created by 이상하 on 7/25/24.
//

import Foundation

extension String {
    var alphanumeric: String {
        let pattern = "[^A-Za-z0-9@]"
        return self.replacingOccurrences(of: pattern, with: "", options: [.regularExpression])
    }
    
    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    var isAlphanumeric: Bool {
        return range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }
    
    var isValidInsta: Bool {
        return range(of: "[^a-zA-Z0-9_.]", options: .regularExpression) == nil
    }
    
    var isBackspace: Bool {
        let char = self.cString(using: String.Encoding.utf8)!
        return strcmp(char, "\\b") == -92
    }
    
}
