//
//  LoginAPI.swift
//  FlyingKxq
//
//  Created by atom on 2024/12/21.
//

import Alamofire

class LoginAPI: APIConfiguration {
    var path: String {
        "/api/auth/v2/login/username"
    }

    var method: HTTPMethod {
        .post
    }

    var headers: [String: String] = ["Device-Type": "MOBILE_CLIENT"]

    var parameters: [String: Any] = [:]
}
