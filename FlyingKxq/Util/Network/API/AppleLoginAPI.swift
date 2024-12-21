//
//  AppleLoginAPI.swift
//  FlyingKxq
//
//  Created by atom on 2024/12/21.
//
import Alamofire

class AppleLoginAPI: APIConfiguration {
    var path: String {
        "/api/auth/v2/login/apple"
    }
    var method: HTTPMethod {
        .post
    }
    
    var headers: [String : String] = ["Device-Type":"MOBILE_CLIENT"]
    
    var parameters: [String : Any] = [:]
}
