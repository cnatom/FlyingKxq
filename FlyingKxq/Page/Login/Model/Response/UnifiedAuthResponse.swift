//
//  Untitled.swift
//  FlyingKxq
//
//  Created by atom on 2024/12/21.
//

import Foundation

// MARK: - UnifiedAuthModel
struct UnifiedAuthResponse: Codable {
    let code: Int?
    let msg: String?
    let data: UnifiedAuthResponseData?
}

// MARK: - DataClass
struct UnifiedAuthResponseData: Codable {
    let type, token: String?
    let expiresIn: Int?
}
