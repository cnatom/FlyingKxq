//
//  FlyKeyChain.swift
//  FlyingKxq
//
//  Created by atom on 2025/1/7.
//

import Foundation
import Security

enum FlyKeyChainType: String{
    case token = "com.atcumt.kxq.token"
    case refreshToken = "com.atcumt.kxq.refreshToken"
}

class FlyKeyChain {
    static let shared = FlyKeyChain()

    private init() {}
    
    func saveToken(accessToken: String?,refreshToken: String?) {
        if let token = accessToken{
            save(key: .token, value: token)
        }
        if let refreshToken = refreshToken{
            save(key: .refreshToken, value: refreshToken)
        }
    }

    /// 保存或更新 Keychain 数据
    func save(key: FlyKeyChainType, value: String) {
        guard let data = value.data(using: .utf8) else { return }

        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key.rawValue,
        ]

        let attributesToUpdate: [String: Any] = [
            kSecValueData as String: data,
        ]

        // 尝试更新已有值
        if SecItemUpdate(query as CFDictionary, attributesToUpdate as CFDictionary) == errSecSuccess {
            print("Keychain item updated. \(key.rawValue)")
        } else {
            // 如果更新失败，则添加新值
            let newQuery = query.merging(attributesToUpdate) { $1 }
            SecItemAdd(newQuery as CFDictionary, nil)
            print("Keychain item added. \(key.rawValue)")
        }
    }

    /// 读取 Keychain 数据
    func read(key: FlyKeyChainType) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key.rawValue,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne,
        ]

        var result: AnyObject?
        SecItemCopyMatching(query as CFDictionary, &result)

        guard let data = result as? Data else { return nil }
        return String(data: data, encoding: .utf8)
    }

    /// 删除 Keychain 数据
    func delete(key: FlyKeyChainType) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key.rawValue,
        ]

        SecItemDelete(query as CFDictionary)
    }
}
