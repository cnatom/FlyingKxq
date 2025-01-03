//
//  FlyBlurView.swift
//  FlyingKxq
//
//  Created by atom on 2025/1/3.
//

import SwiftUI

extension View {
    func flyBlurBackground() -> some View {
        background {
            FlyBlurView(effect: .systemChromeMaterial)
        }
    }
}

struct FlyBlurView: UIViewRepresentable {
    let effect: UIBlurEffect.Style

    init(effect: UIBlurEffect.Style = .systemChromeMaterial) {
        self.effect = effect
    }

    func makeUIView(context: Context) -> UIVisualEffectView {
        UIVisualEffectView(effect: UIBlurEffect(style: effect))
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: effect)
    }
}

#Preview {
    ZStack(alignment: .topLeading) {
        Text("Back")
            .frame(width: 100, height: 100)
            .background(Color.accentColor)
        Text("Front")
            .frame(width: 100, height: 100)
            .flyBlurBackground()
            .padding(.leading, 50)
    }
}
