//
//  Task+Sleep.swift
//  FlyingKxq
//
//  Created by atom on 2024/12/23.
//

import Foundation

extension Task where Success == Never, Failure == Never {
    static func sleep (_ second: UInt64) async {
        do {
            try await Self.sleep(nanoseconds: second * 1_000_000_000)
        } catch {
            print("延迟时发生错误：\(error)")
        }
    }
}
