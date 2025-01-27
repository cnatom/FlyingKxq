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
           let mockData = mockableAPI.mockData as? T.ResponseType {
            await Task.flySleep(1)
            return mockData
        }
        throw AFError.responseSerializationFailed(reason: .inputDataNilOrZeroLength)
    }
}
