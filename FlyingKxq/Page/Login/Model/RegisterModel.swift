//
//  RegisterModel.swift
//  FlyingKxq
//
//  Created by atom on 2024/12/21.
//

import Foundation

class RegisterModel: NSObject {
    let username: String
    let password: String
    let schoolCookie: HTTPCookie
    let appleSignInModel: AppleSignInModel
    
    init(username: String, password: String, schoolCookie: HTTPCookie, appleSignInModel: AppleSignInModel) {
        self.username = username
        self.password = password
        self.schoolCookie = schoolCookie
        self.appleSignInModel = appleSignInModel
    }
}
