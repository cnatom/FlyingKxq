//
//  UnifiedAuth.swift
//  FlyingKxq
//
//  Created by atom on 2024/12/21.
//

import Alamofire

class UnifiedAuthAPI: APIConfiguration {
    var path: String {
        "/api/auth/v2/authentication/unifiedAuth"
    }

    var method: HTTPMethod {
        .post
    }

    var headers: [String: String] = ["Device-Type": "MOBILE_CLIENT"]

    var parameters: [String: Any] = [:]
}
