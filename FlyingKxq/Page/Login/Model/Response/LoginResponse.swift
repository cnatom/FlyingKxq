//
//  LoginResponse.swift
//  FlyingKxq
//
//  Created by atom on 2024/12/21.
//

import Foundation

// MARK: - LoginResponse
struct LoginResponse: Codable {
    let code: Int?
    let msg: String?
    let data: LoginResponseData?
}

// MARK: - DataClass
struct LoginResponseData: Codable {
    let accessToken: String?
    let expiresIn: Int?
    let refreshToken, userID: String?
    
    enum CodingKeys: String, CodingKey {
        case accessToken, expiresIn, refreshToken
        case userID = "userId"
    }
}
