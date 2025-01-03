//
//  CGFloat+.swift
//  FlyingKxq
//
//  Created by atom on 2025/1/3.
//

import CoreGraphics
extension CGFloat {
    /// 判断当前 CGFloat 是否为整数
    var isInteger: Bool {
        return self.truncatingRemainder(dividingBy: 1) == 0
    }
    var toInteger: Int {
        return Int(self)
    }
}
