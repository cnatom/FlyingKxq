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

    init(type: UserInfoEditType, value: String? = nil) {
        self.type = type
        if let value = value, type != .avatar {
            parameters[type.rawValue] = value
        }
    }

    var method: HTTPMethod {
        .patch
    }

    var headers: [String: String] = [:]

    var parameters: [String: Any] = [:]

    var parameterType: RequestParameterType {
        if type == .avatar {
            return .form
        } else {
            return .json
        }
    }

    var response: UserInfoEditAPIResponse?

    var mockData: UserInfoEditAPIResponse {
        UserInfoEditAPIResponse(code: 200, msg: "成功", data: nil)
    }
}

struct UserInfoEditAPIResponse: Codable {
    let code: Int
    let msg: String
    let data: String?
}
