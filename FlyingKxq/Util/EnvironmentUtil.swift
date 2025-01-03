//
//  EnvironmentUtil.swift
//  FlyingKxq
//
//  Created by atom on 2024/12/23.
//

import Foundation

struct EnvironmentUtil {
    static func isTestEnvironment() -> Bool {
        return ProcessInfo.processInfo.environment["TEST_ENVIRONMENT"] == "true"
    }
    static func useMockData() -> Bool {
        return ProcessInfo.processInfo.environment["USE_MOCK"] == "true"
    }
}
