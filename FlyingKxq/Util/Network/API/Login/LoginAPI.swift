//
//  LoginAPI.swift
//  FlyingKxq
//
//  Created by atom on 2024/12/21.
//

import Alamofire
import Foundation

class LoginAPI: APIConfiguration, MockableAPI {
    var path: String {
        "/api/auth/v1/login/username"
    }

    var method: HTTPMethod {
        .post
    }

    var headers: [String: String] = ["Device-Type": "MOBILE_CLIENT"]

    var parameters: [String: Any] = [:]

    var response: LoginAPIResponse?

    var mockData: String {
        """
        {
            "code": 200,
            "msg": "成功",
            "data": {
                "accessToken": "IszKGVnxUpqvQiovNWt2llk1FzQmeJuSueaquzmP9axyUMMQkFZetTRfvpauJJ5r",
                "expiresIn": 2592000,
                "refreshToken": "paNGHEdxo3BZqR6V3is9r82PyOhFqtjQLWKNrkTqFA2JISSe3KDqU9Ac44qI7NJfoyBgoWPP5r2JCBY6uv5HVKzq3XLKsGpoUNxYPJQcOlFaDT9gR8b6mG5RlUZBHlHr",
                "userId": "5a50eae4a24c4ebfbdf16b7c537b81aa"
            }
        }
        """
    }
}

struct LoginAPIResponse: Codable {
    let code: Int?
    let msg: String?
    let data: LoginAPIResponseData?
}

struct LoginAPIResponseData: Codable {
    let accessToken: String?
    let expiresIn: Int?
    let refreshToken, userID: String?

    enum CodingKeys: String, CodingKey {
        case accessToken, expiresIn, refreshToken
        case userID = "userId"
    }
}
