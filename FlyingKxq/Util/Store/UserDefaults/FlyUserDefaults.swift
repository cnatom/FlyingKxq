//
//  FlyUserDefaults.swift
//  FlyingKxq
//
//  Created by atom on 2025/1/7.
//

import Foundation

/// 封装的 UserDefaults 工具类
class FlyUserDefaults {
    static let shared = FlyUserDefaults()
    private let defaults = UserDefaults.standard

    private init() {}

    enum Key: String, CaseIterable {
        case isLoggedIn
        case newsType
    }

    func set<T>(_ value: T, for key: Key) {
        defaults.set(value, forKey: key.rawValue)
    }

    func get<T>(_ key: Key) -> T? {
        return defaults.object(forKey: key.rawValue) as? T
    }

    func remove(_ key: Key) {
        defaults.removeObject(forKey: key.rawValue)
    }

    func contains(_ key: Key) -> Bool {
        return defaults.object(forKey: key.rawValue) != nil
    }

    func clearAll() {
        for key in Key.allCases {
            defaults.removeObject(forKey: key.rawValue)
        }
    }
}
