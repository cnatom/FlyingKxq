//
//  NetworkManager.swift
//  FlyingKxq
//
//  Created by atom on 2024/12/20.
//

import Foundation
import Alamofire

class NetworkManager {
    static let shared: any NetworkManagerProtocol = MockNetworkManager()
    
    private init() {}
}
