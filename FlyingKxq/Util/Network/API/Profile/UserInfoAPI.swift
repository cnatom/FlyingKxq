//
//  UserInfoAPI.swift
//  FlyingKxq
//
//  Created by atom on 2025/1/7.
//
import Alamofire

class UserInfoAPI: APIConfiguration, MockableAPI {
    var path: String {
        "/api/user/info/v1/me"
    }

    var method: HTTPMethod {
        .get
    }

    var headers: [String: String] = [:]

    var parameters: [String: Any] = [:]

    var response: UserInfoAPIResponse?

    var mockData: String {
        """
        {
            "code": 200,
            "msg": "成功",
            "data": {
                "userId": "7bc19f9be50a437f9d9d45193d065b38",
                "username": "qqqqqq",
                "nickname": "圈圈FUknaN",
                "avatar": "http://119.45.93.228:8080/api/file/v1/public/e59b8e263ee1764656e34ef38322f234a67ae9417d66c70652f90311db9271b3.jpg",
                "bio": "",
                "gender": 1,
                "hometown": "",
                "major": null,
                "grade": null,
                "statuses": null,
                "level": 5,
                "experience": 0,
                "followersCount": 2,
                "followingsCount": 0,
                "likeReceivedCount": 0
            }
        }
        """
    }
}

struct UserInfoAPIResponse: Codable {
    let code: Int?
    let msg: String?
    let data: UserInfoAPIResponseDataClass?
}

struct UserInfoAPIResponseDataClass: Codable {
    let userID, username, nickname, avatar: String?
    let banner, bio: String?
    let hometown, major, grade: String?
    let gender, level, experience, followersCount, followingCount: Int?
    let likeReceivedCount: Int?
    let status: [UserInfoAPIResponseStatus]?

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case username, nickname, avatar, hometown, major, grade, banner, bio, gender, level, followersCount, followingCount, experience, likeReceivedCount, status = "statuses"
    }
}

struct UserInfoAPIResponseStatus: Codable {
    let emoji: String?
    let text: String?
    let endTime: String?

    enum CodingKeys: String, CodingKey {
        case emoji, text, endTime
    }
}
