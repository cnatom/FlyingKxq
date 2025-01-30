//
//  RefreshTokenAPI.swift
//  FlyingKxq
//
//  Created by atom on 2025/1/7.
//
import Alamofire

class RefreshTokenAPI: APIConfiguration, MockableAPI {
    var path: String {
        "/api/auth/v1/refresh_token"
    }
    
    var method: HTTPMethod {
        .post
    }
    
    var headers: [String: String] = ["Device-Type": "MOBILE_CLIENT"]
    
    var parameters: [String : Any] = [:]
    
    var response: LoginAPIResponse?
    
    var mockData: LoginAPIResponse {
        LoginAPIResponse(
            code: 200,
            msg: "成功",
            data: LoginAPIResponseData(
                accessToken: "IszKGVnxUpqvQiovNWt2llk1FzQmeJuSueaquzmP9axyUMMQkFZetTRfvpauJJ5r",
                expiresIn: 2592000,
                refreshToken: "paNGHEdxo3BZqR6V3is9r82PyOhFqtjQLWKNrkTqFA2JISSe3KDqU9Ac44qI7NJfoyBgoWPP5r2JCBY6uv5HVKzq3XLKsGpoUNxYPJQcOlFaDT9gR8b6mG5RlUZBHlHr",
                userID: "5a50eae4a24c4ebfbdf16b7c537b81aa"
            )
        )
        
    }
}
