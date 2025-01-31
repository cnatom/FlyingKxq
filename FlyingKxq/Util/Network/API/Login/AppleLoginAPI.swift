//
//  AppleLoginAPI.swift
//  FlyingKxq
//
//  Created by atom on 2024/12/21.
//
import Alamofire

class AppleLoginAPI: APIConfiguration, MockableAPI {
    var path: String {
        "/api/auth/v1/login/apple"
    }

    var method: HTTPMethod {
        .post
    }

    var headers: [String: String] = ["Device-Type": "MOBILE_CLIENT"]

    var parameters: [String: Any] = [:]

    var response: AppleLoginAPIResponse?

    var mockData: String {
        """
        {
            "code": 200,
            "msg": "成功",
            "data": {
                "accessToken": "kpu4JsvTf0XvAPm5d6ACGlHU6zNhjtMSzNVuep81Q8BL5ip1p46exg1nyLKnBZfC",
                "expiresIn": 2592000,
                "refreshToken": "5odgpn4m5G5JLWEqs5eGw4pYGMKpRDJo4PFclRtn4Th7Iq4AJIZnPFnGH0M44k6v74KGUbf4iGRYcTtNjKGOgGL9VPXFU4V0FYvpme9ihdNJrSqc4Gi3j3B3lt43j4lp",
                "userId": "5a50eae4a24c4ebfbdf16b7c537b81aa"
            }
        }
        """
    }
}

struct AppleLoginAPIResponse: Codable {
    let code: Int?
    let msg: String?
    let data: AppleLoginAPIResponseData?
}

struct AppleLoginAPIResponseData: Codable {
    let accessToken: String?
    let expiresIn: Int?
    let refreshToken, userID: String?

    enum CodingKeys: String, CodingKey {
        case accessToken, expiresIn, refreshToken
        case userID = "userId"
    }
}
