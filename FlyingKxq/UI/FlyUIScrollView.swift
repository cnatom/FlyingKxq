//
//  FlyUIScrollView.swift
//  FlyingKxq
//
//  Created by atom on 2025/1/2.
//

import SwiftUI
import UIKit
import SnapKit

struct FlyUIScrollView: View {
    var body: some View {
        Text("Hello")
    }
}

struct FlyUIScrollViewRepresentable: UIViewRepresentable {
    typealias UIViewType = UIScrollView
    
    // 监听上下滑动
    
    func makeUIView(context: Context) -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.delegate = context.coordinator
        return scrollView
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        
    }
    
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIScrollViewDelegate {
        var parent: FlyUIScrollViewRepresentable
        
        init(_ parent: FlyUIScrollViewRepresentable) {
            self.parent = parent
        }
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            
        }
    }
}




#Preview {
    FlyUIScrollView()
}
