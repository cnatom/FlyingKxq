//
//  APIConfiguration.swift
//  FlyingKxq
//
//  Created by atom on 2024/12/20.
//

import Alamofire
import Foundation
enum RequestParameterType {
    case json
    case form
}

protocol APIConfiguration {
    associatedtype ResponseType: Codable
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get set }
    var parameters: [String: Any] { get set }
    var parameterType: RequestParameterType { get }
    var response: ResponseType? { get set }
    static var type: ResponseType.Type { get }
}

extension APIConfiguration {
    var baseURL: String {
        return "http://119.45.93.228:8080"
//        return "https://kxq.wotemo.com"
    }

    var parameterType: RequestParameterType {
        return .json
    }

    var injectToken: Bool {
        get {
            headers["Authorization"] != nil
        }
        set {
            if newValue, let token = FlyKeyChain.shared.read(key: .token) {
                headers["Authorization"] = "Bearer \(token)"
            }
        }
    }

    static var type: ResponseType.Type {
        return ResponseType.self
    }
}
