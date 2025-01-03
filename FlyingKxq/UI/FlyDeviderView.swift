//
//  FlyDeviderView.swift
//  FlyingKxq
//
//  Created by atom on 2025/1/2.
//

import SwiftUI

enum FlyDeviderViewDirection {
    case vertical
    case horizontal
}

struct FlyDeviderView: View {
    let direction: FlyDeviderViewDirection

    init(direction: FlyDeviderViewDirection = .horizontal) {
        self.direction = direction
    }

    var body: some View {
        switch direction {
        case .vertical:
            Color.flyDevider
                .frame(width: 1)
                .frame(maxHeight: .infinity)
        case .horizontal:
            Color.flyDevider
                .frame(maxWidth: .infinity)
                .frame(height: 1)
        }
    }
}

#Preview {
    FlyDeviderView()
}
