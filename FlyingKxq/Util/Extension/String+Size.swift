//
//  String+Size.swift
//  FlyingKxq
//
//  Created by atom on 2024/12/25.
//

import SwiftUI

extension String {
    func sizeOfFont(uiFont: UIFont) -> CGSize {
        let attributes = [NSAttributedString.Key.font: uiFont]
        let size = (self as NSString).size(withAttributes: attributes)
        return size
    }
}
