//
//  RealNetworkManager.swift
//  FlyingKxq
//
//  Created by atom on 2025/1/6.
//

import Alamofire
import Foundation

class RealNetworkManager: NetworkManagerProtocol {
    func request<T: APIConfiguration>(
        api: T
    ) async throws -> T.ResponseType {
        if api.injectToken {
            await AuthManager.shared.refreshTokenIfNeed()
        }
        let url = api.baseURL + api.path
        let encoding: ParameterEncoding = api.method == .post ? JSONEncoding.default : URLEncoding.default
        let response = try await AF.request(
            url,
            method: api.method,
            parameters: api.parameters,
            encoding: encoding,
            headers: HTTPHeaders(api.headers)
        ).serializingDecodable(T.type).value

        return response
    }
}
