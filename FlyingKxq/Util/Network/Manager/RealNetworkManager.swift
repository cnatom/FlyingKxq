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
        // 注入Token
        if api.injectToken {
            await AuthManager.shared.refreshTokenIfNeed()
        }
        let url = api.baseURL + api.path
        let parameters = api.parameters
        if api.parameterType == .form {
            // form-data
            let multipartFormData = MultipartFormData()
            for (key, value) in parameters {
                if let data = value as? Data {
                    // 判断这个Data的类型，按需配置
                    if let _ = UIImage(data: data) {
                        multipartFormData.append(data, withName: key,fileName: "image.jpg")
                    } else {
                        multipartFormData.append(data, withName: key)
                    }
                } else if let string = value as? String {
                    multipartFormData.append(Data(string.utf8), withName: key)
                }
            }
            let response = try await AF.upload(
                multipartFormData: multipartFormData,
                to: url,
                method: api.method,
                headers: HTTPHeaders(api.headers)
            ).serializingDecodable(T.type).value
            return response
        } else {
            // json or parameters
            let encoding: ParameterEncoding = api.method == .post ? JSONEncoding.default : URLEncoding.default
            let response = try await AF.request(
                url,
                method: api.method,
                parameters: parameters,
                encoding: encoding,
                headers: HTTPHeaders(api.headers)
            ).serializingDecodable(T.type).value

            return response
        }
    }
}
