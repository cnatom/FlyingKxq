//
//  NetworkRequesting.swift
//  FlyingKxq
//
//  Created by atom on 2025/1/6.
//

import Alamofire

protocol NetworkManagerProtocol {
    func request<T: APIConfiguration>(
        api: T
    ) async throws -> T.ResponseType
}
