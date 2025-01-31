//
//  NewsTypeAPI.swift
//  FlyingKxq
//
//  Created by atom on 2025/1/31.
//

import Alamofire

class NewsTypeAPI: APIConfiguration, MockableAPI {
    var path: String {
        "/api/post/news/v1/type"
    }

    var method: HTTPMethod {
        .get
    }

    var headers: [String: String] = [:]

    var parameters: [String: Any] = [:]

    var response: NewsTypeAPIResponse?

    var mockData: String {
        """
        {
            "code": 200,
            "msg": "成功",
            "data": {
                "newsCategory": {
                    "校园": [
                        {
                            "newsType": "新闻网",
                            "shortName": "新闻网",
                            "sourceName": [
                                "视点新闻",
                                "世界动态",
                                "美丽校园"
                            ]
                        }
                    ],
                    "学院": [
                        {
                            "newsType": "计算机科学与技术学院",
                            "shortName": "计算机",
                            "sourceName": [
                                "通知公告",
                                "学术动态",
                                "教学通知"
                            ]
                        },
                        {
                            "newsType": "人文与与艺术学院",
                            "shortName": "人文",
                            "sourceName": [
                                "通知公告"
                            ]
                        }
                    ]
                }
            }
        }
        """
    }
}

// MARK: - UserInfoAPIResponse

struct NewsTypeAPIResponse: Codable {
    let code: Int?
    let msg: String?
    let data: NewsTypeAPIResponseData?
}

struct NewsTypeAPIResponseData: Codable {
    let newsCategory: [String: [NewsTypeAPIResponseDataCategory]]?
}

struct NewsTypeAPIResponseDataCategory: Codable {
    let newsType: String?
    let shortName: String?
    let sourceName: [String]?
}
