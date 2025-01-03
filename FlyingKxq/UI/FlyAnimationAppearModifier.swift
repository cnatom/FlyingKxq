//
//  FlyAnimationAppearModifier.swift
//  FlyingKxq
//
//  Created by atom on 2024/12/23.
//

import SwiftUI

struct FlyAnimationAppearModifier: ViewModifier {
    @State private var isVisible = false
    let offset: CGFloat
    let delay: Double
    let alignment: Alignment
    
    func body(content: Content) -> some View {
        content
            .opacity(isVisible ? 1 : 0)
            .offset(alignmentOffset())
            .animation(.easeInOut.delay(delay), value: isVisible)
            .onAppear {
                isVisible = true
            }
    }
    
    private func alignmentOffset() -> CGSize {
        let horizontalOffset = alignment == .leading || alignment == .topLeading || alignment == .bottomLeading ? -offset :
        alignment == .trailing || alignment == .topTrailing || alignment == .bottomTrailing ? offset : 0
        
        let verticalOffset = alignment == .top || alignment == .topLeading || alignment == .topTrailing ? -offset :
        alignment == .bottom || alignment == .bottomLeading || alignment == .bottomTrailing ? offset : 0
        
        return isVisible ? .zero : CGSize(width: horizontalOffset, height: verticalOffset)
    }
}

extension View {
    func flyAnimationAppear(
        offset: CGFloat = 50,
        delay: Double = 0,
        alignment: Alignment = .trailing
    ) -> some View {
        self.modifier(FlyAnimationAppearModifier(offset: offset, delay: delay, alignment: alignment))
    }
}
