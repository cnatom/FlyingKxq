//
//  SVGImageView.swift
//  FlyingKxq
//
//  Created by atom on 2024/12/17.
//

import SwiftUI
import SVGKit

// 将 SVGKFastImageView 封装为 SwiftUI 视图
struct SVGImageView: UIViewRepresentable {
    let svgName: String
    
    func makeUIView(context: Context) -> SVGKFastImageView {
        let svgImage = SVGKImage(named: svgName) // 加载 SVG 文件
        let imageView = SVGKFastImageView(svgkImage: svgImage)
        imageView?.contentMode = .scaleAspectFit // 内容适配
        return imageView ?? SVGKFastImageView()
    }
    
    func updateUIView(_ uiView: SVGKFastImageView, context: Context) {
        // 如果需要更新视图，可以在这里添加逻辑
    }
}

struct SvgImageTest: View {
    var body: some View {
        SVGImageView(svgName: "QQLogo")
    }
}

#Preview {
    SvgImageTest()
}
