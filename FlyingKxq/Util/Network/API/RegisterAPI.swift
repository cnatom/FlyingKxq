//
//  RegisterAPI.swift
//  FlyingKxq
//
//  Created by atom on 2024/12/20.
//
import Alamofire

class RegisterAPI: APIConfiguration {

    var path: String {
        "/api/auth/v2/register"
    }

    var method: HTTPMethod {
        .post
    }
    
    var headers: [String : String] = ["Device-Type":"MOBILE_CLIENT"]
    
    var parameters: [String : Any] = [:]
}
