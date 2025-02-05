//
//  NewsListAPI.swift
//  FlyingKxq
//
//  Created by atom on 2025/2/3.
//

import Alamofire

class NewsListAPI: APIConfiguration, MockableAPI {
    var path: String {
        "/api/post/news/v1"
    }

    var method: HTTPMethod {
        .get
    }

    var headers: [String: String] = [:]

    var parameters: [String: Any] = [:]

    var response: NewsListAPIResponse?

    var mockData: String {
        """
        {
        "code": 200,
        "msg": "成功",
        "data": {
        "newsCategory": "校园",
        "newsType": "中国矿业大学新闻网",
        "sourceName": "视点新闻",
        "size": 10,
        "cursor": "2025-01-01T20:01:27",
        "lastNewsId": 1884938914562674714,
        "newsList": [
            {
                "newsId": 1884938914562674727,
                "newsCategory": "校园",
                "newsType": "中国矿业大学新闻网",
                "shortName": "新闻网",
                "sourceName": "视点新闻",
                "sourceUrl": "https://news.cumt.edu.cn/info/1002/71704.htm",
                "showType": "direct",
                "title": "我校南京校友会举行校友经济创新发展论坛",
                "images": [
                    "https://news.cumt.edu.cn/__local/0/9D/F7/D7B0E78536D7B3E3322E2FCC26A_5051DC19_1B3EE.jpg"
                ],
                "commentCount": 0,
                "viewCount": 0,
                "status": "PUBLISHED",
                "score": 0.0,
                "publishTime": "2025-01-06T20:01:26"
            },
            {
                "newsId": 1884938914562674726,
                "newsCategory": "校园",
                "newsType": "中国矿业大学新闻网",
                "shortName": "新闻网",
                "sourceName": "视点新闻",
                "sourceUrl": "https://news.cumt.edu.cn/info/1002/71703.htm",
                "showType": "direct",
                "title": "我校黑龙江校友会举办智慧矿山及新能源建设研讨会",
                "images": [
                    "https://news.cumt.edu.cn/__local/5/56/87/AF65E50DBF8A5F49A7A9D684E39_9C135E29_241D4.jpg"
                ],
                "commentCount": 0,
                "viewCount": 0,
                "status": "PUBLISHED",
                "score": 0.0,
                "publishTime": "2025-01-06T20:01:26"
            },
            {
                "newsId": 1884938914562674725,
                "newsCategory": "校园",
                "newsType": "中国矿业大学新闻网",
                "shortName": "新闻网",
                "sourceName": "视点新闻",
                "sourceUrl": "https://news.cumt.edu.cn/info/1002/71702.htm",
                "showType": "direct",
                "title": "学校召开校领导班子成员2024年度民主生活会学习研讨暨党委理论学习中心组集中学习会",
                "images": [
                    "https://news.cumt.edu.cn/__local/D/F9/CD/B67D40192E3D842CFEFC1CFED58_96FB4B76_20DDD.jpg"
                ],
                "commentCount": 0,
                "viewCount": 0,
                "status": "PUBLISHED",
                "score": 0.0,
                "publishTime": "2025-01-06T20:01:26"
            },
            {
                "newsId": 1884938914562674723,
                "newsCategory": "校园",
                "newsType": "中国矿业大学新闻网",
                "shortName": "新闻网",
                "sourceName": "视点新闻",
                "sourceUrl": "https://news.cumt.edu.cn/info/1002/71699.htm",
                "showType": "direct",
                "title": "我校开展妇女工作评优总结迎新座谈",
                "images": [
                    "https://news.cumt.edu.cn/__local/2/D2/BE/C1A430511C21C67CCC98F82F1FB_870870B3_1208A0.jpg"
                ],
                "commentCount": 0,
                "viewCount": 0,
                "status": "PUBLISHED",
                "score": 0.0,
                "publishTime": "2025-01-03T20:01:25"
            },
            {
                "newsId": 1884938914562674722,
                "newsCategory": "校园",
                "newsType": "中国矿业大学新闻网",
                "shortName": "新闻网",
                "sourceName": "视点新闻",
                "sourceUrl": "https://news.cumt.edu.cn/info/1002/71698.htm",
                "showType": "direct",
                "title": "我校主办3种科技期刊入选2024年度“国际影响力TOP期刊”榜单",
                "images": null,
                "commentCount": 0,
                "viewCount": 0,
                "status": "PUBLISHED",
                "score": 0.0,
                "publishTime": "2025-01-03T20:01:25"
            },
            {
                "newsId": 1884938914562674721,
                "newsCategory": "校园",
                "newsType": "中国矿业大学新闻网",
                "shortName": "新闻网",
                "sourceName": "视点新闻",
                "sourceUrl": "https://news.cumt.edu.cn/info/1002/71701.htm",
                "showType": "direct",
                "title": "中国矿业大学2024年十大新闻权威发布",
                "images": [
                    "https://news.cumt.edu.cn/__local/5/0C/79/E91197671B56C737AD599B4E756_C4F68B27_5E4DC.png"
                ],
                "commentCount": 0,
                "viewCount": 0,
                "status": "PUBLISHED",
                "score": 0.0,
                "publishTime": "2025-01-03T20:01:25"
            },
            {
                "newsId": 1884938914562674719,
                "newsCategory": "校园",
                "newsType": "中国矿业大学新闻网",
                "shortName": "新闻网",
                "sourceName": "视点新闻",
                "sourceUrl": "https://news.cumt.edu.cn/info/1002/71688.htm",
                "showType": "direct",
                "title": "深地工程智能建造与健康运维全国重点实验室主任 谢和平院士CO2捕集全新原理技术成果登上Nature子刊",
                "images": [
                    "https://news.cumt.edu.cn/__local/F/2D/27/6BF3CBB01A39352455AC5F0A01E_315A20C3_2B9E5.jpg"
                ],
                "commentCount": 0,
                "viewCount": 0,
                "status": "PUBLISHED",
                "score": 0.0,
                "publishTime": "2025-01-02T20:01:27"
            },
            {
                "newsId": 1884938914562674718,
                "newsCategory": "校园",
                "newsType": "中国矿业大学新闻网",
                "shortName": "新闻网",
                "sourceName": "视点新闻",
                "sourceUrl": "https://news.cumt.edu.cn/info/1002/71690.htm",
                "showType": "direct",
                "title": "学校举办“逐梦2025”中国矿业大学教职工迎新年健步行活动",
                "images": [
                    "https://news.cumt.edu.cn/__local/2/AB/C2/6FA5D6519801C3506D39E31409A_A720F790_33EE0.jpg"
                ],
                "commentCount": 0,
                "viewCount": 0,
                "status": "PUBLISHED",
                "score": 0.0,
                "publishTime": "2025-01-02T20:01:27"
            },
            {
                "newsId": 1884938914562674717,
                "newsCategory": "校园",
                "newsType": "中国矿业大学新闻网",
                "shortName": "新闻网",
                "sourceName": "视点新闻",
                "sourceUrl": "https://news.cumt.edu.cn/info/1002/71691.htm",
                "showType": "direct",
                "title": "我校文昌校园两栋建筑入选徐州市历史建筑保护名录",
                "images": null,
                "commentCount": 0,
                "viewCount": 0,
                "status": "PUBLISHED",
                "score": 0.0,
                "publishTime": "2025-01-02T20:01:25"
            },
            {
                "newsId": 1884938914562674714,
                "newsCategory": "校园",
                "newsType": "中国矿业大学新闻网",
                "shortName": "新闻网",
                "sourceName": "视点新闻",
                "sourceUrl": "https://news.cumt.edu.cn/info/1002/71683.htm",
                "showType": "direct",
                "title": "我校举行2025年元旦嘉年华系列活动",
                "images": [
                    "https://news.cumt.edu.cn/__local/D/04/06/9938BBD0891E289E152E2982289_B6A30967_433CB.jpg"
                ],
                "commentCount": 0,
                "viewCount": 0,
                "status": "PUBLISHED",
                "score": 0.0,
                "publishTime": "2025-01-01T20:01:27"
            }
        ]
        }
        }
        """
    }
}

// MARK: - NewsListAPIResponse

struct NewsListAPIResponse: Codable {
    let code: Int?
    let msg: String?
    let data: NewsListAPIResponseData?
}

// MARK: - DataClass

struct NewsListAPIResponseData: Codable {
    let newsCategory: String?
    let newsType: String?
    let sourceName: String?
    let size: Int?
    let cursor: String?
    let lastNewsID: Double?
    let newsList: [NewsListItem]?

    enum CodingKeys: String, CodingKey {
        case newsCategory, newsType, sourceName, size, cursor
        case lastNewsID = "lastNewsId"
        case newsList
    }
}

// MARK: - NewsList

struct NewsListItem: Codable {
    let newsID: Double?
    let newsCategory: String?
    let newsType: String?
    let sourceName: String?
    let shortName: String?
    let sourceURL: String?
    let showType: String?
    let title: String?
    let commentCount, viewCount: Int?
    let status: String?
    let images: [String]?
    let score: Int?
    let publishTime: String?

    var publishTimeFormatted: String? {
        if let publishTime = publishTime {
            return FlyDateFormatter.newsParse(publishTime)
        } else {
            return nil
        }
    }

    var imageUrl: String? {
        var result: String?
        if let images = images, images.count > 0 {
            result = images[0]
        }
        return result
    }

    var source: String? {
        var result: String?
        if let shortName = shortName {
            result = shortName
            if let sourceName = sourceName {
                result?.append("·\(sourceName)")
            }
        }
        return result
    }

    enum CodingKeys: String, CodingKey {
        case newsID = "newsId"
        case newsCategory, newsType, sourceName, shortName
        case sourceURL = "sourceUrl"
        case showType, title, commentCount, viewCount, status, images, score, publishTime
    }
}
