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

    var mockData: UserInfoAPIResponse {
        UserInfoAPIResponse(
            code: 200,
            msg: "成功",
            data: UserInfoAPIResponseDataClass(
                userID: "5a50eae4a24c4ebfbdf16b7c537b81aa",
                username: "qqqqqq",
                nickname: "圈圈IOjeRF",
                avatar: "https://qlogo2.store.qq.com/qzone/1004275481/1004275481/100",
                banner: nil,
                bio: "卖女孩的小火柴",
                gender: 0,
                level: 4,
                followersCount: 321,
                followingCount: 123,
                likeReceivedCount: 412,
//                status: []
//                status: ["❤️恋爱中"]
                status: ["❤️恋爱中", "😃开心"]
            )
        )
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
    let gender, level, followersCount, followingCount: Int?
    let likeReceivedCount: Int?
    let status: [String]?

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case username, nickname, avatar, banner, bio, gender, level, followersCount, followingCount, likeReceivedCount, status
    }
}
