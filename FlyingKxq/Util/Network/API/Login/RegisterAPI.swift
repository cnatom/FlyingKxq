//
//  RegisterAPI.swift
//  FlyingKxq
//
//  Created by atom on 2024/12/20.
//
import Alamofire

class RegisterAPI: APIConfiguration, MockableAPI {
    var path: String {
        "/api/auth/v1/register"
    }

    var method: HTTPMethod {
        .post
    }

    var headers: [String: String] = ["Device-Type": "MOBILE_CLIENT"]

    var parameters: [String: Any] = [:]

    var response: RegisterAPIResponse?

    var mockData: RegisterAPIResponse {
        RegisterAPIResponse(
            code: 200,
            msg: "成功",
            data: RegisterAPIResponseData(
                accessToken: "zwqGZ3oD1oynglqJOxIJOyxljB5h32PQ7bI8rth5cwMEAmhbWPONxP8p75W3zZaA",
                expiresIn: 2592000,
                refreshToken: "VCzpo9jNRnXVEhV8gyIko2TAn9qEnGfxAX7yJ8lFsR6gtv1x9oMQEpaQo6rnio5WVuawqPhflMJss0jVhW12OvdPOUEZCrux3gxyCNKn4nBigXUsbCpO38HuDR2o22nr",
                userID: "5a50eae4a24c4ebfbdf16b7c537b81aa"
            )
        )
    }
}

struct RegisterAPIResponse: Codable {
    let code: Int?
    let msg: String?
    let data: RegisterAPIResponseData?
}

struct RegisterAPIResponseData: Codable {
    let accessToken: String?
    let expiresIn: Int?
    let refreshToken, userID: String?

    enum CodingKeys: String, CodingKey {
        case accessToken, expiresIn, refreshToken
        case userID = "userId"
    }
}
