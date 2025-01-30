//
//  UIImage+Compress.swift
//  FlyingKxq
//
//  Created by atom on 2025/1/30.
//

import UIKit

extension UIImage {
    /// 尽可能压缩图片到指定大小, 返回 Data
    /// - Parameters:
    ///  - targetKB: 目标大小, 单位 KB
    ///  - tolerance: 允许的误差范围, 默认 0.02
    ///  - Returns: 压缩后的图片 Data
    ///  - Note: 二分查找压缩质量
    func compress(to targetKB: Int, tolerance: CGFloat = 0.02) async -> Data? {
        return await withCheckedContinuation {continuation in
            DispatchQueue.global(qos: .userInitiated).async {
                let aimSize = Double(targetKB * 1024) * (1 + Double(tolerance))
                var maxQuality: CGFloat = 1.0
                let minQuality: CGFloat = 0.0
                var result: Data?
                
                // 最多 20 次二分查找，或当区间足够小时停止
                for index in 0 ..< 20 {
                    let quality = (maxQuality + minQuality) / 2
                    guard let data = self.jpegData(compressionQuality: quality) else { break }
                    let compressedSize = Double(data.count)
                    print("第 \(index) 次压缩，大小 \(compressedSize / 1024) KB")
                    if compressedSize <= aimSize {
                        // 允许一定误差，记录结果并尝试更高质量
                        result = data
                        break
                    } else {
                        maxQuality = quality
                    }
                    if index == 19 {
                        // 最多 20 次二分查找，或当区间足够小时停止
                        result = data
                    }
                }
                continuation.resume(returning: result)
            }
        }
        
    }
}
