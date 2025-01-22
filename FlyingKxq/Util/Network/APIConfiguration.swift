//
//  APIConfiguration.swift
//  FlyingKxq
//
//  Created by atom on 2024/12/20.
//

import Alamofire
import Foundation

protocol APIConfiguration {
    associatedtype ResponseType: Codable
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get set }
    var parameters: [String: Any] { get set }
    var response: ResponseType? { get set }
    static var type: ResponseType.Type { get }
}

extension APIConfiguration {
    var baseURL: String {
        return "https://kxq.wotemo.com"
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
