//
//  ValidationUtil.swift
//  FlyingKxq
//
//  Created by atom on 2024/12/21.
//
import Foundation

class ValidationUtil {
    static func isValidUsername(_ username: String) -> Bool {
        isValid(regex: "^[a-zA-Z0-9_]{6,16}$", value: username)
    }
    
    static func isValidPassword(_ password: String) -> Bool {
        isValid(regex: "^[^\\s]{8,20}$", value: password)
    }
    
    static func isValid(regex: String, value: String) -> Bool {
        NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: value)
    }
}
