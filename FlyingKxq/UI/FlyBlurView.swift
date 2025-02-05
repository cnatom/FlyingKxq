//
//  FlyBlurView.swift
//  FlyingKxq
//
//  Created by atom on 2025/1/3.
//

import SwiftUI

extension View {
    func flyBlurBackground(opacity: CGFloat = 1.0, tint: Color = .clear) -> some View {
        background {
            FlyBlurView(effect: .systemChromeMaterial, tint: tint)
                .opacity(opacity)
        }
    }
}

struct FlyBlurView: UIViewRepresentable {
    let effect: UIBlurEffect.Style
    let tint: Color
    
    init(effect: UIBlurEffect.Style = .systemChromeMaterial, tint: Color = .clear) {
        self.effect = effect
        self.tint = tint
    }
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: effect))
        
        // 添加颜色层
        let tintView = UIView()
        tintView.backgroundColor = UIColor(tint)
        tintView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.contentView.addSubview(tintView)
        
        // 设置混合模式
        tintView.layer.compositingFilter = "overlay"
        
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: effect)
        
        // 更新颜色层
        if let tintView = uiView.contentView.subviews.first {
            tintView.backgroundColor = UIColor(tint)
        }
    }
}

#Preview {
    ZStack(alignment: .topLeading) {
        Text("Back")
            .frame(width: 100, height: 100)
            .background(Color.accentColor)
        Text("Front")
            .frame(width: 100, height: 100)
            .flyBlurBackground(tint: .white.opacity(0.5)) // 使用白色半透明色调
            .padding(.leading, 50)
    }
}
