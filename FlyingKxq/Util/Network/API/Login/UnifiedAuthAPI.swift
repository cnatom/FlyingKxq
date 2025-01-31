//
//  UnifiedAuth.swift
//  FlyingKxq
//
//  Created by atom on 2024/12/21.
//

import Alamofire

class UnifiedAuthAPI: APIConfiguration, MockableAPI {
    var path: String {
        "/api/auth/v1/authentication/unifiedAuth"
    }

    var method: HTTPMethod {
        .post
    }

    var headers: [String: String] = ["Device-Type": "MOBILE_CLIENT"]

    var parameters: [String: Any] = [:]

    var response: UnifiedAuthAPIResponse?

    var mockData: String {
        """
        {
            "code": 200,
            "msg": "成功",
            "data": {
                "type": "unified_auth",
                "token": "723e5af3de084a86a1fdf8ed771e79a5",
                "expiresIn": 900
            }
        }
        """
    }
}

struct UnifiedAuthAPIResponse: Codable {
    let code: Int?
    let msg: String?
    let data: UnifiedAuthAPIResponseData?
}

struct UnifiedAuthAPIResponseData: Codable {
    let type, token: String?
    let expiresIn: Int?
}
