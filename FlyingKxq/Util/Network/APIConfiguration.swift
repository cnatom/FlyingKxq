//
//  APIConfiguration.swift
//  FlyingKxq
//
//  Created by atom on 2024/12/20.
//

import Alamofire
import Foundation

protocol APIConfiguration {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get set }
    var parameters: [String: Any] { get set }
}

// 默认实现
extension APIConfiguration {
    var baseURL: String {
        return "http://s0.nsloop.com:18092"
    }
}
