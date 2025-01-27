//
//  UserInfoEditAPI.swift
//  FlyingKxq
//
//  Created by atom on 2025/1/24.
//

import Alamofire

enum UserInfoEditType: String {
    case nickname
    case major
    case hometown
    case grade
    case gender
    case bio
    case avatar
}

class UserInfoEditAPI: APIConfiguration, MockableAPI {
    let type: UserInfoEditType

    var path: String {
        "/api/user/info/v1/me/" + type.rawValue
    }

    init(type: UserInfoEditType, value: String) {
        self.type = type
        parameters[type.rawValue] = value
    }

    var method: HTTPMethod {
        .patch
    }

    var headers: [String: String] = [:]

    var parameters: [String: Any] = [:]

    var response: UserInfoEditAPIResponse?

    var mockData: UserInfoEditAPIResponse {
        UserInfoEditAPIResponse(code: 200, msg: "成功")
    }
}

struct UserInfoEditAPIResponse: Codable {
    let code: Int
    let msg: String
}
