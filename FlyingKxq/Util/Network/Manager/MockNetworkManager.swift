//
//  MockNetworkManager.swift
//  FlyingKxq
//
//  Created by atom on 2025/1/6.
//
import Alamofire

class MockNetworkManager: NetworkManagerProtocol {
    func request<T: APIConfiguration>(api: T) async throws -> T.ResponseType where T: APIConfiguration {
        if let mockableAPI = api as? (any MockableAPI),
           let jsonData = mockableAPI.mockData.data(using: .utf8) {
            let response = try JSONDecoder().decode(T.ResponseType.self, from: jsonData)
            await Task.flySleep(1)
            return response
        }
        throw AFError.responseSerializationFailed(reason: .inputDataNilOrZeroLength)
    }
}
