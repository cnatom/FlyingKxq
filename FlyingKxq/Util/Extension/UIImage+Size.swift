//
//  UIImage+Size.swift
//  FlyingKxq
//
//  Created by atom on 2025/1/30.
//

import UIKit

extension UIImage {
    var sizeKB: CGFloat? {
        guard let data = self.jpegData(compressionQuality: 1.0) else { return nil }
        return CGFloat(data.count) / 1024.0
    }
}
