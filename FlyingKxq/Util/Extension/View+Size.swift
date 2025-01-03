//
//  View+Size.swift
//  FlyingKxq
//
//  Created by atom on 2024/12/25.
//

import SwiftUI

extension View {
    var safeAreaInsets: UIEdgeInsets {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else {
            return .zero
        }
        return window.safeAreaInsets
    }

    var screenSize: CGSize {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else {
            return .zero
        }
        return window.bounds.size
    }

    func onSizeAppear(_ action: @escaping (CGSize) -> Void) -> some View {
        background(GeometryReader { geometry in
            Color.clear
                .onAppear {
                    action(geometry.size)
                }
        })
    }

    func onSizeChange(_ action: @escaping (CGSize) -> Void) -> some View {
        background(GeometryReader { geometry in
            Color.clear
                .onChange(of: geometry.size) { size in
                    action(size)
                }
        })
    }

    func onFrameChange(in coordinateSpace: CoordinateSpace = .global, _ action: @escaping (CGRect) -> Void) -> some View {
        background(GeometryReader { geometry in
            Color.clear
                .frame(maxWidth: 0, maxHeight: 0)
                .onChange(of: geometry.frame(in: coordinateSpace)) { frame in
                    action(frame)
                }
        })
    }
}
