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
        "newsCategory": [
            {
                "categoryName": "学校",
                "categoryList": [
                    {
                        "newsType": "中国矿业大学新闻网",
                        "shortName": "新闻网",
                        "sourceName": [
                            "视点新闻",
                            "奋进之歌",
                            "学术聚焦",
                            "校园快讯"
                        ]
                    }
                ]
            },
            {
                "categoryName": "学院",
                "categoryList": [
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
        ]
        }
        }
        """
    }
}

// MARK: - NewsTypeAPIResponse

struct NewsTypeAPIResponse: Codable {
    let code: Int?
    let msg: String?
    let data: NewsTypeAPIResponseDataClass?
}

// MARK: - DataClass

struct NewsTypeAPIResponseDataClass: Codable {
    let newsCategory: [NewsSource]?
}

// MARK: - NewsCategory

struct NewsSource: Codable {
    let categoryName: String?
    let categoryList: [NewsTypeAPIResponseCategoryList]?
}

// MARK: - CategoryList

struct NewsTypeAPIResponseCategoryList: Codable {
    let newsType, shortName: String?
    let sourceName: [String]?
}
