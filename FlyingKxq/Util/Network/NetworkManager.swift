//
//  NetworkManager.swift
//  FlyingKxq
//
//  Created by atom on 2024/12/20.
//

import Foundation
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    func request<T: Decodable>(
        api: APIConfiguration,
        responseType: T.Type,
        completion: @escaping (Result<T, AFError>) -> Void
    ) {
        let url = api.baseURL + api.path
        AF.request(
            url,
            method: api.method,
            parameters: api.parameters,
            encoding: JSONEncoding.default,
            headers: HTTPHeaders(api.headers)
        ).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
    func request<T: Decodable>(
        api: APIConfiguration,
        responseType: T.Type
    ) async throws -> T {
        let url = api.baseURL + api.path
        
        return try await AF.request(
            url,
            method: api.method,
            parameters: api.parameters,
            encoding: JSONEncoding.default,
            headers: HTTPHeaders(api.headers)
        ).serializingDecodable(T.self).value
    }
    
}
