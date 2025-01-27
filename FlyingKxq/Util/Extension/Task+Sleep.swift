//
//  Task+Sleep.swift
//  FlyingKxq
//
//  Created by atom on 2024/12/23.
//

import Foundation

extension Task where Success == Never, Failure == Never {
    static func flySleep(_ second: CGFloat) async {
        do {
            let nanoseconds = UInt64(second * 1_000_000_000)
            try await Self.sleep(nanoseconds: nanoseconds)
        } catch {
            print("延迟时发生错误：\(error)")
        }
    }
}
